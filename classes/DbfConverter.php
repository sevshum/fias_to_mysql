<?php

namespace B3;


/**
 *	Convert DBF files to other db file
 *  contact:
 *
 *	USAGE:
 *		$filename = "dir/file.dbf";
 *		//save a file.sql in actual folder
 *		DbfConverter::saveSQL($filename, $tablesArray);
 *
 */
class DbfConverter extends Converter
{
    const LOG_NAME = 'DBF_CONVERTER';


    const DNORDOC_TABLE = 'DNORDOC';
    //just in case. This field is memo dbf field. It saved in DNORDOC.DBT. dbase extension does not work with memo
//    const DNORDOC_MEMO_FIELD = 'DOCNAME';
    const LANDMARK_TABLE = 'LANDMARK';
    //just in case. This field is memo dbf field. It saved in LANDMARK.DBT. dbase extension does not work with memo
//    const LANDMARK_MEMO_FIELD = 'LOCATION'; //just in case

    private function __construct($file, $tablesArray)
    {
        $this->_initConstr($file, $tablesArray);
    }

    protected function getNameOnly()
    {

        $nameFull = explode("/", $this->archive);
        $nameFull = $nameFull[count($nameFull) - 1];
        $nameFull = explode(".", $nameFull);
        return $nameFull[0];
    }

    protected function getTableName()
    {

        $nameFull = explode("/", $this->archive);
        $nameFull = $nameFull[count($nameFull) - 1];
        $nameFull = explode(".", $nameFull);
        return preg_replace('/\d+$/u', '', $nameFull[0]);
    }

    protected function getChangedTableName()
    {
        if (!isset($this->tablesArray[$this->tableName]['name'])) {
            $message = "Table not found in tablesArray. Please check config.php file for names of tables for " . $this->tableName . "\n";
            $this->log->error($message);
            echo $message;
            return false;
        }
        return $this->tablesArray[$this->tableName]['name'];
    }

    public static function saveSQL($archive, $tablesArray, $toDir)
    {
        $dbf2sql = new self($archive, $tablesArray);
        if ($dbf2sql->convert()) {
            $dbf2sql->saveToFile($toDir);
        }
    }

    /*
     * We verified that we have the library to work with dBase files
     *
     */
    protected function convert()
    {
        if ($this->dBaseOk()) {
            /* verify that the file exists */
            if (is_file($this->archive) && is_readable($this->archive)) {
                /* If everything is Ok we open the file to work on */
                $this->archive = dbase_open($this->archive, 0);
                /* get the number of fields */
                $this->fieldsCount = dbase_numfields($this->archive);
                /* get the number of records */
                $this->recordsCount = dbase_numrecords($this->archive);
                /* get the titles of the fields */
                $this->fieldsTitiles = dbase_get_header_info($this->archive);
                if ($this->tablesArray[$this->tableName]['del_where_col']) {
                    return $this->convert2SqlDel();
                } else {
                    return $this->convert2Sql();
                }

            } else {
                $message = "The file '" . $this->name . "' does not exist or does not have read permissions\n";
                $this->log->error($message);
                echo $message;
                return false;
            }
        } else {
            $message = "You need the 'dbase' library to be able to convert DBF files\n";
            $this->log->error($message);
            echo $message;
            return false;
        }
    }

    /*
     * With this function check if there is the library needed to work with DBF files
     */
    protected function dBaseOk()
    {
        /* get the libraries compiled in PHP */
        $libraries = get_loaded_extensions();
        /* run the libraries to check if dbase exists*/
        foreach ($libraries as $library)
            if (strtolower($library) == "dbase") {
                return true;
            }
        return false;
    }

    protected function convert2Sql()
    {
        $this->createHeader();
        if (!$this->createTable()) {
            return false;
        }

        if (!$this->createRecords()) {
            return false;
        }

        /* close the DBF file */
        if (!$this->closeDbf()) {
            return false;
        }

        $this->createFooter();
        return true;
    }

    protected function convert2SqlDel()
    {
        $this->createHeader();

        if (!$this->createRecordsDel()) {
            return false;
        }

        /* close the DBF file */
        if (!$this->closeDbf()) {
            return false;
        }

        $this->createFooter();
        return true;
    }



    protected function closeDbf()
    {
        if (!dbase_close($this->archive)) {
            return false;
        }
        return true;
    }




    protected function dumpRecords()
    {
        $this->insertLine = "INSERT IGNORE INTO `" . $this->changedTableName . "` (" . $this->removeSpaceFromLine($this->fieldNamesStr) . ") VALUES ";
        $this->addToOutput($this->insertLine);
        $pk = '';
        if ($this->tablesArray[$this->tableName]['pk_id']) {
            $pk = "Null,";
        }
        /* walk the records */
        $itCount = 0;
        for ($i = 1; $i <= $this->recordsCount; $i++) {
            if ($itCount >= self::MAX_INSERT_LINES) {
                $this->insertLine = "INSERT IGNORE INTO `" . $this->changedTableName . "` (" . $this->removeSpaceFromLine($this->fieldNamesStr) . ") VALUES ";
                $this->insertLine .= " ($pk";
                $itCount = 0;
            } else {
                /*create the INSERT line. We use IGNORE to avoid duplicate record problems */
                $this->insertLine = " ($pk";
            }

            if (!$this->getRecord($i)) {
                return false;
            }

            /* For each record we have to go through all the fields */
            for ($j = 0; $j < $this->fieldsCount; $j++) {
                /* remove the rare characters from the registry*/
                $this->removeCharacters($j);
                /*  add the field to the INSERT line */
                $this->addItem($j);
            }
            if ($itCount >= self::MAX_INSERT_LINES - 1) {
                $this->insertLine = $this->removeSpaceFromLine($this->insertLine);
                $this->insertLine .= ");";
            } else {
                $this->insertLine = $this->removeSpaceFromLine($this->insertLine);
                $this->insertLine .= "),";
            }

            if ($i === $this->recordsCount) {
                $this->insertLine = $this->removeSpaceFromLine($this->insertLine);
                /*  finish the INSERT line*/
                $this->insertLine .= ");";
            }
            $this->addToOutput($this->insertLine);
            $itCount++;
        }


//        $this->addToOutput($this->insertLine);
        return true;
    }



    protected function addItem($index)
    {
        /* add the item to the INSERT string */
        switch ($this->fieldsTitiles[$index]['type']) {
            case "character":
            case "memo":
            case "date":
                /* If the data type is alphanumeric we store it in quotation marks '' */
                $this->insertLine .= "'" . $this->record[$index] . "', ";
                break;
            default:
                /* If the record type is not alphanumeric we store the raw value */
                $this->insertLine .= $this->record[$index] . ", ";
                break;
        }
    }

    protected function removeCharacters($index) {
        switch ($this->fieldsTitiles[$index]['type']) {
            case "character":
            case "memo":
                /* If the data type is alphanumeric we convert the possible characters that affect*/
                /* convert apostrophes, accents and backslashes */

//                $encoding = mb_detect_encoding($this->record[$index], array('cp866'));
                $encoding = mb_detect_encoding($this->record[$index], array('windows-1251')); // for nordoc.dbf decode
                $this->record[$index] = iconv($encoding,'UTF-8//TRANSLIT//IGNORE',$this->record[$index]);
                $this->record[$index] = str_replace("'","&apos;",$this->record[$index]);
                $this->record[$index] = str_replace("\"","&quot;",$this->record[$index]);
                $this->record[$index] = str_replace("`","&#096;",$this->record[$index]);
                $this->record[$index] = str_replace("´","&acute;",$this->record[$index]);
                $this->record[$index] = str_replace("\\","&#092;",$this->record[$index]);

                /* convert rare characters to HTML characters */
//                $this->record[$index] = strtr($this->record[$index], get_html_translation_table(HTML_ENTITIES));
                /*transform the enter into <BR> */
//                $this->record[$index] = nl2br($this->record[$index]);
                /* remove the blanks */
                $this->record[$index] = trim($this->record[$index]);
                return true;
                break;
            case "date":
                /* If the data type is date we format it for MySQL */
                return $this->groupDate($index);
                break;
            default:
                return true;
        }
    }

    protected function groupDate($index) {
        /* We separate the year month and date from the date to convert it into MySQL. Ex: '20090201' -> '2009-02-01' */
        $year = substr($this->record[$index],0,4);
        $month = substr($this->record[$index],4,2);
        $day = substr($this->record[$index],6,2);

        /*  set the date string in MySQL */
//        $validate = "$year-$month-$day";

        /* remove the spaces and character '-' */
        $validate = str_replace("-","",$this->record[$index]);
        $validate = str_replace(" ","",$validate);

        /* Check if it has value */
        if (strlen($validate) == 8) {
            /* If it has a value we check if it is a correct date */
            if (!checkdate($month,$day,$year)) {
                /* If it is not a correct date we show an error and return false */
                $message = "The date of the $index record is not valid. Value: ' '" . $this->record[$index] . "'\n";
                $this->log->error($message);
                echo $message;
                return false;
            } else {
                $this->record[$index] = "$year-$month-$day";
                return True;
            }
        } elseif (strlen($validate) == 0) {
            /* If it does not have value we return true */
            $this->record[$index] = "";
            return true;
        } else {
            /* If you have any value that is not 8 digits is an incorrect date */
            $message = "The date of the $index record is not valid. Value: '" . $this->record[$index] . "' \n";
            $this->log->error($message);
            echo $message;
            return false;
        }
    }

    protected function getRecord($index) {
        $this->record = dbase_get_record($this->archive, $index);
        if (!$this->record) {
            $message = "Failed to get record. \n";
            $this->log->error($message);
            echo $message;
            return false;
        }

        if($this->tableName === self::DNORDOC_TABLE) {
            array_splice($this->record, 1, 0, '');
        } elseif($this->tableName === self::LANDMARK_TABLE) {
            array_splice($this->record, 5, 0, '');
        }
        return true;
    }

    /**
     * Handles the specified request.
     * @param int $index the index of record
     * @return boolean succession of result
     */
    protected function getRecordDel($index) {
        $this->record = dbase_get_record_with_names($this->archive, $index);
        if (!$this->record) {
            $message = "Failed to get record. \n";
            $this->log->error($message);
            echo $message;
            return false;
        }
        return true;
    }

    protected function dumpRecordsDel()
    {
        $delColDbf = $this->tablesArray[$this->tableName]['del_where_col'];
        $this->insertLine = "DELETE FROM `" . $this->changedTableName . "` WHERE " . $this->tablesArray[$this->tableName]['rowsArray'][$delColDbf] . " IN (";
        $this->addToOutput($this->insertLine);
        for ($i = 1; $i <= $this->recordsCount; $i++) {
            if (!$this->getRecordDel($i)) {
                return false;
            }
            $this->insertLine = "'" . $this->record[$delColDbf] . "', ";

            if ($i === $this->recordsCount) {
                $this->insertLine = $this->removeSpaceFromLine($this->insertLine);
                /*  finish the INSERT line*/
                $this->insertLine .= ");";
            }
            $this->addToOutput($this->insertLine);
        }
//        $this->addToOutput($this->insertLine);
        return true;
    }

    /*
     * create the table
     *  
     */
    protected function createTable()
    {
        $tableName = $this->changedTableName;
        $pk = "";
        //create primary key by table name and '_id' suffix
        if ($this->tablesArray[$this->tableName]['pk_id']) {
            $primaryId = $tableName . '_id';
            $this->fieldNamesStr .= $primaryId . ', ';
            $pk = "`$primaryId` bigint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY";
        }

        /* create the initial line of CREATE TABLE */
        $table = "CREATE TABLE IF NOT EXISTS $tableName ($pk";
        /* We verified that there taken values */
        if ($tableName == "") {
            $message = "The header was not created correctly \n";
            $this->log->error($message);
            echo $message;
            return false;
        }
        /* cross the fields taking the name of each one and its type */
        for ($i = 0; $i < $this->fieldsCount; $i++) {
            /* get the field data */
            $field = $this->fieldsTitiles[$i];
            /* get the name from the data field */
            $fieldName = $this->getFieldName($field['name']);
//            $fieldName = strtolower($field['name']);
            /* get the type from the data field */
            $fieldType = $this->getFieldType($field['type']);
            /* verify values*/
            if (!$fieldName || $fieldType == "") {
                $message = "One of the fields was not created correctly\n";
                $this->log->error($message);
                echo $message;
                return false;
            }
            if ($i === 0 && $pk === '') {
                /* set up the field type */
                $table .= " `$fieldName` $fieldType ";
            } else {
                $table .= ", `$fieldName` $fieldType ";
            }

            $this->fieldNamesStr .= "$fieldName, ";
        }
        $table .= ");";

        $this->addToOutput($table);
        return true;
    }

    protected function getFieldName($name)
    {
        if (!isset($this->tablesArray[$this->tableName]['rowsArray'][$name])) {
            $message = "Field not found in rowsArray. Please check config.php file for names of rows for " . $name . " in table " . $this->tableName . "\n";
            $this->log->error($message);
            echo $message;
            return false;
        }
        return $this->tablesArray[$this->tableName]['rowsArray'][$name];
    }

    protected function getFieldType($type)
    {
        switch($type) {
            case 'number':
                $type = 'int(11)';
                break;
            case 'date':
                $type = 'date';
                break;
            case 'character':
                $type = 'varchar(250)';
                break;
            case 'boolean':
                $type = 'binary(1)';
                break;
            case 'memo':
                $type = 'longtext';
                break;
        }
        return $type;
    }


}
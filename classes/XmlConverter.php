<?php

namespace B3;

/**
 *	Convert XML files to other db file
 *  contact:
 *
 *	USAGE:
 *		$filename = "dir/file.xml";
 *		//save a file.sql in actual folder
 *		XmlConverter::saveSQL($filename, $tablesArray);
 *
 */
class XmlConverter extends Converter 
{
    const LOG_NAME = 'XML_CONVERTER';

    private function __construct($file, $tablesArray)
    {
        $this->_initConstr($file, $tablesArray);
    }

    protected function getNameOnly()
    {
        $tables = array_keys($this->tablesArray);
        foreach ($tables as $table) {
            if (stripos($this->archive, $table . '_') !== false) {
                return $table;
            }
        }
        $message = "No such table in conf tableXmlArray \n";
        $this->log->error($message);
        echo $message;
        return false;

    }

    protected function getTableName()
    {
        return $this->getNameOnly();

    }

    protected function getChangedTableName()
    {
        $tables = array_keys($this->tablesArray);
        foreach ($tables as $table) {
            if (stripos($this->archive, $table) !== false) {
                return $this->tablesArray[$table]['name'];
            }
        }
        $message = "No such table in conf tableXmlArray \n";
        $this->log->error($message);
        echo $message;
        return false;

    }

//    protected function getTableNameXml()
//    {
//        $tables = array_keys($this->tablesArray);
//        foreach ($tables as $table) {
//            if (stripos($this->archive, $table) !== false) {
//                return $this->tablesArray[$table]['name_xml'];
//            }
//        }
//        $message = "No such table in conf tableXmlArray \n";
//        $this->log->error($message);
//        echo $message;
//        return false;
//
//    }

    public static function saveSQL($archive, $tablesArray, $toDir)
    {
        $xml2sql = new self($archive, $tablesArray);
        if ($xml2sql->convert()) {
            $xml2sql->saveToFile($toDir);
        }
    }

    /*
    * We verified that we have the library to work with dBase files
    *
    */
    protected function convert()
    {
        /* verify that the file exists */
        if (is_file($this->archive) && is_readable($this->archive)) {
            /* If everything is Ok we open the file to work on */
            $this->archive = simplexml_load_file($this->archive);
            if (!$this->handleFields()) {
                return false;
            }
            /* get the number of records */
            $this->recordsCount = $this->archive->count();
            /* get the titles of the fields */
//            $this->fieldsTitiles = dbase_get_header_info($this->archive);
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

    }


    public function handleFields()
    {
        if ($this->tablesArray[$this->name]['pk_id']) {
            $primaryId = $this->changedTableName . '_id';
            $this->fieldNamesStr .= $primaryId . ', ';
        }
        //check fields with our array in config
        foreach($this->archive->children()[0]->attributes() as $a => $b) {
            //field isset in array
            if (!isset($this->tablesArray[$this->name]['rowsArray'][$a])) {
                $message = "Field not found in rowsArray. Please check config.php file for names of rows for " . $a . " in table " . $this->name . "\n";
                $this->log->error($message);
                echo $message;
                return false;
            }
        }

        if (isset($this->tablesArray[$this->name]['rowsArray'])) {
            foreach ($this->tablesArray[$this->name]['rowsArray'] as $value) {
                $this->fieldNamesStr .= "$value, ";
            }
        }
        return true;
    }

    protected function convert2Sql()
    {
        $this->createHeader();

        if (!$this->createRecords()) {
            return false;
        }

        /* close the Xml file */
        $this->closeXml();

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
        $this->closeXml();

        $this->createFooter();
        return true;
    }

    protected function dumpRecordsDel()
    {
        $delColDbf = $this->tablesArray[$this->tableName]['del_where_col'];
        $this->insertLine = "DELETE FROM `" . $this->changedTableName . "` WHERE " . $this->tablesArray[$this->tableName]['rowsArray'][$delColDbf] . " IN (";
        $this->addToOutput($this->insertLine);
        $i= 0;
        foreach ($this->archive as $item) {
            $i++;
            if (isset($item->attributes()[$delColDbf])) {
                $this->insertLine = "'" . $item->attributes()[$delColDbf] . "', ";
            } else {
                $message = "Value in 'del_where_col' not found in xml element item. Please check config.php file for names in table " . $this->name . "\n";
                $this->log->error($message);
                echo $message;
                return false;
            }

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

    protected function closeXml()
    {
        $this->archive = null;
    }

    protected function dumpRecords()
    {
        $this->insertLine = "INSERT IGNORE INTO `" . $this->changedTableName . "` (" . $this->removeSpaceFromLine($this->fieldNamesStr) . ") VALUES ";
        $this->addToOutput($this->insertLine);
        $pk = '';
        if ($this->tablesArray[$this->name]['pk_id']) {
            $pk = "Null,";
        }
        /* walk the records */
        $itCount = 0;
        $i= 0;
        foreach ($this->archive as $item) {
            $i++;
            if ($itCount >= self::MAX_INSERT_LINES) {
                $this->insertLine = "INSERT IGNORE INTO `" . $this->changedTableName . "` (" . $this->removeSpaceFromLine($this->fieldNamesStr) . ") VALUES ";
                $this->insertLine .= " ($pk";
                $itCount = 0;
            } else {
                /*create the INSERT line. We use IGNORE to avoid duplicate record problems */
                $this->insertLine = " ($pk";
            }

//            if (!$this->getRecord($i)) {
//                return false;
//            }
            foreach ($this->tablesArray[$this->name]['rowsArray'] as $name => $value) {
                if (isset($item->attributes()[$name])) {
                    $this->addItem($item->attributes()[$name]);
                } else {
                    $this->addItem('');
                }
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

        return true;
    }

    protected function addItem($value)
    {
        /* If the data type is alphanumeric we store it in quotation marks '' */
        $this->insertLine .= "'" . $value . "', ";

    }


}
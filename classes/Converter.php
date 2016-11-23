<?php
/**
 * Created by PhpStorm.
 * User: tol
 * Date: 23.11.16
 * Time: 12:43
 */

namespace B3;


use Monolog\Handler\StreamHandler;
use Monolog\Logger;

abstract class Converter
{
    const LOG_NAME = 'DBF_CONVERTER';
    const LOG_PATH = '../runtime/app.log';

    const MAX_INSERT_LINES = 5000;

    protected $archive = "";
    //name of file without extension
    protected $name	= "";
    //table name in fias db
    protected $tableName	= "";
    //Table name in our db
    protected $changedTableName	= "";
    protected $size	= 0;
    protected $fieldsCount = 0;
    protected $recordsCount = 0;
    protected $fieldsTitiles = [];
    protected $outputSQL = [];
    protected $time	= 0;

    protected $insertLine;
    protected $record;
    protected $fileName;
    protected $fieldNamesStr = '';
    protected $log;

    //to convert tables and rows names
    protected $tablesArray = [];

    abstract protected function getNameOnly();

    abstract protected function getTableName();

    abstract protected function getChangedTableName();

    abstract protected function dumpRecords();

    protected function _initConstr($file, $tablesArray)
    {
        // create a log channel
        $this->log = new Logger(static::LOG_NAME);
        $this->log->pushHandler(new StreamHandler(self::LOG_PATH, Logger::WARNING));
//        $this->log->pushHandler(new NativeMailerHandler(
//            'me@example.com',
//            'Fias logging. Error occured!',
//            'Fias logging'
//        ));


        $this->tablesArray = $tablesArray;
        $this->archive = $file;
        $this->name = $this->getNameOnly();
        $this->tableName = $this->getTableName();
        $this->changedTableName = $this->getChangedTableName();
        $this->size = filesize($this->archive);
        $this->time = $this->getFullTime();
    }

    protected function getFullTime()
    {
        $time = explode(" ",microtime());
        return $time[1] + $time[0];
    }

    protected function createRecords()
    {
        /* add a header */
        $this->createTableHeader();
        $this->lockTable();

        if (!$this->dumpRecords()) {
            return false;
        }

        /* unlock table */
        $this->unlockTable();
        return True;
    }

    protected function createTableHeader()
    {
        $this->addToOutput("");
        $this->addToOutput("--");
        $this->addToOutput("-- Dumping data for the table " . $this->changedTableName);
        $this->addToOutput("--");
        $this->addToOutput("");
    }

    protected function lockTable() {
        $this->addToOutput("LOCK TABLES `" . $this->changedTableName . "` WRITE;");
    }

    protected function unlockTable()
    {
        $this->addToOutput("UNLOCK TABLES;");
    }

    protected function removeSpaceFromLine($line)
    {
        /* We remove the comma and space ',' left over in the string */
        return substr($line,0,(strlen($line) - 2));
    }

    /*
     * create the header of the SQL file
     */
    protected function createHeader()
    {
        $this->addToOutput("--");
        $this->addToOutput("");
        $this->addToOutput("/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;");
        $this->addToOutput("/*!40103 SET TIME_ZONE='+00:00' */;");
        $this->addToOutput("/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;");
        $this->addToOutput("/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;");
        $this->addToOutput("/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;");
        $this->addToOutput("/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;");
        $this->addToOutput("");
    }

    protected function createFooter()
    {
        $this->addToOutput("/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;");
        $this->addToOutput("");
        $this->addToOutput("/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;");
        $this->addToOutput("/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;");
        $this->addToOutput("/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;");
        $this->addToOutput("/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;");
        $this->addToOutput("");
        $this->addToOutput("-- Conversion completed. " . date("Y-m-d H:i:s"));
        $this->addToOutput("-- Duration of conversion: " . $this->totalTime());
    }

    protected function totalTime()
    {
        $this->time = $this->getFullTime() - $this->time;
        return number_format($this->time,4,",",".") . " seconds";
    }

    /*
     * add a line to the SQL output
     *
     */
    protected function addToOutput($line)
    {

        $this->outputSQL[] = $line;
    }
}
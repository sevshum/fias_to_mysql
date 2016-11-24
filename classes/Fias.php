<?php

namespace B3;


use DateTime;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use PDO;
use PDOException;

class Fias
{
    const LOG_NAME = 'FIAS_CLASS';
    const LOG_PATH = __DIR__ . '/../runtime/app.log';

    const ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/';
    const VER_DATE_ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt';
    const DBF_DELTA_ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/fias_delta_dbf.rar';
    const XML_DELTA_ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/fias_delta_xml.rar';

    const TYPE_DBF = 'DBF';
    const TYPE_XML = 'XML';

    const INPUT_DIR_DBF = __DIR__ . '/../../dbf/';
    const INPUT_DIR_XML = __DIR__ . '/../../fias_xml/';
    const OUTPUT_DIR_DBF = __DIR__ . '/../output/';
    const OUTPUT_DIR_XML = __DIR__ . '/../output_from_xml/';

    const INPUT_DIR_DBF_DELTA = __DIR__ . '/../dbf_delta/';
    const INPUT_DIR_XML_DELTA = __DIR__ . '/../fias_xml_delta/';
    const FILE_NAME_XML_DELTA = __DIR__ . '/../fias_xml_delta/fias_delta_xml.rar';
    const OUTPUT_DIR_DBF_DELTA = __DIR__ . '/../output_delta/';
    const FILE_NAME_DBF_DELTA = __DIR__ . '/../dbf_delta/fias_delta_dbf.rar';
    const OUTPUT_DIR_XML_DELTA = __DIR__ . '/../output_from_xml_delta/';

    const TABLE_ACTSTAT = 'ACTS';
    const TABLE_ADDROBJ = 'ADDR';
    const TABLE_DADDROBJ = 'DADD';
    const TABLE_CENTERST = 'CENT';
    const TABLE_CURENTST = 'CURE';
    const TABLE_DHOUSE = 'DHOUSE.';
    const TABLE_DHOUSEINT = 'DHOUSINT';
    const TABLE_DNORDOC = 'DNOR';
    const TABLE_ESTSTAT = 'ESTS';
    const TABLE_HOUSE = 'HOUS';
    const TABLE_HOUSEINT = 'HOUSEINT';
    const TABLE_HSTSTAT = 'HSTS';
    const TABLE_INTVSTAT = 'INTV';
    const TABLE_LANDMARK = 'LAND';
    const TABLE_NDOCTYPE = 'NDOC';
    const TABLE_NORDOC = 'NORD';
    const TABLE_OPERSTATE = 'OPER';
    const TABLE_ROOM = 'ROOM';
    const TABLE_SOCRBASE = 'SOCR';
    const TABLE_STEAD = 'STEA';
    const TABLE_STRSTAT = 'STRS';

    const TABLE_XML_ACTSTAT = 'AS_ACTS';
    const TABLE_XML_ADDROBJ = 'AS_ADDR';
    const TABLE_XML_DADDROBJ = 'AS_DEL_ADDROBJ';
    const TABLE_XML_CENTERST = 'AS_CENT';
    const TABLE_XML_CURENTST = 'AS_CURE';
    const TABLE_XML_DHOUSE = 'AS_DEL_HOUSE';
    const TABLE_XML_DHOUSEINT = 'AS_DEL_HOUSEINT';
    const TABLE_XML_DNORDOC = 'AS_DEL_NORMDOC';
    const TABLE_XML_ESTSTAT = 'AS_ESTS';
    const TABLE_XML_HOUSE = 'AS_HOUS';
    const TABLE_XML_HOUSEINT = 'AS_HOUSEINT';
    const TABLE_XML_HSTSTAT = 'AS_HSTS';
    const TABLE_XML_INTVSTAT = 'AS_INTV';
    const TABLE_XML_LANDMARK = 'AS_LAND';
    const TABLE_XML_NDOCTYPE = 'AS_NDOC';
    const TABLE_XML_NORDOC = 'AS_NORM';
    const TABLE_XML_OPERSTATE = 'AS_OPER';
    const TABLE_XML_ROOM = 'AS_ROOM';
    const TABLE_XML_SOCRBASE = 'AS_SOCR';
    const TABLE_XML_STEAD = 'AS_STEA';
    const TABLE_XML_STRSTAT = 'AS_STRS';

    private $conf;
    protected $pdo;
    protected $currentFile;
    protected $currentDir;
    protected $log;

    public function __construct($conf)
    {
        // create a log channel
        $this->log = new Logger(self::LOG_NAME);
        $this->log->pushHandler(new StreamHandler(self::LOG_PATH));
//        $this->log->pushHandler(new NativeMailerHandler(
//            'me@example.com',
//            'Fias logging. Error occured!',
//            'Fias logging'
//        ));
        $this->conf = $conf;
    }

    public function convertMainDBXml()
    {
        $files = scandir(self::INPUT_DIR_XML);
        foreach ($files as $file) {
//            $this->_convertPartXml($file, self::TABLE_XML_ROOM);
//            $this->_convertPartXml($file, self::TABLE_XML_HOUSE);
//            $this->_convertPartXml($file, self::TABLE_XML_HOUSEINT, 11);
//            $this->_convertPartXml($file, self::TABLE_XML_STEAD);
//            $this->_convertPartXml($file, self::TABLE_XML_ACTSTAT);
//            $this->_convertPartXml($file, self::TABLE_XML_ADDROBJ);
//            $this->_convertPartXml($file, self::TABLE_XML_DADDROBJ, 15);
//            $this->_convertPartXml($file, self::TABLE_XML_CENTERST);
//            $this->_convertPartXml($file, self::TABLE_XML_CURENTST);
//            $this->_convertPartXml($file, self::TABLE_XML_DHOUSE, 12);
            $this->_convertPartXml($file, self::TABLE_XML_DHOUSEINT, 15);
//            $this->_convertPartXml($file, self::TABLE_XML_DNORDOC, 14);
//            $this->_convertPartXml($file, self::TABLE_XML_ESTSTAT);
//            $this->_convertPartXml($file, self::TABLE_XML_HSTSTAT);
//            $this->_convertPartXml($file, self::TABLE_XML_INTVSTAT);
//            $this->_convertPartXml($file, self::TABLE_XML_LANDMARK);
//            $this->_convertPartXml($file, self::TABLE_XML_NDOCTYPE);
//            $this->_convertPartXml($file, self::TABLE_XML_OPERSTATE);
//            $this->_convertPartXml($file, self::TABLE_XML_SOCRBASE);
//            $this->_convertPartXml($file, self::TABLE_XML_STRSTAT);
//            $this->_convertPartXml($file, self::TABLE_XML_NORDOC);
        }

    }

    public function convertMainDBDbf()
    {
        $files = scandir(self::INPUT_DIR_DBF);
        foreach ($files as $file) {
//            $this->_convertPart($file, self::TABLE_ROOM);
//            $this->_convertPart($file, self::TABLE_HOUSE);
//            $this->_convertPart($file, self::TABLE_HOUSEINT, 8);
//            $this->_convertPart($file, self::TABLE_STEAD);
            $this->_convertPart($file, self::TABLE_ACTSTAT);
//            $this->_convertPart($file, self::TABLE_ADDROBJ);
//            $this->_convertPart($file, self::TABLE_DADDROBJ);
//            $this->_convertPart($file, self::TABLE_CENTERST);
//            $this->_convertPart($file, self::TABLE_CURENTST);
//            $this->_convertPart($file, self::TABLE_DHOUSE, 7);
//            $this->_convertPart($file, self::TABLE_DHOUSEINT, 8);
//            $this->_convertPart($file, self::TABLE_DNORDOC);
//            $this->_convertPart($file, self::TABLE_ESTSTAT);
//            $this->_convertPart($file, self::TABLE_HSTSTAT);
//            $this->_convertPart($file, self::TABLE_INTVSTAT);
//            $this->_convertPart($file, self::TABLE_LANDMARK);
//            $this->_convertPart($file, self::TABLE_NDOCTYPE);
//            $this->_convertPart($file, self::TABLE_OPERSTATE);
//            $this->_convertPart($file, self::TABLE_SOCRBASE);
//            $this->_convertPart($file, self::TABLE_STRSTAT);
//            $this->_convertPart($file, self::TABLE_NORDOC);
        }

    }

    public function convertDeltaDB($type = self::TYPE_XML)
    {
        if ($this->isNewDelta()) {
            $this->log->info('There is new delta on fias server');
            $this->log->info('START handle ' . $type);
            $deltaEndpoint = $type === self::TYPE_XML ? self::XML_DELTA_ENDPOINT : self::DBF_DELTA_ENDPOINT;
            $deltaFileName = $type === self::TYPE_XML ? self::FILE_NAME_XML_DELTA : self::FILE_NAME_DBF_DELTA;
            $deltaInputDir = $type === self::TYPE_XML ? self::INPUT_DIR_XML_DELTA : self::INPUT_DIR_DBF_DELTA;
            $deltaOutputDir = $type === self::TYPE_XML ? self::OUTPUT_DIR_XML_DELTA : self::OUTPUT_DIR_DBF_DELTA;
//            $this->getFileFromFias($deltaEndpoint, $deltaFileName);
//            $this->unrarFile($deltaFileName, $deltaInputDir);
//            $this->delFile($deltaFileName);
            $files = scandir($deltaInputDir);
            foreach ($files as $file) {
                if (!XmlConverter::saveSQL($deltaInputDir . $file, $this->conf['tablesXmlArray'], $deltaOutputDir)) {
                    $this->log->error('Error occured during conversion');
                    echo 'Error occured during conversion';
                    return false;
                }
            }
            $files = scandir($deltaOutputDir);
            $this->execSql($this->conf['truncateSql']);
            foreach ($files as $file) {
                if (strtolower(substr($file, -4, 4)) === '.sql') {
//                $this->execQueryFile($deltaOutputDir . $file);
                    $this->execSqlFile($deltaOutputDir . $file);
                }
            }
            $this->setNewDate();
        } else {
            $this->log->info('There is no new delta on fias server');
            echo 'There is no new delta on fias server';
        }

    }


    private function _convertPartXml($file, $table, $length = 7)
    {
        if (substr($file, 0, $length) === $table) {
            XmlConverter::saveSQL(self::INPUT_DIR_XML . $file, $this->conf['tablesXmlArray'], self::OUTPUT_DIR_XML);
        }
    }

    private function _convertPart($file, $table, $length = 4)
    {
        if (substr($file, 0, $length) === $table) {
            DbfConverter::saveSQL(self::INPUT_DIR_DBF . $file, $this->conf['tablesArray'], self::OUTPUT_DIR_DBF);
        }
    }

    public function setNewDate() {
        $dateStr = file_get_contents(self::VER_DATE_ENDPOINT);
        $newDate = new DateTime($dateStr);
        $newDate = $newDate->format('Y-m-d');
        echo $newDate;
        $pdo = $this->_pdoInit();
        $stmt = $pdo->prepare("INSERT INTO last_update (last_update_date) VALUES (:value)");
        $stmt->bindParam(':value', $newDate);
        $stmt->execute();
    }

    public function isNewDelta()
    {
        $dateStr = file_get_contents(self::VER_DATE_ENDPOINT);
        $newDate = new DateTime($dateStr);
        $pdo = $this->_pdoInit();
        $sth = $pdo->prepare("SELECT last_update_date FROM last_update ORDER BY last_update_id DESC LIMIT 1");
        $sth->execute();
        $dbDate = $sth->fetchColumn();
        $dbDate = new DateTime($dbDate);
        if ($newDate > $dbDate) {
            return true;
        }
        return false;
    }

    private function _pdoInit()
    {
        return  new PDO('mysql:host=localhost;dbname=' . $this->conf['db']['name'] . ';charset=UTF8', $this->conf['db']['user'], $this->conf['db']['pass']);
    }
    public function execQueryFile($file)
    {
        try {
            $sql = file_get_contents( $file);
            $dbh = $this->_pdoInit();
            /* Удаляем все записи из таблицы FRUIT */
            $count = $dbh->exec($sql);

            /* Получим количество удаленных записей */
            print("$count строк.\n");
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

    public function execSql($sql)
    {
        try {
            $dbh = $this->_pdoInit();
            /* Удаляем все записи из таблицы FRUIT */
            $count = $dbh->exec($sql);

            /* Получим количество удаленных записей */
            print("$count строк.\n");
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

    public function execSqlFile($file)
    {
        $string = 'mysql -u'. $this->conf['db']['user'] . ' -p' . $this->conf['db']['pass'] . ' ' . $this->conf['db']['name'] . ' < ' . $file;
        $res = exec($string);
        $this->log->info($res);
        echo $res;
    }
    /**
     * Save file from fias server.
     * @param string $url the url of fias rar archive
     * @param string $file the file to save to
     * Can be FILE_NAME_XML_DELTA or FILE_NAME_DBF_DELTA
     */
    public function getFileFromFias($url, $file = self::FILE_NAME_XML_DELTA)
    {
//        $newFi = __DIR__ . '/../fias_xml_delta/new.rar';
        //This is the file where we save the    information
        $fp = fopen ($file, 'w+');
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_TIMEOUT, 50);
        // write curl response to file
        curl_setopt($ch, CURLOPT_FILE, $fp);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
//    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
//    curl_setopt($ch, CURLOPT_AUTOREFERER, false);
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
//    $result = curl_exec($ch);
        curl_exec($ch);
        curl_close($ch);
        fclose($fp);
        chmod($file, 0777);
    }

    public function unrarFile($file = self::FILE_NAME_XML_DELTA, $outputDir = self::INPUT_DIR_XML_DELTA)
    {
        $string = "unrar x -y '$file' '$outputDir'";
        if (exec($string) === "All OK") {
            return true;
        }
        return false;
    }

    public function delFile($file = self::FILE_NAME_XML_DELTA)
    {
        unlink($file);
    }
}
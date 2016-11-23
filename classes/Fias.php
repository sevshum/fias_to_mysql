<?php

namespace B3;


class Fias
{
    const ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/';

    const INPUT_DIR_DBF = __DIR__ . '/../../dbf/';
    const INPUT_DIR_XML = __DIR__ . '/../../fias_xml/';
    const OUTPUT_DIR_DBF = __DIR__ . '/../output/';
    const OUTPUT_DIR_XML = __DIR__ . '/../output_from_xml/';

    const INPUT_DIR_DBF_DELTA = __DIR__ . '/../dbf_delta/';
    const INPUT_DIR_XML_DELTA = __DIR__ . '/../fias_xml_delta/';
    const OUTPUT_DIR_DBF_DELTA = __DIR__ . '/../output_delta/';
    const OUTPUT_DIR_XML_delta = __DIR__ . '/../output_from_xml_delta/';

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

    public function __construct($conf)
    {
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
    public function convertDeltaDBXml()
    {

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

    /*public function convertDeltaDBDbf()
    {
        $files = scandir(self::INPUT_DIR);
        foreach ($files as $file) {

        }

    }*/

    private function _convertPartXml($file, $table, $length = 7)
    {
        if (substr($file, 0, $length) === $table) {
            XmlConverter::saveSQL(self::INPUT_DIR_XML . $file, $this->conf['tablesXmlArray'], $this->conf['outputDirXml']);
        }
    }

    private function _convertPart($file, $table, $length = 4)
    {
        if (substr($file, 0, $length) === $table) {
            DbfConverter::saveSQL(self::INPUT_DIR_DBF . $file, $this->conf['tablesArray'], $this->conf['outputDirDbf']);
        }
    }
}
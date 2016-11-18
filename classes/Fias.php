<?php

namespace B3;


class Fias
{
    const ENDPOINT = 'http://fias.nalog.ru/Public/Downloads/Actual/';
    const INPUT_DIR = __DIR__ . '/../../dbf/';

    const TABLE_ACTSTAT = 'ACTS';
    const TABLE_ADDROBJ = 'ADDR';
    const TABLE_CENTERST = 'CENT';
    const TABLE_CURENTST = 'CURE';
    const TABLE_DHOUSE = 'DHOU';
    const TABLE_DHOUSEINT = 'DHOUSEINT';
    const TABLE_DNORDOC = 'DNOR';
    const TABLE_ESTSTAT = 'ESTS';
    const TABLE_HOUSE = 'HOUS';
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

    private $conf;

    public function __construct($conf)
    {
        $this->conf = $conf;
    }

    public function convertMainDB()
    {
        $files = scandir(self::INPUT_DIR);
        foreach ($files as $file) {
            $this->_convertPart($file, self::TABLE_ROOM);
            $this->_convertPart($file, self::TABLE_HOUSE);
            $this->_convertPart($file, self::TABLE_STEAD);
            $this->_convertPart($file, self::TABLE_ACTSTAT);
            $this->_convertPart($file, self::TABLE_ADDROBJ);
            $this->_convertPart($file, self::TABLE_CENTERST);
            $this->_convertPart($file, self::TABLE_CURENTST);
            $this->_convertPart($file, self::TABLE_DHOUSE);
            $this->_convertPart($file, self::TABLE_DHOUSEINT, 9);
            $this->_convertPart($file, self::TABLE_DNORDOC);
            $this->_convertPart($file, self::TABLE_ESTSTAT);
            $this->_convertPart($file, self::TABLE_HSTSTAT);
            $this->_convertPart($file, self::TABLE_INTVSTAT);
            $this->_convertPart($file, self::TABLE_LANDMARK);
            $this->_convertPart($file, self::TABLE_NDOCTYPE);
            $this->_convertPart($file, self::TABLE_OPERSTATE);
            $this->_convertPart($file, self::TABLE_SOCRBASE);
            $this->_convertPart($file, self::TABLE_STRSTAT);
        }

    }

    /*public function convertDeltaDB()
    {
        $files = scandir(self::INPUT_DIR);
        foreach ($files as $file) {
            $this->_convertPart($file, self::TABLE_ROOM);
            $this->_convertPart($file, self::TABLE_HOUSE);
            $this->_convertPart($file, self::TABLE_STEAD);
            $this->_convertPart($file, self::TABLE_ACTSTAT);
            $this->_convertPart($file, self::TABLE_ADDROBJ);
            $this->_convertPart($file, self::TABLE_CENTERST);
            $this->_convertPart($file, self::TABLE_CURENTST);
            $this->_convertPart($file, self::TABLE_DHOUSE);
            $this->_convertPart($file, self::TABLE_DHOUSEINT, 9);
            $this->_convertPart($file, self::TABLE_DNORDOC);
            $this->_convertPart($file, self::TABLE_ESTSTAT);
            $this->_convertPart($file, self::TABLE_HSTSTAT);
            $this->_convertPart($file, self::TABLE_INTVSTAT);
            $this->_convertPart($file, self::TABLE_LANDMARK);
            $this->_convertPart($file, self::TABLE_NDOCTYPE, 8);
            $this->_convertPart($file, self::TABLE_OPERSTATE);
            $this->_convertPart($file, self::TABLE_SOCRBASE);
            $this->_convertPart($file, self::TABLE_STRSTAT);
        }

    }*/


    private function _convertPart($file, $table, $length = 4)
    {
        if (substr($file, 0, $length) === $table) {
            DbfConverter::saveSQL(self::INPUT_DIR . $file, $this->conf['tablesArray'], $this->conf['output_dir']);
        }
    }
}
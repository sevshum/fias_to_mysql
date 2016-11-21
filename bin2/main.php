<?php
use B3\DbfConverter;

require (__DIR__ . '/../vendor/autoload.php');
$config = require (__DIR__ . '/../config/conf.php');

set_time_limit(0);
//dbf2mysql::guardarSQL(__DIR__ . '/../../dbf/HOUSE01.DBF');

//DbfConverter::saveSQL(__DIR__ . '/../../dbf/LANDMARK.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/NORDOC01.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/HSTSTAT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/CURENTST.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/ACTSTAT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/CENTERST.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/DADDROBJ.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/DHOUSE.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/DHOUSINT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/ESTSTAT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/HOUSE01.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/INTVSTAT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/NDOCTYPE.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/ROOM01.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/SOCRBASE.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/STEAD01.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/STRSTAT.DBF', $config['tablesArray'], $config['outputDirDbf']);
//DbfConverter::saveSQL(__DIR__ . '/../../dbf/HOUSE01.DBF', $config['tablesArray'], $config['outputDirDbf']);
$fias = new \B3\Fias($config);
$fias->convertMainDBDbf();
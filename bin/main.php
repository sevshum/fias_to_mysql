<?php
use B3\DbfConverter;

require (__DIR__ . '/../vendor/autoload.php');
$config = require (__DIR__ . '/../config/conf.php');

set_time_limit(0);
//dbf2mysql::guardarSQL(__DIR__ . '/../../dbf/HOUSE01.DBF');

DbfConverter::saveSQL(__DIR__ . '/../../dbf/ADDROBJ.DBF', $config['tablesArray'], $config['output_dir']);
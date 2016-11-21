<?php
use B3\DbfConverter;

require (__DIR__ . '/../vendor/autoload.php');
$config = require (__DIR__ . '/../config/conf.php');

set_time_limit(0);

$fias = new \B3\Fias($config);
$fias->convertXml();

$normDocs = simplexml_load_file(__DIR__ . '/../../fias_delta_xml/AS_NORMDOC_20161114_ee40219d-b26b-4feb-b357-d5724965f460.XML');

echo $normDocs->NormativeDocument[0]->attributes()["NORMDOCID"];
foreach($normDocs->NormativeDocument[0]->attributes() as $a => $b) {
    echo $a,'="',$b,"\"\n";
}
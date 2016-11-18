<?php
return [
    'output_dir' => __DIR__ . '/../output/',
    'tablesArray' => [
        'OPERSTAT' => [
            'name' => 'operation_statuses',
            'rowsArray' => [
                'NAME' => 'operation_statuses_name',
                'OPERSTATID' => 'operation_statuses_openstat_id'
            ]
        ],
        'HOUSE' => [
            'name' => 'house',
            'rowsArray' => [
                'POSTALCODE' => 'house_postal_code',
                'IFNSFL' => 'house_ifns_fiz_li',
                'TERRIFNSFL' => 'house_terr_ifns_fiz_li',
                'IFNSUL' => 'house_ifns_ur_li',
                'TERRIFNSUL' => 'house_terr_ifns_ur_li',
                'OKATO' => 'house_okato',
                'OKTMO' => 'house_oktmo',
                'UPDATEDATE' => 'house_updatedate',
                'HOUSENUM' => 'house_house_num',
                'ESTSTATUS' => 'house_estate_status',
                'BUILDNUM' => 'house_building_number',
                'STRUCNUM' => 'house_struct_num',
                'STRSTATUS' => 'house_strstatus',
                'HOUSEID' => 'house_house_id',
                'HOUSEGUID' => 'house_house_guid',
                'AOGUID' => 'house_ao_guid',
                'STARTDATE' => 'house_startdate',
                'ENDDATE' => 'house_enddate',
                'STATSTATUS' => 'house_stat_status',
                'NORMDOC' => 'house_normdoc',
                'COUNTER' => 'house_counter',
                'CADNUM' => 'house_cadastr_num',
                'DIVTYPE' => 'house_division_type',
            ],
        ],
        'HOUSEINT' => [
            'name' => 'house_interval',
            'rowsArray' => [
                'AOGUID' => 'house_interval_ao_guid',
                'ENDDATE' => 'house_interval_enddate',
                'INTGUID' => 'house_interval_int_guid',
                'HOUSEINTID' => 'house_interval_houseint_guid',
                'IFNSFL' => 'house_interval_ifns_fiz_li',
                'IFNSUL' => 'house_interval_ifns_ur_li',
                'INTEND' => 'house_interval_interval_end',
                'INTSTART' => 'house_interval_interval_start',
                'INTSTATUS' => 'house_interval_interval_status',
                'OKATO' => 'house_interval_okato',
                'OKTMO' => 'house_interval_oktmo',
                'POSTALCODE' => 'house_interval_postal_code',
                'STARTDATE' => 'house_interval_startdate',
                'TERRIFNSFL' => 'house_interval_terr_ifns_fiz_li',
                'TERRIFNSUL' => 'house_interval_terr_ifns_ur_li',
                'UPDATEDATE' => 'house_interval_updatedate',
                'NORMDOC' => 'house_interval_normdoc',
                'COUNTER' => 'house_interval_counter',
            ],
        ],
        'ADDROBJ' => [
            'name' => 'address_object',
            'rowsArray' => [
                'AOGUID' => 'address_object_guid',
                'FORMALNAME' => 'address_object_formal_name',
                'REGIONCODE' => 'address_object_region_code',
                'AUTOCODE' => 'address_object_autonomy_code',
                'AREACODE' => 'address_object_area_code',
                'CITYCODE' => 'address_object_city_code',
                'CTARCODE' => 'address_object_ctar_code',
                'PLACECODE' => 'address_object_place_code',
                'PLANCODE' => 'address_object_plain_code',
                'STREETCODE' => 'address_object_street_code',
                'EXTRCODE' => 'address_object_extr_code',
                'SEXTCODE' => 'address_object_sext_code',
                'OFFNAME' => 'address_object_official_name',
                'POSTALCODE' => 'address_object_postal_code',
                'IFNSFL' => 'address_object_ifns_fiz_li',
                'TERRIFNSFL' => 'address_object_terr_ifns_fiz_li',
                'IFNSUL' => 'address_object_ifns_ur_li',
                'TERRIFNSUL' => 'address_object_terr_ifns_ur_li',
                'OKATO' => 'address_object_okato',
                'OKTMO' => 'address_object_oktmo',
                'UPDATEDATE' => 'address_object_updatedate',
                'SHORTNAME' => 'address_object_type_shortname',
                'AOLEVEL' => 'address_object_level',
                'PARENTGUID' => 'address_object_parent_guid',
                'AOID' => 'address_object_ao_id',
                'PREVID' => 'address_object_prev_id',
                'NEXTID' => 'address_object_next_id',
                'CODE' => 'address_object_code',
                'PLAINCODE' => 'address_object_plain_code',
                'ACTSTATUS' => 'address_object_actual_status',
                'LIVESTATUS' => 'address_object_livestatus',
                'CENTSTATUS' => 'address_object_center_status',
                'OPERSTATUS' => 'address_object_operation_status',
                'CURRSTATUS' => 'address_object_curr_status',
                'STARTDATE' => 'address_object_start_date',
                'ENDDATE' => 'address_object_enddate',
                'NORMDOC' => 'address_object_normdoc',
                'CADNUM' => 'address_object_cadastr_num',
                'DIVTYPE' => 'address_object_cadastr_num',
            ]
        ],
        'LANDMARK' => [
            'name' => 'landmark',
            'rowsArray' => [
                'LOCATION' => 'landmark_location',
                'POSTALCODE' => 'landmark_postal_code',
                'IFNSFL' => 'landmark_ifns_fiz_li',
                'TERRIFNSFL' => 'landmark_terr_ifns_fiz_li',
                'IFNSUL' => 'landmark_ifns_ur_li',
                'TERRIFNSUL' => 'landmark_terr_ifns_ur_li',
                'OKATO' => 'landmark_okato',
                'OKTMO' => 'landmark_oktmo',
                'UPDATEDATE' => 'landmark_updatedate',
                'LANDID' => 'landmark_land_id',
                'LANDGUID' => 'landmark_land_guid',
                'AOGUID' => 'landmark_ao_guid',
                'STARTDATE' => 'landmark_startdate',
                'ENDDATE' => 'landmark_enddate',
                'NORMDOC' => 'landmark_normdoc',
            ]
        ],
        'NORMDOC' => [
            'name' => 'norm_doc',
            'rowsArray' => [
                'DOCNAME' => 'norm_doc_doc_name',
                'DOCDATE' => 'norm_doc_doc_date',
                'DOCNUM' => 'norm_doc_doc_num',
                'DOCTYPE' => 'norm_doc_doc_type',
                'DOCIMGID' => 'norm_doc_doc_imgid'
            ]
        ],
        'HSTSTAT' => [
            'name' => 'house_status',
            'rowsArray' => [
                'NAME' => 'house_status_name',
            ]
        ],
        'CURENTST' => [
            'name' => 'current_status',
            'rowsArray' => [
                'NAME' => 'house_status_name',
            ]
        ],
        'ROOM' => [
            'name' => 'room',
            'rowsArray' => [
                'ROOMGUID' => '',
                'HOUSEGUID' => '',
                'REGIONCODE' => '',
                'FLATNUMBER' => '',
                'FLATTYPE' => '',
                'ROOMNUMBER' => '',
                'ROOMTYPEID' => '',
                'POSTALCODE' => '',
                'UPDATEDATE' => '',
                'PREVID' => '',
                'NEXTID' => '',
                'STARTDATE' => '',
                'ENDDATE' => '',
                'NORMDOC' => '',
                'CADNUM' => ''
            ]
        ]
    ]
];
























































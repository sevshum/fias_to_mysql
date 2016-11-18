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
        'DHOUSE' => [
            'name' => 'deleted_house',
            'rowsArray' => [
                'POSTALCODE' => 'deleted_house_postal_code',
                'IFNSFL' => 'deleted_house_ifns_fiz_li',
                'TERRIFNSFL' => 'deleted_house_terr_ifns_fiz_li',
                'IFNSUL' => 'deleted_house_ifns_ur_li',
                'TERRIFNSUL' => 'deleted_house_terr_ifns_ur_li',
                'OKATO' => 'deleted_house_okato',
                'OKTMO' => 'deleted_house_oktmo',
                'UPDATEDATE' => 'deleted_house_updatedate',
                'HOUSENUM' => 'deleted_house_house_num',
                'ESTSTATUS' => 'deleted_house_estate_status',
                'BUILDNUM' => 'deleted_house_building_number',
                'STRUCNUM' => 'deleted_house_struct_num',
                'STRSTATUS' => 'deleted_house_strstatus',
                'HOUSEID' => 'deleted_house_house_id',
                'HOUSEGUID' => 'deleted_house_house_guid',
                'AOGUID' => 'deleted_house_ao_guid',
                'STARTDATE' => 'deleted_house_startdate',
                'ENDDATE' => 'deleted_house_enddate',
                'STATSTATUS' => 'deleted_house_stat_status',
                'NORMDOC' => 'deleted_house_normdoc',
                'COUNTER' => 'deleted_house_counter',
                'CADNUM' => 'deleted_house_cadastr_num',
                'DIVTYPE' => 'deleted_house_division_type',
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
        'DHOUSINT' => [
            'name' => 'deleted_house_interval',
            'rowsArray' => [
                'AOGUID' => 'deleted_house_interval_ao_guid',
                'ENDDATE' => 'deleted_house_interval_enddate',
                'INTGUID' => 'deleted_house_interval_int_guid',
                'HOUSEINTID' => 'deleted_house_interval_houseint_guid',
                'IFNSFL' => 'deleted_house_interval_ifns_fiz_li',
                'IFNSUL' => 'deleted_house_interval_ifns_ur_li',
                'INTEND' => 'deleted_house_interval_interval_end',
                'INTSTART' => 'deleted_house_interval_interval_start',
                'INTSTATUS' => 'deleted_house_interval_interval_status',
                'OKATO' => 'deleted_house_interval_okato',
                'OKTMO' => 'deleted_house_interval_oktmo',
                'POSTALCODE' => 'deleted_house_interval_postal_code',
                'STARTDATE' => 'deleted_house_interval_startdate',
                'TERRIFNSFL' => 'deleted_house_interval_terr_ifns_fiz_li',
                'TERRIFNSUL' => 'deleted_house_interval_terr_ifns_ur_li',
                'UPDATEDATE' => 'deleted_house_interval_updatedate',
                'NORMDOC' => 'deleted_house_interval_normdoc',
                'COUNTER' => 'deleted_house_interval_counter',
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
        'NORDOC' => [ //check
            'name' => 'norm_doc',
            'rowsArray' => [
                'DOCNAME' => 'norm_doc_doc_name',
                'DOCDATE' => 'norm_doc_doc_date',
                'DOCNUM' => 'norm_doc_doc_num',
                'DOCTYPE' => 'norm_doc_doc_type',
                'DOCIMGID' => 'norm_doc_doc_imgid'
            ]
        ],
        'DNORDOC' => [
            'name' => 'donorm_doc',
            'rowsArray' => [
                'DOCDATE' => 'dnorm_doc_doc_date',
                'DOCNAME' => 'dnorm_doc_doc_name',
                'DOCNUM' => 'dnorm_doc_doc_num',
                'DOCTYPE' => 'dnorm_doc_doc_type',
                'DOCIMGID' => 'dnorm_doc_doc_imgid',
                'NORMDOCID' => 'dnorm_doc_normdoc_id',
            ]
        ],
        'HSTSTAT' => [
            'name' => 'house_state_status',
            'rowsArray' => [
                'HOUSESTID' => 'house_state_status_housest_id',
                'NAME' => 'house_state_status_name',
            ]
        ],
        'NDOCTYPE' => [
            'name' => 'norm_doc_type',
            'rowsArray' => [
                'NDTYPEID' => 'norm_doc_type_ndtype_id',
                'NAME' => 'norm_doc_type_name',
            ]
        ],
        'INTVSTAT' => [
            'name' => 'interval_status',
            'rowsArray' => [
                'INTVSTATID' => 'interval_status_intvstat_id',
                'NAME' => 'interval_status_name',
            ]
        ],
        'CURENTST' => [
            'name' => 'current_status',
            'rowsArray' => [
                'CURENTSTID' => 'current_status_cuentst_id',
                'NAME' => 'current_status_name',
            ]
        ],
        'ACTSTAT' => [
            'name' => 'active_status',
            'rowsArray' => [
                'ACTSTATID' => 'active_status_actstat_id',
                'NAME' => 'active_status_name',
            ]
        ],
        'ESTSTAT' => [
            'name' => 'estate_status',
            'rowsArray' => [
                'ESTSTATID' => 'estate_status_eststat_id',
                'NAME' => 'estate_status_name',
                'SHORTNAME' => 'estate_status_shortname',
            ]
        ],
        'CENTERST' => [
            'name' => 'center_status',
            'rowsArray' => [
                'CENTERSTID' => 'center_status_centerst_id',
                'NAME' => 'center_status_name',
            ]
        ],
        'STRSTAT' => [
            'name' => 'structure_status',
            'rowsArray' => [
                'STRSTATID' => 'structure_status_strstat_id',
                'NAME' => 'structure_status_name',
                'SHORTNAME' => 'structure_status_shortname',
            ]
        ],
        'SOCRBASE' => [
            'name' => 'address_object_type',
            'rowsArray' => [
                'LEVEL' => 'address_object_type_level',
                'SCNAME' => 'address_object_type_shortname',
                'SOCRNAME' => 'address_object_type_fullname',
                'KOD_T_ST' => 'address_object_type_kod_t_st',
            ]
        ],
        'DADDROBJ' => [
            'name' => 'deleted_address_objecrs',
            'rowsArray' => [
                'ACTSTATUS' => 'deleted_address_objecrs_active_status',
                'AOGUID' => 'deleted_address_objecrs_gu_id',
                'AOID' => 'deleted_address_objecrs_ao_id',
                'AOLEVEL' => 'deleted_address_objecrs_ao_level',
                'AREACODE' => 'deleted_address_objecrs_area_code',
                'AUTOCODE' => 'deleted_address_objecrs_auto_code',
                'CENTSTATUS' => 'deleted_address_object_center_status',
                'CITYCODE' => 'deleted_address_object_city_code',
                'CODE' => 'deleted_address_object_code',
                'CURRSTATUS' => 'deleted_address_object_curr_status',
                'ENDDATE' => 'deleted_address_object_enddate',
                'FORMALNAME' => 'deleted_address_object_formal_name',
                'IFNSFL' => 'deleted_address_object_ifns_fiz_li',
                'IFNSUL' => 'deleted_address_object_ifns_ur_li',
                'NEXTID' => 'deleted_address_object_next_id',
                'OFFNAME' => 'deleted_address_object_official_name',
                'OKATO' => 'deleted_address_object_okato',
                'OKTMO' => 'deleted_address_object_oktmo',
                'OPERSTATUS' => 'deleted_address_object_operation_status',
                'PARENTGUID' => 'deleted_address_object_parent_guid',
                'PLACECODE' => 'deleted_address_object_place_code',
                'PLAINCODE' => 'deleted_address_object_plain_code',
                'POSTALCODE' => 'deleted_address_object_postal_code',
                'PREVID' => 'deleted_address_object_prev_id',
                'REGIONCODE' => 'deleted_address_object_region_code',
                'SHORTNAME' => 'deleted_address_object_type_shortname',
                'STARTDATE' => 'deleted_address_object_start_date',
                'STREETCODE' => 'deleted_address_object_street_code',
                'TERRIFNSFL' => 'deleted_address_object_terr_ifns_fiz_li',
                'TERRIFNSUL' => 'deleted_address_object_terr_ifns_ur_li',
                'UPDATEDATE' => 'deleted_address_object_updatedate',
                'CTARCODE' => 'deleted_address_object_ctar_code',
                'EXTRCODE' => 'deleted_address_object_extr_code',
                'SEXTCODE' => 'deleted_address_object_sext_code',
                'LIVESTATUS' => 'deleted_address_object_livestatus',
                'NORMDOC' => 'deleted_address_object_normdoc',

            ]
        ],
        'ROOM' => [
            'name' => 'room',
            'rowsArray' => [
                'ROOMID' => 'room_room_id',
                'ROOMGUID' => 'room_gu_id',
                'HOUSEGUID' => 'room_house_id',
                'REGIONCODE' => 'room_region_code',
                'FLATNUMBER' => 'room_flat_number',
                'FLATTYPE' => 'room_flat_type',
                'ROOMNUMBER' => 'room_number',
                'ROOMTYPE' => 'room_type_id',
                'POSTALCODE' => 'room_postal_code',
                'UPDATEDATE' => 'room_update_date',
                'PREVID' => 'room_prev_id',
                'NEXTID' => 'room_next_id',
                'STARTDATE' => 'room_start_date',
                'OPERSTATUS' => 'room_oper_status',
                'LIVESTATUS' => 'room_live_status',
                'ENDDATE' => 'room_end_date',
                'NORMDOC' => 'room_norm_doc',
                'ROOMCADNUM' => 'room_room_cadastr_num',
                'CADNUM' => 'room_cadastr_num'
            ]
        ],
        'STEAD' => [
            'name' => 'stead',
            'rowsArray' => [
                'STEADGUID' => 'stear_gu_id',
                'NUMBER' => 'stear_number',
                'REGIONCODE' => 'stead_region_code',
                'POSTALCODE' => 'stead_postal_code',
                'IFNSFL' => 'stead_ifns_fiz_li',
                'IFNSUL' => 'stead_ifns_ur_li',
                'TERRIFNSFL' => 'stead_terr_ifns_fiz_li',
                'TERRIFNSUL' => 'stead_terr_ifns_ur_li',
                'OKATO' => 'stead_okato',
                'OKTMO' => 'stead_oktmo',
                'UPDATEDATE' => 'stead_update_date',
                'PARENTGUID' => 'stead_parent_gu_id',
                'STEADID' => 'stead_stead_id',
                'PREVID' => 'stead_prev_id',
                'NEXTID' => 'stead_next_id',
                'OPERSTATUS' => 'stead_oper_status',
                'STARTDATE' => 'stead_start_date',
                'ENDDATE' => 'stead_end_date',
                'NORMDOC' => 'stead_norm_doc',
                'LIVESTATUS' => 'stead_live_status',
                'CADNUM' => 'stead_cadastr_num',
                'COUNTER' => 'stead_counter',
                'DIVTYPE' => 'stead_division_type',
            ]
        ]
    ]
];
























































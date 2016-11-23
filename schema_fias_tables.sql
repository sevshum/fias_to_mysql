-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Schema fiasdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fiasdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `fiasdb` ;

-- -----------------------------------------------------
-- Table `fiasdb`.`relevance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`relevance` (
  `relevance_id` TINYINT NOT NULL,
  `relevance_name` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`relevance_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fiasdb`.`norm_doc_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`norm_doc_type` (
  `norm_doc_type_id` TINYINT NOT NULL COMMENT 'Идентификатор записи (ключ)',
  `norm_doc_type_name` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование типа нормативного документа',
  PRIMARY KEY (`norm_doc_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Тип нормативного документа';


-- -----------------------------------------------------
-- Table `fiasdb`.`norm_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`norm_doc` (
  `norm_doc_id` BIGINT NOT NULL AUTO_INCREMENT,
  `norm_doc_normdoc_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор нормативного документа',
  `norm_doc_doc_imgid` VARCHAR(10) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Идентификатор образа (внешний ключ)\nРанее было NOT NULL, но состояло из пустых срок полностью',
  `norm_doc_doc_name` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Наименование документа\nРанее было not null, но с пустой строкой.',
  `norm_doc_doc_num` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Номер документа',
  `norm_doc_doc_type` TINYINT NOT NULL COMMENT 'Тип документа',
  `norm_doc_doc_date` DATE NULL DEFAULT NULL COMMENT 'Дата документа\nРанее было NOT NULL, но с пустыми строками',
  PRIMARY KEY (`norm_doc_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Сведения по нормативному документу, являющемуся основанием присвоения адресному элементу наименования';




-- -----------------------------------------------------
-- Table `fiasdb`.`operation_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`operation_statuses` (
  `operation_statuses_id` SMALLINT NOT NULL COMMENT 'Идентификатор статуса (ключ)',
  `operation_statuses_name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование\n',
  PRIMARY KEY (`operation_statuses_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Статус действия';


-- -----------------------------------------------------
-- Table `fiasdb`.`current_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`current_status` (
  `current_status_id` TINYINT NOT NULL COMMENT 'Идентификатор статуса (ключ)',
  `current_status_name` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование (0 - актуальный, 1-50, 2-98 – исторический (кроме 51), 51 - переподчиненный, 99 - несуществующий)',
  PRIMARY KEY (`current_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Статус актуальности КЛАДР 4.0';


-- -----------------------------------------------------
-- Table `fiasdb`.`center_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`center_status` (
  `center_status_id` SMALLINT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор статуса',
  `center_status_name` VARCHAR(100) NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`center_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'содержит перечень возможных статусов (центров) адресных объектов административных единиц.';


-- -----------------------------------------------------
-- Table `fiasdb`.`actual_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`actual_statuses` (
  `actual_statuses_id` TINYINT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор статуса (ключ)',
  `actual_statuses_name` VARCHAR(100) NOT NULL COMMENT 'Наименование\n0 – Не актуальный\n1 – Актуальный (последняя запись по адресному объекту)',
  PRIMARY KEY (`actual_statuses_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'содержит перечень статусов актуальности записи  адресного элемента по ФИАС';


-- -----------------------------------------------------
-- Table `fiasdb`.`address_object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`address_object` (
  `address_object_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор записи',
  `address_object_ao_id` VARCHAR(36) NULL COMMENT 'Уникальный идентификатор записи. Ключевое поле.',
  `address_object_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Глобальный идентификатор адресного объекта',
  `address_object_parent_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор родительского адресного объекта',
  `address_object_prev_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор записи связывания с предыдущей исторической записью',
  `address_object_next_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор связывания с последующей исторической записью',
  `address_object_level` SMALLINT NOT NULL DEFAULT 1 COMMENT 'Уровень адресного объекта',
  `address_object_actual_status` TINYINT NOT NULL DEFAULT 0 COMMENT 'Статус исторической записи в жизненном цикле адресного объекта:\n0 – не последняя\n1 - последняя',
  `address_object_area_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код района',
  `address_object_autonomy_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код автономии',
  `address_object_center_status` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Статус центра',
  `address_object_city_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код города',
  `address_object_code` BIGINT NULL COMMENT 'Код адресного объекта одной строкой с признаком актуальности из КЛАДР 4.0',
  `address_object_curr_status` TINYINT NOT NULL DEFAULT 0 COMMENT 'Статус актуальности КЛАДР 4 (последние две цифры в коде) от 0 до 99',
  `address_object_formal_name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'Формализованное наименование',
  `address_object_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ФЛ',
  `address_object_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ЮЛ',
  `address_object_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ФЛ',
  `address_object_terr_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ЮЛ',
  `address_object_official_name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'Официальное наименование',
  `address_object_okato` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКАТО',
  `address_object_oktmo` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКТМО',
  `address_object_operation_status` SMALLINT NOT NULL DEFAULT 20 COMMENT 'Статус действия над записью – причина появления записи.',
  `address_object_place_code` TINYINT NOT NULL DEFAULT 0 COMMENT 'Код населённого пункта',
  `address_object_plain_code` BIGINT NULL DEFAULT NULL COMMENT 'Код адресного объекта из КЛАДР 4.0 одной строкой без признака актуальности (последних двух',
  `address_object_postal_code` INT NULL DEFAULT NULL COMMENT 'Почтовый индекс',
  `address_object_region_code` TINYINT NOT NULL DEFAULT 0 COMMENT 'Код региона',
  `address_object_type_shortname` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL COMMENT 'Краткое наименование типа объекта',
  `address_object_street_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код улицы',
  `address_object_ctar_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код внутригородского района',
  `address_object_extr_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код дополнительного адресообразующего элемента',
  `address_object_sext_code` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Код подчиненного дополнительного адресообразующего элемента',
  `address_object_livestatus` TINYINT NOT NULL DEFAULT 1 COMMENT 'Признак действующего адресного объекта',
  `address_object_normdoc` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'нормативный документ (табл. NORMDOC).\nВнешний ключ на нормативный документ',
  `address_object_cadastr_num` VARCHAR(100) NOT NULL COMMENT 'Кадастровый номер',
  `address_object_division_type` TINYINT NULL COMMENT 'Тип адресации: \n0 – не определено\n1 – муниципальное\n2 – административное\n',
  `address_object_start_date` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Начало действия записи',
  `address_object_updatedate` DATE NOT NULL DEFAULT '2011-09-13' COMMENT 'Дата внесения записи',
  `address_object_enddate` DATE NOT NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
  PRIMARY KEY (`address_object_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Сведения по адресообразующим элементам БД ФИАС\nсодержит коды, наименования и типы адресообразующих элементов (регионы; округа; районы (улусы, кужууны); города, ,  поселки городского типа, сельские населенные пункты; элементы планировочной структуры, элементы улично-дорожной сети  ';





-- -----------------------------------------------------
-- Table `fiasdb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`role` (
  `role_id` TINYINT NOT NULL,
  `role_name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fiasdb`.`eatate_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`eatate_status` (
  `eatate_status_id` TINYINT NOT NULL,
  `eatate_status_name` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  `eatate_type_short_name` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`eatate_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'признакам владения';


-- -----------------------------------------------------
-- Table `fiasdb`.`house_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`house_status` (
  `house_status_id` TINYINT NOT NULL COMMENT 'Идентификатор статуса',
  `house_status_name` VARCHAR(120) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`house_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Статус состояния домов';


-- -----------------------------------------------------
-- Table `fiasdb`.`structure_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`structure_status` (
  `structure_status_id` TINYINT NOT NULL AUTO_INCREMENT,
  `structure_status_name` VARCHAR(20) NOT NULL,
  `structure_status_shortname` VARCHAR(20) NOT NULL COMMENT 'Краткое наименование',
  PRIMARY KEY (`structure_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Признак строения';


-- -----------------------------------------------------
-- Table `fiasdb`.`house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`house` (
  `house_id` BIGINT NOT NULL AUTO_INCREMENT,
  `house_ao_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'AOGUID - Глобальный уникальный идентификатор адресного объекта. Не смотря на название, уникальным в пределах таблицы он не является. Могут существовать несколько исторический версий и одна единственная актуальная для данного объекта. Подробнее см. раздел \"Статус актуальности\".',
  `house_house_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Уникальный идентификатор записи дома',
  `house_house_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Глобальный уникальный идентификатор дома',
  `house_normdoc` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Внешний ключ на нормативный документ',
  `house_building_number` VARCHAR(10) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Номер корпуса\nКостя: Ранее было Not null,но с пустыми строками',
  `house_estate_status` TINYINT NOT NULL COMMENT 'Признак владения',
  `house_house_num` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Номер дома\nРанее был NOT NULL но с пустыми строками',
  `house_stat_status` TINYINT NOT NULL DEFAULT 0 COMMENT 'Состояние дома',
  `house_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС Физ. Лиц',
  `house_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС Юр. Лиц',
  `house_terr_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ИФНС Юр.лиц',
  `house_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL,
  `house_okato` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКАТО',
  `house_oktmo` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКТМО',
  `house_postal_code` INT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `house_struct_num` VARCHAR(10) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Номер строения\nРанее было not null\nМогут быть буквы!',
  `house_strstatus` TINYINT NOT NULL DEFAULT 0 COMMENT 'Признак строения, от 0 до 3',
  `house_counter` TINYINT NOT NULL DEFAULT 1 COMMENT 'Счетчик записей домов для КЛАДР ',
  `house_cadastr_num` VARCHAR(100) NOT NULL COMMENT 'Кадастровый номер',
  `house_division_type` TINYINT NOT NULL COMMENT 'Тип деления: \n0 – не определено\n1 – муниципальное\n2 – административное',
  `house_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Начало действия записи',
  `house_updatedate` DATE NOT NULL DEFAULT '2011-09-13',
  `house_enddate` DATE NOT NULL DEFAULT '2079-06-06',
  PRIMARY KEY (`house_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Сведения по номерам домов улиц городов и населенных пунктов';


-- -----------------------------------------------------
-- Table `fiasdb`.`interv_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`interv_status` (
  `interv_status_id` TINYINT NOT NULL COMMENT 'Идентификатор статуса (обычный, четный, нечетный)',
  `interv_status_name` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`interv_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Статус интервала домов';


-- -----------------------------------------------------
-- Table `fiasdb`.`house_interval`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`house_interval` (
  `house_interval_id` BIGINT NOT NULL AUTO_INCREMENT,
  `house_interval_ao_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор объекта родительского объекта (улицы, города, населенного пункта и т.п.)',
  `house_interval_int_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Глобальный уникальный идентификатор интервала домов',
  `house_interval_houseint_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор записи интервала домов',
  `house_interval_normdoc` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Внешний ключ на нормативный документ',
  `house_interval_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ФЛ',
  `house_interval_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ЮЛ',
  `house_interval_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ИФНС ФЛ',
  `house_interval_terr_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ЮЛ',
  `house_interval_interval_end` SMALLINT NOT NULL COMMENT 'Значение окончания интервала',
  `house_interval_interval_start` SMALLINT NOT NULL COMMENT 'Значение начала интервала',
  `house_interval_int_status` TINYINT NOT NULL DEFAULT 1 COMMENT 'Статус интервала (обычный, четный, нечетный),\n принимает значения 1, 2, 3, больше всего 1',
  `house_interval_okato` BIGINT NULL DEFAULT NULL,
  `house_interval_oktmo` BIGINT NULL DEFAULT NULL,
  `house_interval_postal_code` INT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `house_interval_counter` TINYINT NOT NULL DEFAULT 1 COMMENT 'Счётчик записей домов для КЛАДР 4 чаще всего встречается ',
  `house_interval_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Дата начала записи',
  `house_interval_updatedate` DATE NOT NULL DEFAULT '2011-09-13',
  `house_interval_enddate` DATE NOT NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
  PRIMARY KEY (`house_interval_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Интервалы домов';



-- -----------------------------------------------------
-- Table `fiasdb`.`landmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`landmark` (
  `landmark_id` BIGINT NOT NULL AUTO_INCREMENT,
  `landmark_ao_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL,
  `landmark_land_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Уникальный идентификатор записи ориентира',
  `landmark_land_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Глобальный уникальный идентификатор ориентира',
  `landmark_normdoc` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL,
  `landmark_ifns_fiz_litz` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ФЛ',
  `landmark_ifns_ur_litz` SMALLINT UNSIGNED NULL DEFAULT NULL COMMENT 'Код ИФНС ЮЛ',
  `landmark_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ФЛ',
  `landmark_terr_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ЮЛ',
  `landmark_location` TEXT(500) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Местоположение ориентира',
  `landmark_okato` BIGINT NULL DEFAULT NULL COMMENT 'код ОКАТО',
  `landmark_oktmo` INT NULL DEFAULT NULL,
  `landmark_postal_code` BIGINT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `landmark_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Дата начала записи',
  `landmark_updatedate` DATE NOT NULL DEFAULT '2011-09-13',
  `landmark_enddate` DATE NOT NULL DEFAULT '2079-06-06',
  PRIMARY KEY (`landmark_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Описание мест расположения  имущественных объектов';



-- -----------------------------------------------------
-- Table `fiasdb`.`address_object_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`address_object_type` (
  `address_object_type_level` TINYINT NOT NULL COMMENT 'Уровень адресного объекта',
  `address_object_type_name` VARCHAR(120) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Полное наименование типа объекта',
  `address_object_type_short_name` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Краткое наименование типа объекта',
  `address_object_type_id` SMALLINT NOT NULL AUTO_INCREMENT COMMENT 'похоже, айдишник',
  `address_object_type_kod_t_st` SMALLINT NOT NULL,
  PRIMARY KEY (`address_object_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Тип адресного объекта';


-- -----------------------------------------------------
-- Table `fiasdb`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`room` (
  `room_id` BIGINT NOT NULL AUTO_INCREMENT,
  `room_room_id` VARCHAR(36) NOT NULL COMMENT 'Уникальный идентификатор записи. Ключевое поле.',
  `room_gu_id` VARCHAR(36) NOT NULL COMMENT 'Глобальный уникальный идентификатор адресного объекта (помещения)',
  `room_house_gu_id` VARCHAR(36) NOT NULL COMMENT 'Идентификатор родительского объекта (дома)',
  `room_prev_id` VARCHAR(36) NOT NULL COMMENT 'дентификатор записи связывания с предыдушей исторической записью',
  `room_next_id` VARCHAR(36) NOT NULL COMMENT 'Идентификатор записи  связывания с последующей исторической записью',
  `room_norm_doc` VARCHAR(36) NOT NULL COMMENT 'Внешний ключ на нормативный документ',
  `room_type_id` INT NOT NULL COMMENT 'Тип комнаты',
  `room_flat_number` VARCHAR(50) NULL DEFAULT 'Null' COMMENT 'Номер помещения или офиса',
  `room_flat_type` INT NOT NULL COMMENT 'Тип помещения',
  `room_number` VARCHAR(50) NULL COMMENT 'Номер комнаты',
  `room_region_code` TINYINT NOT NULL COMMENT 'Код региона',
  `room_postal_code` INT NULL COMMENT 'Почтовый индекс',
  `room_live_status` TINYINT NOT NULL COMMENT 'Признак действующего адресного объекта',
  `room_oper_status` SMALLINT NOT NULL COMMENT 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)',
  `room_cadastr_num` VARCHAR(100) NOT NULL COMMENT 'Кадастровый номер помещения',
  `room_room_cadastr_num` VARCHAR(100) NOT NULL COMMENT 'Кадастровый номер комнаты в помещении',
  `room_start_date` DATE NULL DEFAULT '1900-09-13' COMMENT 'Начало действия записи',
  `room_update_date` DATE NULL DEFAULT '2011-09-13' COMMENT 'Дата  внесения записи',
  `room_end_date` DATE NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
  PRIMARY KEY (`room_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Классификатор помещениях';


-- -----------------------------------------------------
-- Table `fiasdb`.`stead`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`stead` (
  `stead_id` BIGINT NOT NULL AUTO_INCREMENT,
  `stead_gu_id` VARCHAR(36) NOT NULL COMMENT 'Глобальный уникальный идентификатор адресного объекта (земельного участка)',
  `stead_stead_id` VARCHAR(36) NOT NULL COMMENT 'Уникальный идентификатор записи. Ключевое поле.',
  `stead_parent_gu_id` VARCHAR(36) NOT NULL COMMENT 'Идентификатор объекта родительского объекта',
  `stead_prev_id` VARCHAR(36) NOT NULL COMMENT 'Идентификатор записи связывания с предыдушей исторической записью',
  `stead_next_id` VARCHAR(36) NOT NULL COMMENT 'Идентификатор записи  связывания с последующей исторической записью',
  `stead_norm_doc` VARCHAR(36) NOT NULL COMMENT 'Внешний ключ на нормативный документ',
  `stead_number` VARCHAR(120) NOT NULL COMMENT 'Номер земельного участка',
  `stead_region_code` TINYINT NOT NULL COMMENT 'Код региона',
  `stead_postal_code` INT NULL COMMENT 'Почтовый индекс',
  `stead_ifns_fiz_li` SMALLINT NULL COMMENT 'Код ИФНС ФЛ',
  `stead_ifns_ur_li` SMALLINT NULL COMMENT 'Код ИФНС ЮЛ',
  `stead_terr_ifns_fiz_li` SMALLINT NULL COMMENT 'Код территориального участка ИФНС ФЛ',
  `stead_terr_ifns_ur_li` SMALLINT NULL COMMENT 'Код территориального участка ИФНС ЮЛ',
  `stead_okato` BIGINT NULL,
  `stead_oktmo` BIGINT NULL,
  `stead_oper_status` SMALLINT NOT NULL COMMENT 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)',
  `stead_live_status` TINYINT NOT NULL COMMENT 'Признак действующего адресного объекта',
  `stead_cadastr_num` VARCHAR(100) NULL COMMENT 'Кадастровый номер',
  `stead_division_type` TINYINT NULL COMMENT 'Тип адресации:\n0 - не определено\n1 - муниципальный;\n2 - административно-территориальный',
  `stead_counter` TINYINT NOT NULL COMMENT 'Счетчик записей для КЛАДР',
  `stead_start_date` DATE NULL DEFAULT '1900-09-13' COMMENT 'Начало действия записи',
  `stead_update_date` DATE NOT NULL DEFAULT '2011-09-13' COMMENT 'Дата  внесения записи',
  `stead_end_date` DATE NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
  PRIMARY KEY (`stead_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Классификатор земельных участков';

-- -----------------------------------------------------
-- Table `fiasdb`.`last_update`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`last_update` (
  `dlast_update_id` INT NOT NULL AUTO_INCREMENT,
  `last_update_date` DATE NULL,
  PRIMARY KEY (`dlast_update_id`))
ENGINE = InnoDB
COMMENT = 'Временные метки обновлений';











SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

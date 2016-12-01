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
-- Table `fiasdb`.`estate_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`estate_status` (
  `estate_status_id` TINYINT NOT NULL,
  `estate_status_name` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL COMMENT 'Наименование',
  `estate_status_short_name` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Краткое наименование',
  PRIMARY KEY (`estate_status_id`))
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
  `structure_status_name` VARCHAR(20) NOT NULL COMMENT 'Наименование',
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
  `house_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ИФНС Физ.лиц',
  `house_okato` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКАТО',
  `house_oktmo` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКТМО',
  `house_postal_code` INT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `house_struct_num` VARCHAR(10) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Номер строения\nРанее было not null\nМогут быть буквы!',
  `house_strstatus` TINYINT NOT NULL DEFAULT 0 COMMENT 'Признак строения, от 0 до 3',
  `house_counter` TINYINT NOT NULL DEFAULT 1 COMMENT 'Счетчик записей домов для КЛАДР ',
  `house_cadastr_num` VARCHAR(100) NOT NULL COMMENT 'Кадастровый номер',
  `house_division_type` TINYINT NOT NULL COMMENT 'Тип деления: \n0 – не определено\n1 – муниципальное\n2 – административное',
  `house_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Начало действия записи',
  `house_updatedate` DATE NOT NULL DEFAULT '2011-09-13' COMMENT 'Дата внесения записи',
  `house_enddate` DATE NOT NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
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
  `house_interval_okato` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКАТО',
  `house_interval_oktmo` BIGINT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКТМО',
  `house_interval_postal_code` INT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `house_interval_counter` TINYINT NOT NULL DEFAULT 1 COMMENT 'Счётчик записей домов для КЛАДР 4 чаще всего встречается ',
  `house_interval_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Дата начала записи',
  `house_interval_updatedate` DATE NOT NULL DEFAULT '2011-09-13' COMMENT 'Дата внесения записи',
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
  `landmark_ao_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Идентификатор объекта родительского объекта',
  `landmark_land_id` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Уникальный идентификатор записи ориентира',
  `landmark_land_guid` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Глобальный уникальный идентификатор ориентира',
  `landmark_normdoc` VARCHAR(36) CHARACTER SET 'utf8' NOT NULL COMMENT 'Внешний ключ на нормативный документ',
  `landmark_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ФЛ',
  `landmark_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код ИФНС ЮЛ',
  `landmark_terr_ifns_fiz_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ФЛ',
  `landmark_terr_ifns_ur_li` SMALLINT NULL DEFAULT NULL COMMENT 'Код территориального участка ЮЛ',
  `landmark_location` TEXT(500) CHARACTER SET 'utf8' NULL DEFAULT NULL COMMENT 'Местоположение ориентира',
  `landmark_okato` BIGINT NULL DEFAULT NULL  COMMENT 'Код по справочнику ОКАТО',
  `landmark_oktmo` INT NULL DEFAULT NULL COMMENT 'Код по справочнику ОКТМО',
  `landmark_postal_code` BIGINT NULL DEFAULT NULL COMMENT 'Почтовый код',
  `landmark_startdate` DATE NOT NULL DEFAULT '1900-01-01' COMMENT 'Дата начала записи',
  `landmark_updatedate` DATE NOT NULL DEFAULT '2011-09-13' COMMENT 'Дата внесения записи',
  `landmark_enddate` DATE NOT NULL DEFAULT '2079-06-06' COMMENT 'Окончание действия записи',
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
  `stead_okato` BIGINT NULL COMMENT 'Код по справочнику ОКАТО',
  `stead_oktmo` BIGINT NULL COMMENT 'Код по справочнику ОКТМО',
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
  `last_update_id` INT NOT NULL AUTO_INCREMENT,
  `last_update_date` DATE NULL COMMENT 'Дата последнего обновления дельты ФИАС',
  PRIMARY KEY (`last_update_id`))
ENGINE = InnoDB
COMMENT = 'Временные метки обновлений';

-- INSERT IGNORE INTO `fiasdb`.`last_update` (last_update_id, last_update_date) VALUES ('0', '2016-11-17');

-- -----------------------------------------------------
-- Table `fiasdb`.`federal_district`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fiasdb`.`federal_district` (
  `federal_district_id` INT NOT NULL AUTO_INCREMENT,
  `federal_district_name` VARCHAR(63) NOT NULL COMMENT 'Наименование федерального округа',
  `federal_district_short_name` VARCHAR(31) NOT NULL COMMENT 'Наименование федерального округа сокращенное',
  PRIMARY KEY (`federal_district_id`))
ENGINE = InnoDB
COMMENT = 'Федеральные округа';
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (1, 'Центральный федеральный округ', 'Центральный ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (2, 'Северо-Западный федеральный округ', 'Северо-Западный ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (3, 'Южный федеральный округ', 'Южный ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (4, 'Северо-Кавказский федеральный округ', 'Северо-Кавказский ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (5, 'Приволжский федеральный округ', 'Приволжский ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (6, 'Уральский федеральный округ', 'Уральский ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (7, 'Сибирский федеральный округ', 'Сибирский ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (8, 'Дальневосточный федеральный округ', 'Дальневосточный ФО');
-- INSERT INTO `fiasdb`.`federal_district` (federal_district_id, federal_district_name, federal_district_short_name) VALUES (9, 'Крымский федеральный округ', 'Крымский ФО');

CREATE TABLE IF NOT EXISTS `fiasdb`.`federal_district_region` (
  `federal_district_region_district_id` INT NOT NULL,
  `federal_district_region_region_id` INT NOT NULL,
  PRIMARY KEY (`federal_district_region_district_id`, `federal_district_region_region_id`))
ENGINE = InnoDB
COMMENT = 'Промежуточная таблица связи федеральных округов и регионов';

-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 31); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 32); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 33); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 36); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 37); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 40); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 44); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 46); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 48); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 50); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 57); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 62); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 67); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 68); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 69); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 71); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 76); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (1, 77); -- центр
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 10); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 11); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 29); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 35); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 39); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 47); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 51); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 53); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 60); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (2, 78); -- Северо-Западный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 1); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 8); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 23); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 30); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 34); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 61); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (9, 91); -- Крымский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (9, 92); -- Крымский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (3, 99); -- Южный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 5); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 6); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 7); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 9); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 15); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 20); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 26); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (4, 83); -- Северо-Кавказский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 2); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 12); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 13); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 16); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 18); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 21); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 43); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 52); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 56); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 58); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 59); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 63); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 64); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (5, 73); -- Приволжский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 45); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 66); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 72); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 74); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 86); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (6, 89); -- Уральский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 3); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 4); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 17); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 19); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 22); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 24); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 38); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 42); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 54); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 55); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 70); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (7, 75); -- Сибирский
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 14); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 25); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 27); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 28); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 41); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 49); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 65); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 79); -- Дальневосточный
-- INSERT INTO `fiasdb`.`federal_district_region` (federal_district_region_district_id, federal_district_region_region_id) VALUES (8, 87); -- Дальневосточный

CREATE TABLE IF NOT EXISTS `fiasdb`.`address_object_type_order` (
  `address_object_type_order_id` INT NOT NULL AUTO_INCREMENT,
  `address_object_type_order_guid` VARCHAR(36) NOT NULL COMMENT 'Внешний ключ на address_object',
  `address_object_type_order_order` TINYINT NOT NULL COMMENT 'Положение типа объекта (начало - 0, конец - 1, нет - 3)',
  `address_object_type_order_type` VARCHAR(31) NOT NULL COMMENT 'Тип адресного объекта',
  PRIMARY KEY (`address_object_type_order_id`))
ENGINE = InnoDB
COMMENT = 'Типы адресных объектов';

INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('639efe9d-3fc8-4438-8e70-ec4f2321f2a7', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('f5807226-8be0-4ea8-91fc-39d053aec1e2', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('b8837188-39ee-4ff9-bc91-fcc9ed451bb3', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('b756fe6b-bbd3-44d5-9302-5bfcc740f46e', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('0824434f-4098-4467-af72-d4f702fed335', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('18133adf-90c2-438e-88c4-62c41656de70', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('15784a67-8cea-425b-834a-6afe0e3ed61c', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('ee594d5e-30a9-40dc-b9f2-0add1be44ba1', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('1490490e-49c5-421c-9572-5673ba5d80c8', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('29251dcf-00a1-4e34-98d4-5c47484a36d4', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('5e465691-de23-4c4e-9f46-f35a125b5970', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('963073ee-4dfc-48bd-9a70-d2dfc6bd1f31', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('e8502180-6d08-431b-83ea-c7038f0df905', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('a9a71961-9363-44ba-91b5-ddf0463aebc2', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('61723327-1c20-42fe-8dfa-402638d9b396', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('d028ec4f-f6da-4843-ada6-b68b3e0efa3d', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('a84b2ef4-db03-474b-b552-6229e801ae9b', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('0c5b2444-70a0-4932-980c-b4dc0d3f02b5', 0, 'г.');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('248d8071-06e1-425e-a1cf-d1ff4c4a14a8', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('c20180d9-ad9c-46d1-9eff-d60bc424592a', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('294277aa-e25d-428c-95ad-46719c4ddb44', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('ed36085a-b2f5-454f-b9a9-1c9a678ee618', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('90c7181e-724f-41b3-b6c6-bd3ec7ae3f30', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('6d1ebb35-70c6-4129-bd55-da3969658f5d', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('1c727518-c96a-4f34-9ae6-fd510da3be03', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('e5a84b81-8ea1-49e3-b3c4-0528651be129', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('f6e148a1-c9d0-4141-a608-93e3bd95e6c4', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('c2deb16a-0330-4f05-821f-1d09c93331e6', 0, 'г.');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('d8327a56-80de-4df2-815c-4f6ab1224c50', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('491cde9d-9d76-4591-ab46-ea93c079e686', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('d00e1013-16bd-4c09-b3d5-3cb09fc54bd8', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('83009239-25cb-4561-af8e-7ee111b1cb73', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('da051ec8-da2e-4a66-b542-473b8d221ab4', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('f10763dc-63e3-48db-83e1-9c566fe3092b', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('0bb7fa19-736d-49cf-ad0e-9774c4dae09b', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('b2d8cd20-cabc-4deb-afad-f3c4b4d55821', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('1781f74e-be4a-4697-9c6b-493057c94818', 1, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('61b95807-388a-4cb1-9bee-889f7cf811c8', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('de459e9c-2933-4923-83d1-9c64cfd7a817', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('de67dc49-b9ba-48a3-a4cc-c2ebfeca6c5e', 1, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('327a060b-878c-4fb4-8dc4-d5595871a3d8', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('89db3198-6803-4106-9463-cbf781eff0b8', 1, 'автономный округ');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('6f2cbfd8-692a-4ee4-9b16-067210bde3fc', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('de2cbfdf-9662-44a4-a4a4-8ad237ae4a3e', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('37a0c60a-9240-48b5-a87f-0d8c86cdb6e1', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('0c089b04-099e-4e0e-955a-6bf1ce525f1a', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('52618b9c-bcbb-47e7-8957-95c63f0b17cc', 1, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('878fc621-3708-46c7-a97f-5a13a4176b3e', 3, '');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('0b940b96-103f-4248-850c-26b6c7296728', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('88cd27e2-6a8a-4421-9718-719a28a0a088', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('8bcec9d6-05bc-4e53-b45c-ba0c6f3a5c44', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('c99e7924-0428-4107-a302-4fd7c0cca3ff', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('4f8b1a21-e4bb-422f-9087-d3cbf4bebc14', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('df3d7359-afa9-4aaa-8ff9-197e73906b1c', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('df594e0e-a935-4664-9d26-0bae13f904fe', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('fee76045-fe22-43a4-ad58-ad99e903bd58', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('4a3d970f-520e-46b9-b16c-50d4ca7535a8', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('92b30014-4d52-4e2e-892d-928142b924bf', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('54049357-326d-4b8f-b224-3c6dc25d6dd3', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('27eb7c10-a234-44da-a59c-8b1f864966de', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('d66e5325-3a25-4d29-ba86-4ca351d9704b', 3, '');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('826fa834-3ee8-404f-bdbc-13a5221cfb6e', 1, 'автономный округ');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('a84ebed3-153d-4ba9-8532-8bdf879e1f5a', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('5c48611f-5de6-4771-9695-7e36a4e7529d', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('026bc56f-3731-48e9-8245-655331f596c0', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('8d3f1d35-f0f4-41b5-b5b7-e7cadf3e7bd7', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('8276c6a1-1a86-4f0d-8920-aba34d4cc34a', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('db9c4f8b-b706-40e2-b2b4-d31b98dcd3d1', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('6466c988-7ce3-45e5-8b97-90ae16cb1249', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('393aeccb-89ef-4a7e-ae42-08d5cebc2e30', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('1ac46b49-3209-4814-b7bf-a509ea1aecd9', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('05426864-466d-41a3-82c4-11e61cdc98ce', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('889b1f3a-98aa-40fc-9d3d-0f41192758ab', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('b6ba5716-eb48-401b-8443-b197c9578734', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('c225d3db-1db6-4063-ace0-b3fe9ea3805f', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('43909681-d6e1-432d-b61f-ddac393cb5da', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('7d468b39-1afa-41ec-8c4f-97a8603cb3d4', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('844a80d6-5e31-4017-b422-4d9c01e9942c', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('d02f30fc-83bf-4c0f-ac2b-5729a866a207', 1, 'край');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('9c05e812-8679-4710-b8cb-5e8bd43cdf48', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('aea6280f-4648-460f-b8be-c2bc18923191', 1, 'область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('1b507b09-48c9-434f-bf6f-65066211c73e', 1, 'автономная область');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('f136159b-404a-4f1f-8d8d-d169e1374d5c', 1, 'автономный округ');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('bd8e6511-e4b9-4841-90de-6bbc231a789e', 0, 'Республика');
INSERT INTO `fiasdb`.`address_object_type_order` (address_object_type_order_guid, address_object_type_order_order, address_object_type_order_type) VALUES ('6fdecb78-893a-4e3f-a5ba-aa062459463b', 0, 'г.');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

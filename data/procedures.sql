DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fulltext_addr`(IN `text` VARCHAR(100) CHARSET utf8)
BEGIN
  DECLARE done INT DEFAULT 0;
	DECLARE ao_level, ao_level1 INT DEFAULT NULL ;
	DECLARE parent_id, parent_id1, ao_guid VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp, text_tmp1 VARCHAR(100) DEFAULT NULL;
  DECLARE text_out_tmp VARCHAR(250) DEFAULT NULL;
	DECLARE cur1 CURSOR FOR SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid FROM address_object WHERE MATCH (address_object_formal_name) AGAINST (CONCAT('"',  text, '"')) AND address_object_actual_status = 1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  CREATE TEMPORARY TABLE T1(ao_id varchar(36),full_addr VARCHAR(250));
  OPEN cur1;
  read_loop: LOOP
      FETCH cur1 INTO ao_level, parent_id, text_tmp, ao_guid;

      SET text_out_tmp = text_tmp;
	    SET ao_level1 = ao_level;
      SET parent_id1 = parent_id;
      WHILE ao_level1 > 1 DO
		    SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name) INTO ao_level1, parent_id1, text_tmp1 FROM address_object FORCE INDEX (ao_guid_idx) WHERE address_object_guid = parent_id1 COLLATE utf8_unicode_ci AND address_object_actual_status = 1 LIMIT 1;
	      SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
	    END WHILE;

      INSERT INTO T1(ao_id,full_addr) VALUES (ao_guid,text_out_tmp);
      IF done = 1 THEN
        LEAVE read_loop;
      END IF;
  END LOOP;
  CLOSE cur1;
	Select * from T1;
    drop temporary table if exists T1;
  END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `full_addr`(IN `text` VARCHAR(100) CHARSET utf8)
BEGIN
    DECLARE done INT DEFAULT 0;
	DECLARE ao_level, ao_level1 INT DEFAULT NULL ;
	DECLARE parent_id, parent_id1, ao_guid VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp, text_tmp1 VARCHAR(100) DEFAULT NULL;
    DECLARE text_out_tmp VARCHAR(100) DEFAULT NULL;
	DECLARE cur1 CURSOR FOR SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_official_name), address_object_guid FROM address_object WHERE address_object_actual_status = 1 AND address_object_formal_name LIKE CONCAT('%', text , '%') LIMIT 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    CREATE TEMPORARY TABLE T1(ao_id varchar(36),full_addr VARCHAR(100));
    OPEN cur1;
    read_loop: LOOP
      FETCH cur1 INTO ao_level, parent_id, text_tmp, ao_guid;

    SET text_out_tmp = text_tmp;
	SET ao_level1 = ao_level;
SET parent_id1 = parent_id;
       WHILE ao_level1 > 1 DO
		SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_official_name) INTO ao_level1, parent_id1, text_tmp1 FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id1 COLLATE utf8_unicode_ci;
	    SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
	END WHILE;

    INSERT INTO T1(ao_id,full_addr) VALUES (ao_guid,text_out_tmp);
    IF done = 1 THEN
       LEAVE read_loop;
    END IF;
  END LOOP;
  CLOSE cur1;
	 Select * from T1;
     drop temporary table if exists T1;
  END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `full_addr_by_id`(IN `id` VARCHAR(36) CHARSET utf8, IN `lev` TINYINT, OUT `text_out` VARCHAR(100) CHARSET utf8)
BEGIN
	DECLARE ao_level INT DEFAULT NULL ;
	DECLARE parent_id VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp VARCHAR(100) DEFAULT NULL;

	SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name)  INTO ao_level, parent_id, text_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = id COLLATE utf8_general_ci LIMIT 1;
	SET text_out = text_tmp;

 IF lev >= 1 THEN
	WHILE ao_level > lev DO
		SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name) INTO ao_level, parent_id, text_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id COLLATE utf8_general_ci LIMIT 1;
        if (ao_level >= lev) THEN
	    	SET text_out = CONCAT(text_tmp, ', ' , text_out);
         END IF;
	END WHILE;
 END IF;
 SELECT text_out;
  END$$
DELIMITER ;

-- COLLATE utf8_general_ci


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fulltext_addr_by_level_and_id`(IN `text` VARCHAR(100) CHARSET utf8, IN `id` VARCHAR(36) CHARSET utf8, IN `lev_from` VARCHAR(31) CHARSET utf8, IN `lev_to` INT, IN `reg_id` INT, IN `lim` INT)
BEGIN
  DECLARE mos, pit, sev, bai VARCHAR(36) DEFAULT '';
  DECLARE mosText, pitText, sevText, baiText VARCHAR(36) DEFAULT '';
  DECLARE done, res INT DEFAULT 0;
	DECLARE ao_level, ao_level1 INT DEFAULT NULL ;
	DECLARE parent_id, parent_id1, ao_guid, ao_guid_top VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp, text_tmp1 VARCHAR(100) DEFAULT NULL;
  DECLARE text_out_tmp VARCHAR(250) DEFAULT NULL;
	DECLARE cur1 CURSOR FOR SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid
	  FROM address_object
	  WHERE MATCH (address_object_formal_name) AGAINST (CONCAT('',  text, '*') IN BOOLEAN MODE)
      AND address_object_actual_status = 1
      AND address_object_region_code = reg_id
      AND address_object_next_id = ''
      AND FIND_IN_SET(address_object_level, lev_from);
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  CREATE TEMPORARY TABLE T1(value varchar(36), text VARCHAR(250));
  SET mos = '0c5b2444-70a0-4932-980c-b4dc0d3f02b5';
  SET pit = 'c2deb16a-0330-4f05-821f-1d09c93331e6';
  SET sev = '6fdecb78-893a-4e3f-a5ba-aa062459463b';
  SET bai = '63ed1a35-4be6-4564-a1ec-0c51f7383314';
  SET mosText = 'г. Москва';
  SET pitText = 'г. Санкт-Петербург';
  SET sevText = 'г. Севастополь';
  SET baiText = 'г. Байконур';
  OPEN cur1;
  read_loop: LOOP
      FETCH cur1 INTO ao_level, parent_id, text_tmp, ao_guid;

      SET text_out_tmp = text_tmp;
	  SET ao_level1 = ao_level;
      SET parent_id1 = parent_id;
      WHILE ao_level1 > lev_to DO
		    SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid INTO ao_level1, parent_id1, text_tmp1, ao_guid_top FROM address_object FORCE INDEX (ao_guid_idx) WHERE address_object_guid = parent_id1 COLLATE utf8_general_ci AND address_object_actual_status = 1 LIMIT 1;
            IF (ao_level1 != lev_to AND lev_to != 4) THEN
	      		SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
            ELSEIF(lev_to = 4 AND ao_level1 >= 7) THEN
                SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
	    	END IF;
        END WHILE;

      IF ao_guid_top = id THEN
        INSERT INTO T1(value, text) VALUES (ao_guid,text_out_tmp);
      	SET res = res + 1;
      END IF;

      IF done = 1 OR res > lim THEN
        LEAVE read_loop;
      END IF;
  END LOOP;
  CLOSE cur1;
  IF id = mos AND lev_to = 1 THEN
        INSERT INTO T1(value, text) VALUES (mos, mosText);
      	SET res = res + 1;
  END IF;
  IF id = pit AND lev_to = 1 THEN
        INSERT INTO T1(value, text) VALUES (pit,pitText);
      	SET res = res + 1;
  END IF;
  IF id = sev AND lev_to = 1  THEN

        INSERT INTO T1(value, text) VALUES (sev,sevText);
      	SET res = res + 1;
  END IF;
  IF id = bai AND lev_to = 1  THEN
        INSERT INTO T1(value, text) VALUES (bai,baiText);
      	SET res = res + 1;
  END IF;
	IF (res > 1) OR (res = 1) THEN
        SELECT DISTINCT * from T1;
	END IF;
    drop temporary table if exists T1;
  END$$
DELIMITER ;
CALL fulltext_addr_by_level_and_id('острякова', '6fdecb78-893a-4e3f-a5ba-aa062459463b', '7,75,90,91', 4, 92)
CALL fulltext_addr_by_level_and_id('орел', '1490490e-49c5-421c-9572-5673ba5d80c8', '4,6', 1, 23)


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `street_by_level_and_id`(IN `text` VARCHAR(100) CHARSET utf8, IN `id` VARCHAR(36) CHARSET utf8, IN `lev_from` VARCHAR(31) CHARSET utf8, IN `lev_to` INT, IN `reg_id` INT, IN `lim` INT)
BEGIN
  DECLARE mos, pit, sev, bai VARCHAR(36) DEFAULT '';
  DECLARE mosText, pitText, sevText, baiText VARCHAR(36) DEFAULT '';
  DECLARE done, res INT DEFAULT 0;
	DECLARE ao_level, ao_level1 INT DEFAULT NULL ;
	DECLARE parent_id, parent_id1, ao_guid, ao_guid_top VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp, text_tmp1 VARCHAR(100) DEFAULT NULL;
  DECLARE text_out_tmp VARCHAR(250) DEFAULT NULL;
	DECLARE cur1 CURSOR FOR SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid
	  FROM address_object
	  WHERE MATCH (address_object_formal_name) AGAINST (CONCAT('',  text, '*') IN BOOLEAN MODE)
      AND address_object_actual_status = 1
      AND address_object_region_code = reg_id
      AND address_object_next_id = ''
      AND address_object_parent_guid = id COLLATE utf8_general_ci
      AND FIND_IN_SET(address_object_level, lev_from);
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  CREATE TEMPORARY TABLE T1(value varchar(36), text VARCHAR(250));

  OPEN cur1;
  read_loop: LOOP
      FETCH cur1 INTO ao_level, parent_id, text_tmp, ao_guid;

      SET text_out_tmp = text_tmp;
	  SET ao_level1 = ao_level;
      SET parent_id1 = parent_id;
      WHILE ao_level1 > lev_to DO
		    SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid INTO ao_level1, parent_id1, text_tmp1, ao_guid_top FROM address_object FORCE INDEX (ao_guid_idx) WHERE address_object_guid = parent_id1 COLLATE utf8_general_ci AND address_object_actual_status = 1 LIMIT 1;
            IF (ao_level1 != lev_to AND lev_to != 4) THEN
	      		SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
            ELSEIF(lev_to = 4 AND ao_level1 >= 7) THEN
                SET text_out_tmp = CONCAT(text_tmp1, ', ' , text_out_tmp);
	    	END IF;
        END WHILE;

      IF ao_guid_top = id THEN
        INSERT INTO T1(value, text) VALUES (ao_guid,text_out_tmp);
      	SET res = res + 1;
      END IF;

      IF done = 1 OR res > lim THEN
        LEAVE read_loop;
      END IF;
  END LOOP;
  CLOSE cur1;

	IF (res > 1) OR (res = 1) THEN
        SELECT DISTINCT * from T1;
	END IF;
    drop temporary table if exists T1;
  END$$
DELIMITER ;
CALL street_by_level_and_id('вост', '7dfa745e-aa19-4688-b121-b655c11e482f', '7,75,90,91', 4, 23, 10)


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `full_addr_arr_by_id`(IN `id` VARCHAR(36) CHARSET utf8)
BEGIN
	DECLARE ao_level INT DEFAULT NULL ;
	DECLARE parent_id, parent_id_main, ao_guid, ao_guid_tmp VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp VARCHAR(100) DEFAULT NULL;
	DECLARE text_out VARCHAR(250) DEFAULT NULL;
  CREATE TEMPORARY TABLE T2(name VARCHAR(10), ao_id varchar(36),full_addr VARCHAR(250));
	SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name)  INTO ao_level, parent_id, text_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = id COLLATE utf8_general_ci LIMIT 1;
	SET text_out = text_tmp;
	SET parent_id_main = parent_id;
	SET ao_guid = id;

	WHILE ao_level >=7 DO
		SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid INTO ao_level, parent_id, text_tmp, ao_guid_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id COLLATE utf8_general_ci LIMIT 1;
     IF (ao_level >= 7) THEN
        SET text_out = CONCAT(text_tmp, ', ' , text_out);
     END IF;
	END WHILE;
    INSERT INTO T2(name, ao_id,full_addr) VALUES ('street', ao_guid,text_out);
	  SET text_out = '';
	IF (ao_level < 7) THEN
      SET text_out = text_tmp;
  END IF;
  SET ao_guid = ao_guid_tmp;

  WHILE ao_level >=3 DO
		SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid INTO ao_level, parent_id, text_tmp, ao_guid_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id COLLATE utf8_general_ci LIMIT 1;
    IF (ao_level >= 3) THEN
        SET text_out = CONCAT(text_tmp, ', ' , text_out);
     END IF;
	END WHILE;
  INSERT INTO T2(name, ao_id,full_addr) VALUES ('city', ao_guid,text_out);
  SET text_out = '';
  IF (ao_level < 3) THEN
      SET text_out = text_tmp;
  END IF;
  SET ao_guid = ao_guid_tmp;

    WHILE ao_level > 1 DO
		SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_formal_name), address_object_guid INTO ao_level, parent_id, text_tmp, ao_guid_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id COLLATE utf8_general_ci LIMIT 1;
     IF (ao_level >= 1) THEN
        SET text_out = CONCAT(text_tmp, ', ' , text_out);
     END IF;
	END WHILE;
  INSERT INTO T2(name, ao_id,full_addr) VALUES ('region', ao_guid_tmp,text_out);

 SELECT DISTINCT * from T2;
 drop temporary table if exists T2;
  END$$
DELIMITER ;
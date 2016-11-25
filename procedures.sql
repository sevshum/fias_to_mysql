DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `full_addr_by_id`(IN `id` VARCHAR(36) CHARSET utf8, OUT `text_out` VARCHAR(100) CHARSET utf8)
BEGIN
	DECLARE ao_level INT DEFAULT NULL ;
	DECLARE parent_id VARCHAR(36) DEFAULT NULL;
	DECLARE text_tmp VARCHAR(100) DEFAULT NULL;

	SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_official_name)  INTO ao_level, parent_id, text_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = id COLLATE utf8_unicode_ci;
	SET text_out = text_tmp;


	WHILE ao_level > 1 DO
		SELECT address_object_level, address_object_parent_guid, address_object_official_name INTO ao_level, parent_id, text_tmp FROM address_object WHERE address_object_actual_status = 1 AND address_object_guid = parent_id COLLATE utf8_unicode_ci;
	    SET text_out = CONCAT(text_tmp, ', ' , text_out);
	END WHILE;
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
	DECLARE cur1 CURSOR FOR SELECT address_object_level, address_object_parent_guid, CONCAT(address_object_type_shortname, '. ', address_object_official_name), address_object_guid FROM address_object WHERE address_object_actual_status = 1 AND address_object_formal_name LIKE CONCAT('%', text , '%');
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
  END$$
DELIMITER ;


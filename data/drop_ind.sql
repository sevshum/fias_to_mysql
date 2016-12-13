-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- stead table

-- ALTER TABLE `fiasdb`.`stead`
--   DROP FOREIGN KEY `fk_stead_oper_status`;
-- ALTER TABLE `fiasdb`.`stead`
--   DROP FOREIGN KEY `fk_stead_norm_doc`;
ALTER TABLE `fiasdb`.`stead`
  DROP FOREIGN KEY `fk_stead_address_object`;

-- room table

-- ALTER TABLE `fiasdb`.`room`
--   DROP FOREIGN KEY `fk_room_oper_status`;
ALTER TABLE `fiasdb`.`room`
  DROP FOREIGN KEY `fk_room_house`;
-- ALTER TABLE `fiasdb`.`room`
--   DROP FOREIGN KEY `fk_room_norm_doc`;

  -- landmark table

-- ALTER TABLE `fiasdb`.`landmark`
--   DROP FOREIGN KEY `fk_landmark_norm_doc`;
ALTER TABLE `fiasdb`.`landmark`
  DROP FOREIGN KEY `fk_landmark_address_object`;

  -- house_int table
-- ALTER TABLE `fiasdb`.`house_interval`
--   DROP FOREIGN KEY `fk_house_interval_norm_doc`;
ALTER TABLE `fiasdb`.`house_interval`
  DROP FOREIGN KEY `fk_house_interval_address_object`;
-- ALTER TABLE `fiasdb`.`house_interval`
--   DROP FOREIGN KEY `fk_house_interval_interv_status`;


-- house table

-- ALTER TABLE `fiasdb`.`house`
--   DROP FOREIGN KEY `fk_house_estate_status`;
-- ALTER TABLE `fiasdb`.`house`
--   DROP FOREIGN KEY `fk_house_norm_doc`;
ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_address_object`;
-- ALTER TABLE `fiasdb`.`house`
--   DROP FOREIGN KEY `fk_house_house_status`;
-- ALTER TABLE `fiasdb`.`house`
--   DROP FOREIGN KEY `fk_house_str_status`;

-- address_object table

-- ALTER TABLE `fiasdb`.`address_object`
--   DROP FOREIGN KEY `fk_address_object_norm_doc`;
-- ALTER TABLE `fiasdb`.`address_object`
--   DROP FOREIGN KEY `fk_address_object_operation_status`;
-- ALTER TABLE `fiasdb`.`address_object`
--   DROP FOREIGN KEY `fk_address_object_current_status`;
-- ALTER TABLE `fiasdb`.`address_object`
--   DROP FOREIGN KEY `fk_address_object_center_status`;
-- ALTER TABLE `fiasdb`.`address_object`
--   DROP FOREIGN KEY `fk_address_object_actual_status`;

  -- norm_doc table

-- ALTER TABLE `fiasdb`.`norm_doc`
--   DROP FOREIGN KEY `fk_norm_doc_norm_doc_type`;

-- ALTER TABLE `fiasdb`.`federal_district_region`
--   DROP FOREIGN KEY `fk_federal_district_region_federal_district`;

-- stead table
DROP INDEX `fk_stead_address_object_idx` ON `fiasdb`.`stead`;
-- DROP INDEX `fk_stead_oper_status_idx` ON `fiasdb`.`stead`;
-- DROP INDEX `fk_stead_norm_doc_idx` ON `fiasdb`.`stead`;

-- room table
-- DROP INDEX `fk_room_oper_status_idx` ON `fiasdb`.`room`;
DROP INDEX `fk_room_house_idx` ON `fiasdb`.`room`;
-- DROP INDEX `r_prev_idx` ON `fiasdb`.`room`;
-- DROP INDEX `r_next_idx` ON `fiasdb`.`room`;
-- DROP INDEX `fk_room_norm_doc_idx` ON `fiasdb`.`room`;

-- landmark table
-- DROP INDEX `fk_landmark_norm_doc_idx` ON `fiasdb`.`landmark`;
DROP INDEX `fk_landmark_address_object_idx` ON `fiasdb`.`landmark`;

-- house_int table
-- DROP INDEX `hi_int_guid_idx` ON `fiasdb`.`house_interval`;
-- DROP INDEX `hi_houseint_guid_idx` ON `fiasdb`.`house_interval`;
-- DROP INDEX `fk_house_interval_norm_doc_idx` ON `fiasdb`.`house_interval`;
DROP INDEX `fk_house_interval_address_object_idx` ON `fiasdb`.`house_interval`;
-- DROP INDEX `fk_house_interval_interv_status_idx` ON `fiasdb`.`house_interval`;

-- house table
DROP INDEX `h_guid_idx` ON `fiasdb`.`house`;
-- DROP INDEX `h_id_idx` ON `fiasdb`.`house`;
-- DROP INDEX `fk_house_estate_status_idx` ON `fiasdb`.`house`;
-- DROP INDEX `fk_house_norm_doc_idx` ON `fiasdb`.`house`;
DROP INDEX `fk_house_address_object_idx` ON `fiasdb`.`house`;
-- DROP INDEX `fk_house_house_status_idx` ON `fiasdb`.`house`;
-- DROP INDEX `fk_house_str_status_idx` ON `fiasdb`.`house`;


-- norm_doc table
DROP INDEX `nd_normdoc_id_idx` ON `fiasdb`.`norm_doc`;
-- DROP INDEX `fk_norm_doc_norm_doc_type_idx` ON `fiasdb`.`norm_doc`;


-- address_object table
DROP INDEX `ao_guid_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_level_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_actual_status_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_region_code_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_parent_guid_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_next_id_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_prev_id_idx` ON `fiasdb`.`address_object`;
DROP INDEX `ao_formal_name_idx` ON `fiasdb`.`address_object`;

-- DROP INDEX `ao_ao_id` ON `fiasdb`.`address_object`;
-- DROP INDEX `fk_address_object_norm_doc_idx` ON `fiasdb`.`address_object`;
-- DROP INDEX `fk_address_object_operation_status_idx` ON `fiasdb`.`address_object`;
-- DROP INDEX `fk_address_object_current_status_idx` ON `fiasdb`.`address_object`;
-- DROP INDEX `fk_address_object_center_status_idx` ON `fiasdb`.`address_object`;
-- DROP INDEX `fk_address_object_actual_status_idx` ON `fiasdb`.`address_object`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
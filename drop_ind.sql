-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- stead table

ALTER TABLE `fiasdb`.`stead`
  DROP FOREIGN KEY `fk_stead_oper_status`;
ALTER TABLE `fiasdb`.`stead`
  DROP FOREIGN KEY `fk_stead_norm_doc`;

-- room table

ALTER TABLE `fiasdb`.`room`
  DROP FOREIGN KEY `fk_room_oper_status`;
ALTER TABLE `fiasdb`.`room`
  DROP FOREIGN KEY `fk_room_house`;
ALTER TABLE `fiasdb`.`room`
  DROP FOREIGN KEY `fk_room_norm_doc`;

  -- landmark table

ALTER TABLE `fiasdb`.`landmark`
  DROP FOREIGN KEY `fk_landmark_norm_doc`;
ALTER TABLE `fiasdb`.`house_interval`
  DROP FOREIGN KEY `fk_landmark_address_object`;

  -- house_int table
ALTER TABLE `fiasdb`.`house_interval`
  DROP FOREIGN KEY `fk_house_interval_norm_doc`;
ALTER TABLE `fiasdb`.`house_interval`
  DROP FOREIGN KEY `fk_house_interval_address_object`;
ALTER TABLE `fiasdb`.`house_interval`
  DROP FOREIGN KEY `fk_house_interval_interv_status`;


-- house table

ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_estate_status`;
ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_norm_doc`;
ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_address_object`;
ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_house_status`;
ALTER TABLE `fiasdb`.`house`
  DROP FOREIGN KEY `fk_house_str_status`;

-- address_object table

ALTER TABLE `fiasdb`.`address_object`
  DROP FOREIGN KEY `fk_address_object_norm_doc`;
ALTER TABLE `fiasdb`.`address_object`
  DROP FOREIGN KEY `fk_address_object_operation_status`;
ALTER TABLE `fiasdb`.`address_object`
  DROP FOREIGN KEY `fk_address_object_current_status`;
ALTER TABLE `fiasdb`.`address_object`
  DROP FOREIGN KEY `fk_address_object_center_status`;
ALTER TABLE `fiasdb`.`address_object`
  DROP FOREIGN KEY `fk_address_object_actual_status`;

  -- norm_doc table

ALTER TABLE `fiasdb`.`norm_doc`
  DROP FOREIGN KEY `norm_doc_doc_type`;

-- stead table
DROP INDEX `fiasdb`.`stead`.`fk_stead_oper_status_idx`;
DROP INDEX `fiasdb`.`stead`.`fk_stead_norm_doc_idx`;

-- room table
DROP INDEX `fiasdb`.`room`.`fk_room_oper_status_idx`;
DROP INDEX `fiasdb`.`room`.`fk_room_house_idx`;
DROP INDEX `fiasdb`.`room`.`r_prev_idx`;
DROP INDEX `fiasdb`.`room`.`r_next_idx`;
DROP INDEX `fiasdb`.`room`.`fk_room_norm_doc_idx`;

-- landmark table
DROP INDEX `fiasdb`.`landmark`.`fk_landmark_norm_doc_idx`;
DROP INDEX `fiasdb`.`landmark`.`fk_landmark_address_object_idx`;

-- house_int table
DROP INDEX `fiasdb`.`house_interval`.`hi_int_guid_idx`;
DROP INDEX `fiasdb`.`house_interval`.`hi_houseint_guid_idx`;
DROP INDEX `fiasdb`.`house_interval`.`fk_house_interval_norm_doc_idx`;
DROP INDEX `fiasdb`.`house_interval`.`fk_house_interval_address_object_idx`;
DROP INDEX `fiasdb`.`house_interval`.`fk_house_interval_interv_status_idx`;

-- house table
DROP INDEX `fiasdb`.`house`.`h_guid_idx`;
DROP INDEX `fiasdb`.`house`.`h_id_idx`;
DROP INDEX `fiasdb`.`house`.`fk_house_estate_status_idx`;
DROP INDEX `fiasdb`.`house`.`fk_house_norm_doc_idx`;
DROP INDEX `fiasdb`.`house`.`fk_house_address_object_idx`;
DROP INDEX `fiasdb`.`house`.`fk_house_house_status_idx`;
DROP INDEX `fiasdb`.`house`.`fk_house_str_status_idx`;



-- norm_doc table
DROP INDEX `fiasdb`.`norm_doc`.`nd_normdoc_id_idx`;
DROP INDEX `fiasdb`.`norm_doc`.`nd_doc_type_idx`;
DROP INDEX `fiasdb`.`norm_doc`.`fk_norm_doc_norm_doc_type_idx`;



-- address_object table
DROP INDEX `fiasdb`.`address_object`.`ao_guid_idx`;
DROP INDEX `fiasdb`.`address_object`.`ao_parent_guid_idx`;
DROP INDEX `fiasdb`.`address_object`.`ao_next_id_idx`;
DROP INDEX `fiasdb`.`address_object`.`ao_prev_id_idx`;
DROP INDEX `fiasdb`.`address_object`.`ao_ao_id`;
DROP INDEX `fiasdb`.`address_object`.`fk_address_object_norm_doc_idx`;
DROP INDEX `fiasdb`.`address_object`.`fk_address_object_operation_status_idx`;
DROP INDEX `fiasdb`.`address_object`.`fk_address_object_current_status_idx`;
DROP INDEX `fiasdb`.`address_object`.`fk_address_object_center_status_idx`;
DROP INDEX `fiasdb`.`address_object`.`fk_address_object_actual_status_idx`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
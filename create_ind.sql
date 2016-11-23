-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- stead table

-- CREATE INDEX `fk_stead_oper_status_idx` ON `fiasdb`.`stead` (`stead_oper_status` ASC);
-- CREATE INDEX `fk_stead_norm_doc_idx` ON `fiasdb`.`stead` (`stead_norm_doc` ASC);


-- room table
CREATE INDEX `fk_room_oper_status_idx` ON `fiasdb`.`room` (`room_oper_status` ASC);
CREATE INDEX `fk_room_house_idx` ON `fiasdb`.`room` (`room_house_gu_id` ASC);
CREATE INDEX `r_prev_idx` ON `fiasdb`.`room` (`room_prev_id` ASC);
CREATE INDEX `r_next_idx` ON `fiasdb`.`room` (`room_next_id` ASC);
CREATE INDEX `fk_room_norm_doc_idx` ON `fiasdb`.`room` (`room_norm_doc` ASC);

-- landmark table
CREATE INDEX `fk_landmark_norm_doc_idx` ON `fiasdb`.`landmark` (`landmark_normdoc` ASC);
CREATE INDEX `fk_landmark_address_object_idx` ON `fiasdb`.`landmark` (`landmark_ao_guid` ASC);

-- house_int table
CREATE INDEX `hi_int_guid_idx` ON `fiasdb`.`house_interval` (`house_interval_int_guid` ASC);
CREATE INDEX `hi_houseint_guid_idx` ON `fiasdb`.`house_interval` (`house_interval_houseint_guid` ASC);
CREATE INDEX `fk_house_interval_norm_doc_idx` ON `fiasdb`.`house_interval` (`house_interval_normdoc` ASC);
CREATE INDEX `fk_house_interval_address_object_idx` ON `fiasdb`.`house_interval` (`house_interval_ao_guid` ASC);
CREATE INDEX `fk_house_interval_interv_status_idx` ON `fiasdb`.`house_interval` (`house_interval_int_status` ASC);


-- house table

CREATE INDEX `h_guid_idx` ON `fiasdb`.`house` (`house_house_guid` ASC);
CREATE INDEX `h_id_idx` ON `fiasdb`.`house` (`house_house_id` ASC);
CREATE INDEX `fk_house_estate_status_idx` ON `fiasdb`.`house` (`house_estate_status` ASC);
CREATE INDEX `fk_house_norm_doc_idx` ON `fiasdb`.`house` (`house_normdoc` ASC);
CREATE INDEX `fk_house_address_object_idx` ON `fiasdb`.`house` (`house_ao_guid` ASC);
CREATE INDEX `fk_house_house_status_idx` ON `fiasdb`.`house` (`house_stat_status` ASC);
CREATE INDEX `fk_house_str_status_idx` ON `fiasdb`.`house` (`house_strstatus` ASC);

-- norm_doc table
CREATE INDEX `nd_normdoc_id_idx` ON `fiasdb`.`norm_doc` (`norm_doc_normdoc_id` ASC);
CREATE INDEX `nd_doc_type_idx` ON `fiasdb`.`norm_doc` ();
CREATE INDEX `fk_norm_doc_norm_doc_type_idx` ON `fiasdb`.`norm_doc` (`norm_doc_doc_type` ASC);


-- address_object table
CREATE INDEX `ao_guid_idx` ON `fiasdb`.`address_object` (`address_object_guid` ASC);
CREATE INDEX `ao_parent_guid_idx` ON `fiasdb`.`address_object` (`address_object_parent_guid` ASC);
CREATE INDEX `ao_next_id_idx` ON `fiasdb`.`address_object` (`address_object_next_id` ASC);
CREATE INDEX `ao_prev_id_idx` ON `fiasdb`.`address_object` (`address_object_prev_id` ASC);
CREATE INDEX `ao_ao_id` ON `fiasdb`.`address_object` (`address_object_ao_id` ASC);
CREATE INDEX `fk_address_object_norm_doc_idx` ON `fiasdb`.`address_object` (`address_object_normdoc` ASC);
CREATE INDEX `fk_address_object_operation_status_idx` ON `fiasdb`.`address_object` (`address_object_operation_status` ASC);
CREATE INDEX `fk_address_object_current_status_idx` ON `fiasdb`.`address_object` (`address_object_curr_status` ASC);
CREATE INDEX `fk_address_object_center_status_idx` ON `fiasdb`.`address_object` (`address_object_center_status` ASC);
CREATE INDEX `fk_address_object_actual_status_idx` ON `fiasdb`.`address_object` (`address_object_actual_status` ASC);

-- stead table
ALTER TABLE `fiasdb`.`stead`
  ADD CONSTRAINT `fk_stead_oper_status`
    FOREIGN KEY (`stead_oper_status`)
    REFERENCES `fiasdb`.`operation_statuses` (`operation_statuses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`stead`
  ADD CONSTRAINT `fk_stead_norm_doc`
    FOREIGN KEY (`stead_norm_doc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- room table
ALTER TABLE `fiasdb`.`room`
  ADD CONSTRAINT `fk_room_oper_status`
    FOREIGN KEY (`room_oper_status`)
    REFERENCES `fiasdb`.`operation_statuses` (`operation_statuses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`room`
  ADD CONSTRAINT `fk_room_house`
    FOREIGN KEY (`room_house_gu_id`)
    REFERENCES `fiasdb`.`house` (`house_house_guid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`room`
  ADD CONSTRAINT `fk_room_norm_doc`
    FOREIGN KEY (`room_norm_doc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;



-- landmark table
ALTER TABLE `fiasdb`.`landmark`
  ADD CONSTRAINT `fk_landmark_norm_doc`
    FOREIGN KEY (`landmark_normdoc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`landmark`
  ADDCONSTRAINT `fk_landmark_address_object`
    FOREIGN KEY (`landmark_ao_guid`)
    REFERENCES `fiasdb`.`address_object` (`address_object_guid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


-- house_int table
ALTER TABLE `fiasdb`.`house_interval`
  ADD CONSTRAINT `fk_house_interval_norm_doc`
    FOREIGN KEY (`house_interval_normdoc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house_interval`
  ADD CONSTRAINT `fk_house_interval_address_object`
    FOREIGN KEY (`house_interval_ao_guid`)
    REFERENCES `fiasdb`.`address_object` (`address_object_guid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house_interval`
  ADD CONSTRAINT `fk_house_interval_interv_status`
    FOREIGN KEY (`house_interval_int_status`)
    REFERENCES `fiasdb`.`interv_status` (`interv_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;



-- house table
ALTER TABLE `fiasdb`.`house`
  ADD CONSTRAINT `fk_house_estate_status`
    FOREIGN KEY (`house_estate_status`)
    REFERENCES `fiasdb`.`eatate_status` (`eatate_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house`
  ADD CONSTRAINT `fk_house_norm_doc`
    FOREIGN KEY (`house_normdoc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house`
  ADD CONSTRAINT `fk_house_address_object`
    FOREIGN KEY (`house_ao_guid`)
    REFERENCES `fiasdb`.`address_object` (`address_object_guid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house`
  ADD CONSTRAINT `fk_house_house_status`
    FOREIGN KEY (`house_stat_status`)
    REFERENCES `fiasdb`.`house_status` (`house_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`house`
  ADD CONSTRAINT `fk_house_str_status`
    FOREIGN KEY (`house_strstatus`)
    REFERENCES `fiasdb`.`structure_status` (`structure_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;



-- norm_doc table
ALTER TABLE `fiasdb`.`norm_doc`
  ADD CONSTRAINT `fk_norm_doc_norm_doc_type`
  FOREIGN KEY (`norm_doc_doc_type`)
  REFERENCES `fiasdb`.`norm_doc_type` (`norm_doc_type_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


-- address_object table
ALTER TABLE `fiasdb`.`address_object`
  ADD CONSTRAINT `fk_address_object_norm_doc`
    FOREIGN KEY (`address_object_normdoc`)
    REFERENCES `fiasdb`.`norm_doc` (`norm_doc_normdoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`address_object`
  ADD CONSTRAINT `fk_address_object_operation_status`
    FOREIGN KEY (`address_object_operation_status`)
    REFERENCES `fiasdb`.`operation_statuses` (`operation_statuses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`address_object`
  ADD CONSTRAINT `fk_address_object_current_status`
    FOREIGN KEY (`address_object_curr_status`)
    REFERENCES `fiasdb`.`current_status` (`current_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`address_object`
  ADD CONSTRAINT `fk_address_object_center_status`
    FOREIGN KEY (`address_object_center_status`)
    REFERENCES `fiasdb`.`center_status` (`center_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE `fiasdb`.`address_object`
  ADD CONSTRAINT `fk_address_object_actual_status`
    FOREIGN KEY (`address_object_actual_status`)
    REFERENCES `fiasdb`.`actual_statuses` (`actual_statuses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
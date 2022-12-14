-- MySQL Script generated by MySQL Workbench
-- Mon Nov  7 16:14:52 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema analisaitape
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema analisaitape
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `analisaitape` DEFAULT CHARACTER SET utf8 ;
USE `analisaitape` ;

-- -----------------------------------------------------
-- Table `analisaitape`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` TEXT NOT NULL,
  `document_type` VARCHAR(100) NOT NULL DEFAULT 'cpf',
  `document` VARCHAR(100) NOT NULL,
  `birth_date` DATE NOT NULL,
  `profile_pic` LONGBLOB NULL DEFAULT NULL,
  `terms` INT NOT NULL DEFAULT 1 COMMENT '0 - Denied; 1 - Accepted;',
  `token` TEXT NULL DEFAULT NULL,
  `token_email` TEXT NULL DEFAULT NULL,
  `status` INT NOT NULL DEFAULT 1 COMMENT '0 - Inactive; 1 - Active',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`administrators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`administrators` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `password` TEXT NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `partner` INT NOT NULL DEFAULT 0 COMMENT '0 - No; 1 - Yes',
  `status` INT NOT NULL DEFAULT 1 COMMENT '0 - Inactive; 1 - Active',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `action` VARCHAR(100) NULL DEFAULT NULL,
  `icon` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`administrators_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`administrators_permissions` (
  `administrator_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  INDEX `fk_administrators_permissions_administrators_idx` (`administrator_id` ASC),
  INDEX `fk_administrators_permissions_permissions1_idx` (`permission_id` ASC),
  CONSTRAINT `fk_administrators_permissions_administrators`
    FOREIGN KEY (`administrator_id`)
    REFERENCES `analisaitape`.`administrators` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_administrators_permissions_permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `analisaitape`.`permissions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`feedbacks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `title` VARCHAR(100) NULL DEFAULT NULL,
  `feedback` TEXT NOT NULL,
  `reply` TEXT NULL DEFAULT NULL,
  `status` INT NOT NULL DEFAULT 0 COMMENT '0 - In progress; 1 - Answered; 2 - Canceled',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `status` INT NOT NULL DEFAULT 1 COMMENT '0 - In progress; 1 - Answered; 2 - Canceled',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`articles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `partner_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `img` LONGBLOB NULL DEFAULT NULL,
  `text` TEXT NOT NULL,
  `status` INT NOT NULL DEFAULT 1 COMMENT '0 - In progress; 1 - Answered; 2 - Canceled',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_articles_categorys1_idx` (`category_id` ASC),
  INDEX `fk_articles_administrators1_idx` (`partner_id` ASC),
  CONSTRAINT `fk_articles_categorys1`
    FOREIGN KEY (`category_id`)
    REFERENCES `analisaitape`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_administrators1`
    FOREIGN KEY (`partner_id`)
    REFERENCES `analisaitape`.`administrators` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`aldermen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`aldermen` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `party` VARCHAR(100) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `total_propositures` INT NOT NULL,
  `init_mandate` DATE NOT NULL,
  `finish_mandate` DATE NOT NULL,
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`political_purposes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`political_purposes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `alderman_id` INT NULL DEFAULT NULL,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NOT NULL,
  `protocol` VARCHAR(100) NOT NULL,
  `classification` VARCHAR(100) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `status` INT NOT NULL DEFAULT 1 COMMENT '0 - Inactive; 1 - Active',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_political_purpose_alderman1_idx` (`alderman_id` ASC),
  INDEX `fk_political_purpose_categories1_idx` (`category_id` ASC),
  CONSTRAINT `fk_political_purpose_alderman1`
    FOREIGN KEY (`alderman_id`)
    REFERENCES `analisaitape`.`aldermen` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_political_purpose_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `analisaitape`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`commissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`commissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alderman_id` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `office` VARCHAR(100) NOT NULL,
  `init_mandate` DATE NOT NULL,
  `finish_mandate` DATE NOT NULL,
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_commissions_alderman1_idx` (`alderman_id` ASC),
  CONSTRAINT `fk_commissions_alderman1`
    FOREIGN KEY (`alderman_id`)
    REFERENCES `analisaitape`.`aldermen` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`receives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`receives` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `acumulated_credit` DECIMAL(20,2) NOT NULL,
  `acumulated_debit` DECIMAL(20,2) NOT NULL,
  `acumulated_period` DECIMAL(20,2) NOT NULL,
  `acumulated_general` DECIMAL(20,2) NOT NULL,
  `initial_prediction` DECIMAL(20,2) NOT NULL,
  `updated_prediction` DECIMAL(20,2) NOT NULL,
  `collected` DECIMAL(20,2) NOT NULL,
  `reference_year` DATE NOT NULL,
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `analisaitape`.`expenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `analisaitape`.`expenses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `acumulated_committed` DECIMAL(20,2) NOT NULL,
  `acumulated_annulled` DECIMAL(20,2) NOT NULL,
  `acumulated_finished` DECIMAL(20,2) NOT NULL,
  `acumulated_general` DECIMAL(20,2) NOT NULL,
  `acumulated_payied` DECIMAL(20,2) NOT NULL,
  `acumulated_balance` DECIMAL(20,2) NOT NULL,
  `initial_fixed` DECIMAL(20,2) NOT NULL,
  `updated_fixed` DECIMAL(20,2) NOT NULL,
  `executed` DECIMAL(20,2) NOT NULL,
  `reference_year` DATE NOT NULL,
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

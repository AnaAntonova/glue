
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema glue
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `glue` ;

-- -----------------------------------------------------
-- Schema glue
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `glue` DEFAULT CHARACTER SET utf8 ;
USE `glue` ;

-- -----------------------------------------------------
-- Table `Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Address` ;

CREATE TABLE IF NOT EXISTS `Address` (
  `id` BIGINT(12) NOT NULL,
  `Primary` TINYINT NULL,
  `po_box` VARCHAR(45) NULL,
  `Addressline 1` VARCHAR(45) NULL,
  `Addressline 2` VARCHAR(45) NULL,
  `Street_Number` INT NULL,
  `zip_code` VARCHAR(45) NULL,
  `City` BIGINT(12) NULL,
  `Country` BIGINT(12) NULL,
  `Region` BIGINT(12) NULL,
  `Latitude` DECIMAL NULL,
  `Longitude` DECIMAL NULL,
  `Person` BIGINT(12) NULL,
  `Address_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Person_PII`
    FOREIGN KEY (`Person`)
    REFERENCES `Person_PII` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Address_type`
    FOREIGN KEY (`Address_Type`)
    REFERENCES `Address_Type` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Country`
    FOREIGN KEY (`Country`)
    REFERENCES `Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `City`
    FOREIGN KEY (`City`)
    REFERENCES `City` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Region`
    FOREIGN KEY (`Region`)
    REFERENCES `Region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `Address` (`Person` ASC) VISIBLE;

CREATE INDEX `Address_type_idx` ON `Address` (`Address_Type` ASC) VISIBLE;

CREATE INDEX `Country_idx` ON `Address` (`Country` ASC) VISIBLE;

CREATE INDEX `City_idx` ON `Address` (`City` ASC) VISIBLE;

CREATE INDEX `Region_idx` ON `Address` (`Region` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Address_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Address_Type` ;

CREATE TABLE IF NOT EXISTS `Address_Type` (
  `Id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Asset_Classification_Node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Asset_Classification_Node` ;

CREATE TABLE IF NOT EXISTS `Asset_Classification_Node` (
  `id` BIGINT(12) NOT NULL,
  `Node_Name` VARCHAR(45) NULL,
  `Regime` BIGINT(12) NULL,
  `Asset_Classification_Regime_Structurecol` BIGINT(12) NULL,
  `Benchmark` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Regime`
    FOREIGN KEY (`Regime`)
    REFERENCES `Asset_Classification_Regime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NodeBenchmark`
    FOREIGN KEY (`Benchmark`)
    REFERENCES `Benchmark` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Regime_idx` ON `Asset_Classification_Node` (`Regime` ASC) VISIBLE;

CREATE INDEX `Benchmark_idx` ON `Asset_Classification_Node` (`Benchmark` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Asset_Classification_Regime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Asset_Classification_Regime` ;

CREATE TABLE IF NOT EXISTS `Asset_Classification_Regime` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Owner` BIGINT(12) NULL,
  `Depth` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Asset_Classification_Structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Asset_Classification_Structure` ;

CREATE TABLE IF NOT EXISTS `Asset_Classification_Structure` (
  `id` BIGINT(12) NOT NULL,
  `Parent` BIGINT(12) NULL,
  `Child` BIGINT(12) NULL,
  `Level` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ACParent`
    FOREIGN KEY (`Parent`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ACChild`
    FOREIGN KEY (`Child`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Node_idx` ON `Asset_Classification_Structure` (`Parent` ASC) VISIBLE;

CREATE INDEX `Child_idx` ON `Asset_Classification_Structure` (`Child` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BP-Relationship_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BP-Relationship_Type` ;

CREATE TABLE IF NOT EXISTS `BP-Relationship_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` BIGINT(12) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank_Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bank_Employee` ;

CREATE TABLE IF NOT EXISTS `Bank_Employee` (
  `id` BIGINT(12) NOT NULL,
  `Job_Function` BIGINT(12) NULL,
  `Rank` BIGINT(12) NULL,
  `Person` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `BEPerson`
    FOREIGN KEY (`Person`)
    REFERENCES `Person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `Bank_Employee` (`Person` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Benchmark`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Benchmark` ;

CREATE TABLE IF NOT EXISTS `Benchmark` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Is_Composit` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Benchmark_Constituent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Benchmark_Constituent` ;

CREATE TABLE IF NOT EXISTS `Benchmark_Constituent` (
  `id` BIGINT(12) NOT NULL,
  `Instrument` BIGINT(12) NULL,
  `Weight` DECIMAL NULL,
  `Benchmark` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ConstituentBenchmark`
    FOREIGN KEY (`Benchmark`)
    REFERENCES `Benchmark` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Benchmark_idx` ON `Benchmark_Constituent` (`Benchmark` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Book` ;

CREATE TABLE IF NOT EXISTS `Book` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `OE` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `OE`
    FOREIGN KEY (`OE`)
    REFERENCES `Organizational_Entitiy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `OE_idx` ON `Book` (`OE` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Business_Partner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Business_Partner` ;

CREATE TABLE IF NOT EXISTS `Business_Partner` (
  `id` BIGINT(12) NOT NULL,
  `Internal_ID` VARCHAR(45) NULL,
  `Nickname` VARCHAR(45) NULL,
  `Currency` BIGINT(12) NULL,
  `Business_Partner_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `BPType`
    FOREIGN KEY (`Business_Partner_Type`)
    REFERENCES `Business_Partner_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Type_idx` ON `Business_Partner` (`Business_Partner_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Business_Partner_Structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Business_Partner_Structure` ;

CREATE TABLE IF NOT EXISTS `Business_Partner_Structure` (
  `id` BIGINT(12) NOT NULL,
  `Parent` BIGINT(12) NULL,
  `Child` BIGINT(12) NULL,
  `Level` BIGINT(12) NULL,
  `Relationship_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ParentBP`
    FOREIGN KEY (`Parent`)
    REFERENCES `Business_Partner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ChildBP`
    FOREIGN KEY (`Child`)
    REFERENCES `Business_Partner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Relationship_Type`
    FOREIGN KEY (`Relationship_Type`)
    REFERENCES `BP-Relationship_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Parent_idx` ON `Business_Partner_Structure` (`Parent` ASC) VISIBLE;

CREATE INDEX `Child_idx` ON `Business_Partner_Structure` (`Child` ASC) VISIBLE;

CREATE INDEX `Relationship_Type_idx` ON `Business_Partner_Structure` (`Relationship_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Business_Partner_To_Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Business_Partner_To_Person` ;

CREATE TABLE IF NOT EXISTS `Business_Partner_To_Person` (
  `id` BIGINT(12) NOT NULL,
  `Business_Partner` BIGINT(12) NULL,
  `Person` BIGINT(12) NULL,
  `Relationship_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Business_Partner`
    FOREIGN KEY (`Business_Partner`)
    REFERENCES `Business_Partner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BP_P_Relationship_Type`
    FOREIGN KEY (`Relationship_Type`)
    REFERENCES `Business_Partner_To_Person_Relationship_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BP_P_Person`
    FOREIGN KEY (`Person`)
    REFERENCES `Person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Business_Partner_idx` ON `Business_Partner_To_Person` (`Business_Partner` ASC) VISIBLE;

CREATE INDEX `Relationship_Type_idx` ON `Business_Partner_To_Person` (`Relationship_Type` ASC) VISIBLE;

CREATE INDEX `Person_idx` ON `Business_Partner_To_Person` (`Person` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Business_Partner_To_Person_Relationship_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Business_Partner_To_Person_Relationship_Type` ;

CREATE TABLE IF NOT EXISTS `Business_Partner_To_Person_Relationship_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Business_Partner_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Business_Partner_Type` ;

CREATE TABLE IF NOT EXISTS `Business_Partner_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CMA_Set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CMA_Set` ;

CREATE TABLE IF NOT EXISTS `CMA_Set` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Owner` BIGINT(12) NULL,
  `Asset_Classification_Regime` BIGINT(12) NULL,
  `Type` ENUM("Szenario", "CMA") NULL,
  `Description` TINYBLOB NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Asset_Classification_Regime`
    FOREIGN KEY (`Asset_Classification_Regime`)
    REFERENCES `Asset_Classification_Regime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Asset_Classification_Regime_idx` ON `CMA_Set` (`Asset_Classification_Regime` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `CMA_Set_Hierachy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CMA_Set_Hierachy` ;

CREATE TABLE IF NOT EXISTS `CMA_Set_Hierachy` (
  `id` BIGINT(12) NOT NULL,
  `Parent` BIGINT(12) NULL,
  `Child` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Parent`
    FOREIGN KEY (`Parent`)
    REFERENCES `CMA_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Child`
    FOREIGN KEY (`Child`)
    REFERENCES `CMA_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Parent_idx` ON `CMA_Set_Hierachy` (`Parent` ASC) VISIBLE;

CREATE INDEX `Child_idx` ON `CMA_Set_Hierachy` (`Child` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Citizenship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Citizenship` ;

CREATE TABLE IF NOT EXISTS `Citizenship` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Person` BIGINT(12) NULL,
  `Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CitizenshipPerson`
    FOREIGN KEY (`Person`)
    REFERENCES `Person_PII` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CitizenshipType`
    FOREIGN KEY (`Type`)
    REFERENCES `Citizenship_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `Citizenship` (`Person` ASC) VISIBLE;

CREATE INDEX `Type_idx` ON `Citizenship` (`Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Citizenship_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Citizenship_Type` ;

CREATE TABLE IF NOT EXISTS `Citizenship_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `City` ;

CREATE TABLE IF NOT EXISTS `City` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Country` ;

CREATE TABLE IF NOT EXISTS `Country` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Credit_Limit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Credit_Limit` ;

CREATE TABLE IF NOT EXISTS `Credit_Limit` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the credit limit objects',
  `credit_limit_identier_id` BIGINT(12) NULL COMMENT 'ID of credit limit identifier',
  `portfolio_id` BIGINT(12) NULL COMMENT 'ID of the portfolio',
  `granted_limit` DECIMAL(25,9) NULL COMMENT 'Maximum lending limit of the portfolio\n',
  `lending_value` DECIMAL(25,9) NULL COMMENT 'Maximum aggregated lending value of the portfolio\n',
  PRIMARY KEY (`id`),
  CONSTRAINT `portfolio_id`
    FOREIGN KEY (`portfolio_id`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `portfolio_id_idx` ON `Credit_Limit` (`portfolio_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Currency` ;

CREATE TABLE IF NOT EXISTS `Currency` (
  `id` BIGINT(12) NOT NULL AUTO_INCREMENT COMMENT 'Contains the external identifier of currency objects',
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Currency_Identifier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Currency_Identifier` ;

CREATE TABLE IF NOT EXISTS `Currency_Identifier` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the external identifier of credit limits',
  `currency_id` BIGINT(12) NOT NULL,
  `currency_identifier_type_id` BIGINT(12) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Identifier_Currency`
    FOREIGN KEY (`currency_id`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `currency_identifier_type_id`
    FOREIGN KEY (`currency_identifier_type_id`)
    REFERENCES `Currency_Identifier_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `currency_id_idx` ON `Currency_Identifier` (`currency_id` ASC) VISIBLE;

CREATE INDEX `currency_identifier_type_id_idx` ON `Currency_Identifier` (`currency_identifier_type_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Currency_Identifier_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Currency_Identifier_Type` ;

CREATE TABLE IF NOT EXISTS `Currency_Identifier_Type` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the country identifier types',
  `Identifier` VARCHAR(6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Electronic_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Electronic_Address` ;

CREATE TABLE IF NOT EXISTS `Electronic_Address` (
  `id` BIGINT(12) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Type` BIGINT(12) NULL,
  `Name` VARCHAR(45) NULL,
  `Person` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `EA_Person_PII`
    FOREIGN KEY (`Person`)
    REFERENCES `Person_PII` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EAType`
    FOREIGN KEY (`Type`)
    REFERENCES `Electronic_Address_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `Electronic_Address` (`Person` ASC) VISIBLE;

CREATE INDEX `Type_idx` ON `Electronic_Address` (`Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Electronic_Address_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Electronic_Address_Type` ;

CREATE TABLE IF NOT EXISTS `Electronic_Address_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Employee_To_OE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Employee_To_OE` ;

CREATE TABLE IF NOT EXISTS `Employee_To_OE` (
  `id` INT NOT NULL,
  `Relationship_Type` BIGINT(12) NULL,
  `Employee` BIGINT(12) NULL,
  `OE` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Employee_to_OE_OE`
    FOREIGN KEY (`OE`)
    REFERENCES `Organizational_Entitiy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Employee`
    FOREIGN KEY (`Employee`)
    REFERENCES `Bank_Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EmployeetoOEType`
    FOREIGN KEY (`Relationship_Type`)
    REFERENCES `Employee_To_OE_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `OE_idx` ON `Employee_To_OE` (`OE` ASC) VISIBLE;

CREATE INDEX `Employee_idx` ON `Employee_To_OE` (`Employee` ASC) VISIBLE;

CREATE INDEX `Type_idx` ON `Employee_To_OE` (`Relationship_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Employee_To_OE_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Employee_To_OE_Type` ;

CREATE TABLE IF NOT EXISTS `Employee_To_OE_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Fill` ;

CREATE TABLE IF NOT EXISTS `Fill` (
  `id` BIGINT(12) NOT NULL,
  `Date_Time` DATETIME NULL,
  `ExternalID` VARCHAR(45) NULL,
  `SequenceNumber` BIGINT(6) NULL,
  `Quantity` DECIMAL NULL,
  `Price` DECIMAL NULL,
  `Currency` BIGINT(12) NULL,
  `Comission` DECIMAL NULL,
  `Comission_Currency` BIGINT(12) NULL,
  `Fee` DECIMAL NULL,
  `Fee_Currency` BIGINT(12) NULL,
  `Order` BIGINT(12) NULL,
  `Side` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Order`
    FOREIGN KEY (`Order`)
    REFERENCES `Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Comission_Currency`
    FOREIGN KEY (`Comission_Currency`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FillCurrency`
    FOREIGN KEY (`Currency`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fee_Currency`
    FOREIGN KEY (`Fee_Currency`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Order_idx` ON `Fill` (`Order` ASC) VISIBLE;

CREATE INDEX `Comission_Currency_idx` ON `Fill` (`Comission_Currency` ASC) VISIBLE;

CREATE INDEX `Currency_idx` ON `Fill` (`Currency` ASC) VISIBLE;

CREATE INDEX `Fee_Currency_idx` ON `Fill` (`Fee_Currency` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Financial_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Financial_Account` ;

CREATE TABLE IF NOT EXISTS `Financial_Account` (
  `id` BIGINT(12) NOT NULL,
  `Type` BIGINT(12) NULL,
  `Name` VARCHAR(45) NULL,
  `IBAN` VARCHAR(45) NULL,
  `Ex-Custody` TINYINT NULL,
  `Custodian` BIGINT(12) NULL,
  `Portfolio` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Portfolio`
    FOREIGN KEY (`Portfolio`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Type`
    FOREIGN KEY (`Type`)
    REFERENCES `Financial_Account_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Portfolio_idx` ON `Financial_Account` (`Portfolio` ASC) VISIBLE;

CREATE INDEX `Type_idx` ON `Financial_Account` (`Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Financial_Account_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Financial_Account_Type` ;

CREATE TABLE IF NOT EXISTS `Financial_Account_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Instrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument` ;

CREATE TABLE IF NOT EXISTS `Instrument` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `InstrumentType`
    FOREIGN KEY (`Type`)
    REFERENCES `Instrument_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Type_idx` ON `Instrument` (`Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Instrument_Classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument_Classification` ;

CREATE TABLE IF NOT EXISTS `Instrument_Classification` (
  `id` BIGINT(12) NOT NULL,
  `Instrument` BIGINT(12) NULL,
  `Node` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ACNode`
    FOREIGN KEY (`Node`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ACInstrument`
    FOREIGN KEY (`Instrument`)
    REFERENCES `Instrument` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Node_idx` ON `Instrument_Classification` (`Node` ASC) VISIBLE;

CREATE INDEX `Instrument_idx` ON `Instrument_Classification` (`Instrument` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Instrument_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument_Type` ;

CREATE TABLE IF NOT EXISTS `Instrument_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Instrument_Type_Hierachy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument_Type_Hierachy` ;

CREATE TABLE IF NOT EXISTS `Instrument_Type_Hierachy` (
  `id` BIGINT(12) NOT NULL,
  `Parent_Instrument_Type` BIGINT(12) NULL,
  `Child_Instrument_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Instrument_Type_Parent`
    FOREIGN KEY (`Parent_Instrument_Type`)
    REFERENCES `Instrument_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Instrument_Type_Child`
    FOREIGN KEY (`Child_Instrument_Type`)
    REFERENCES `Instrument_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Child_idx` ON `Instrument_Type_Hierachy` (`Child_Instrument_Type` ASC) VISIBLE;

CREATE INDEX `Parent_idx` ON `Instrument_Type_Hierachy` (`Parent_Instrument_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Instrument__Attribute_Definition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument__Attribute_Definition` ;

CREATE TABLE IF NOT EXISTS `Instrument__Attribute_Definition` (
  `id` BIGINT(12) NOT NULL,
  `Attribute_Name` VARCHAR(45) NULL,
  `Attribute_Type` VARCHAR(45) NULL,
  `Instrument_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Instrument_Type`
    FOREIGN KEY (`Instrument_Type`)
    REFERENCES `Instrument_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Instrument_Type_idx` ON `Instrument__Attribute_Definition` (`Instrument_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Instrument__Attribute_Value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instrument__Attribute_Value` ;

CREATE TABLE IF NOT EXISTS `Instrument__Attribute_Value` (
  `id` BIGINT(12) NOT NULL,
  `Value` VARCHAR(45) NULL,
  `Instrument_Attribut` BIGINT(12) NULL,
  `Instrument` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ValueInstrument_Attribute`
    FOREIGN KEY (`Instrument_Attribut`)
    REFERENCES `Instrument__Attribute_Definition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ValueInstrument`
    FOREIGN KEY (`Instrument`)
    REFERENCES `Instrument` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Instrument_Attribute_idx` ON `Instrument__Attribute_Value` (`Instrument_Attribut` ASC) VISIBLE;

CREATE INDEX `Instrument_idx` ON `Instrument__Attribute_Value` (`Instrument` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Investment_Proposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Investment_Proposition` ;

CREATE TABLE IF NOT EXISTS `Investment_Proposition` (
  `id` BIGINT(12) NOT NULL,
  `name` VARCHAR(32) NULL,
  `description` VARCHAR(1024) NULL,
  `presentation_currency_id` BIGINT(12) NULL,
  `real_portfolio_id` BIGINT(12) NOT NULL,
  `source_portfolio_id` BIGINT(12) NOT NULL,
  `simulated_portfolio_id` BIGINT(12) NOT NULL,
  `Created_Date` DATETIME NULL,
  `Accepted_Date` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_investment_proposition_portfolio1`
    FOREIGN KEY (`real_portfolio_id`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_investment_proposition_portfolio2`
    FOREIGN KEY (`source_portfolio_id`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_investment_proposition_portfolio3`
    FOREIGN KEY (`simulated_portfolio_id`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_investment_proposition_portfolio1_idx` ON `Investment_Proposition` (`real_portfolio_id` ASC) VISIBLE;

CREATE INDEX `fk_investment_proposition_portfolio2_idx` ON `Investment_Proposition` (`source_portfolio_id` ASC) VISIBLE;

CREATE INDEX `fk_investment_proposition_portfolio3_idx` ON `Investment_Proposition` (`simulated_portfolio_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Investment_Proposition_Position_Change`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Investment_Proposition_Position_Change` ;

CREATE TABLE IF NOT EXISTS `Investment_Proposition_Position_Change` (
  `id` BIGINT(12) NOT NULL,
  `position_id` BIGINT(12) NULL,
  `instrument_id` BIGINT(12) NULL,
  `market_value` DECIMAL(25,9) NULL,
  `investment_proposition_id` BIGINT(12) NOT NULL,
  `Quantity` DECIMAL NULL,
  `Order` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_investment_proposition_position_change_investment_proposit1`
    FOREIGN KEY (`investment_proposition_id`)
    REFERENCES `Investment_Proposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Position`
    FOREIGN KEY (`position_id`)
    REFERENCES `Position` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PropositionOrder`
    FOREIGN KEY (`Order`)
    REFERENCES `Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PropositionInstrument`
    FOREIGN KEY (`instrument_id`)
    REFERENCES `Instrument` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_investment_proposition_position_change_investment_propos_idx` ON `Investment_Proposition_Position_Change` (`investment_proposition_id` ASC) VISIBLE;

CREATE INDEX `Position_idx` ON `Investment_Proposition_Position_Change` (`position_id` ASC) VISIBLE;

CREATE INDEX `Order_idx` ON `Investment_Proposition_Position_Change` (`Order` ASC) VISIBLE;

CREATE INDEX `Instrument_idx` ON `Investment_Proposition_Position_Change` (`instrument_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Investment_Strategy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Investment_Strategy` ;

CREATE TABLE IF NOT EXISTS `Investment_Strategy` (
  `id` BIGINT(12) NOT NULL,
  `Risk_Profile` BIGINT(12) NULL,
  `Service_Model` BIGINT(12) NULL,
  `Restriction_Set` BIGINT(12) NULL,
  `Benchmark` BIGINT(12) NULL,
  `CMA_Set` BIGINT(12) NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Risk_Profile`
    FOREIGN KEY (`Risk_Profile`)
    REFERENCES `Risk_Profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Restriction_Set`
    FOREIGN KEY (`Restriction_Set`)
    REFERENCES `Restriction_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CMA_Set`
    FOREIGN KEY (`CMA_Set`)
    REFERENCES `CMA_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Benchmark`
    FOREIGN KEY (`Benchmark`)
    REFERENCES `Benchmark` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Risk_Profile_idx` ON `Investment_Strategy` (`Risk_Profile` ASC) VISIBLE;

CREATE INDEX `Restriction_Set_idx` ON `Investment_Strategy` (`Restriction_Set` ASC) VISIBLE;

CREATE INDEX `CMA_Set_idx` ON `Investment_Strategy` (`CMA_Set` ASC) VISIBLE;

CREATE INDEX `Benchmark_idx` ON `Investment_Strategy` (`Benchmark` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Language` ;

CREATE TABLE IF NOT EXISTS `Language` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Legal_Identification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Legal_Identification` ;

CREATE TABLE IF NOT EXISTS `Legal_Identification` (
  `idLegal_Identification` INT NOT NULL,
  `Identification` VARCHAR(45) NULL,
  `Identification_type` BIGINT(12) NULL,
  `Issuer_Country` BIGINT(12) NULL,
  `Issuer_place` BIGINT(12) NULL,
  `Issue_Date` DATE NULL,
  `Expiry_Date` DATE NULL,
  `Person` BIGINT(12) NULL,
  PRIMARY KEY (`idLegal_Identification`),
  CONSTRAINT `LIPerson`
    FOREIGN KEY (`Person`)
    REFERENCES `Person_PII` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `Legal_Identification` (`Person` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Node_CMA_Covarianz`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Node_CMA_Covarianz` ;

CREATE TABLE IF NOT EXISTS `Node_CMA_Covarianz` (
  `id` BIGINT(12) NOT NULL,
  `Node_1` BIGINT(12) NULL,
  `Node_2` BIGINT(12) NULL,
  `Covarianz` DECIMAL NULL,
  `CMA_Set` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Node_1`
    FOREIGN KEY (`Node_1`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Node_2`
    FOREIGN KEY (`Node_2`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RRNodeCMA_Set`
    FOREIGN KEY (`CMA_Set`)
    REFERENCES `CMA_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Node_1_idx` ON `Node_CMA_Covarianz` (`Node_1` ASC) VISIBLE;

CREATE INDEX `Node_2_idx` ON `Node_CMA_Covarianz` (`Node_2` ASC) VISIBLE;

CREATE INDEX `CMA_Set_idx` ON `Node_CMA_Covarianz` (`CMA_Set` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Node_CMA_RR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Node_CMA_RR` ;

CREATE TABLE IF NOT EXISTS `Node_CMA_RR` (
  `id` BIGINT(12) NOT NULL,
  `Node` BIGINT(12) NULL,
  `Risk_Type` BIGINT(12) NULL,
  `Risk_Assumption` DECIMAL NULL,
  `Return_Assumption` DECIMAL NULL,
  `Time_Horizon` DATETIME NULL,
  `CMA_Set` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `RRCMA_Set`
    FOREIGN KEY (`CMA_Set`)
    REFERENCES `CMA_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RRCMANode`
    FOREIGN KEY (`Node`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `CMA_Set_idx` ON `Node_CMA_RR` (`CMA_Set` ASC) VISIBLE;

CREATE INDEX `Node_idx` ON `Node_CMA_RR` (`Node` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `OE_TO_BP_TYPE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OE_TO_BP_TYPE` ;

CREATE TABLE IF NOT EXISTS `OE_TO_BP_TYPE` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OE_To_BP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OE_To_BP` ;

CREATE TABLE IF NOT EXISTS `OE_To_BP` (
  `id` BIGINT(12) NOT NULL,
  `BP` BIGINT(12) NULL,
  `OE` BIGINT(12) NULL,
  `Relationship_Type` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `BP_Relationship`
    FOREIGN KEY (`BP`)
    REFERENCES `Business_Partner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OE_Relationship`
    FOREIGN KEY (`OE`)
    REFERENCES `Organizational_Entitiy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OE_To_BP_Type`
    FOREIGN KEY (`Relationship_Type`)
    REFERENCES `OE_TO_BP_TYPE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `BP_idx` ON `OE_To_BP` (`BP` ASC) VISIBLE;

CREATE INDEX `OE_idx` ON `OE_To_BP` (`OE` ASC) VISIBLE;

CREATE INDEX `Type_idx` ON `OE_To_BP` (`Relationship_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Order` ;

CREATE TABLE IF NOT EXISTS `Order` (
  `id` BIGINT(12) NOT NULL,
  `InternalID` VARCHAR(45) NULL,
  `ExternalID` VARCHAR(45) NULL,
  `Creation_Date` DATE NULL,
  `Completion` BIGINT(12) NULL,
  `Instrument` BIGINT(12) NULL,
  `Status` VARCHAR(45) NULL,
  `Side` VARCHAR(4) NULL,
  `Exchange_Order` TINYINT NULL,
  `Exchange` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Completion`
    FOREIGN KEY (`Completion`)
    REFERENCES `Order_Completion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Completion_idx` ON `Order` (`Completion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Order_Completion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Order_Completion` ;

CREATE TABLE IF NOT EXISTS `Order_Completion` (
  `id` BIGINT(12) NOT NULL,
  `Date` DATETIME NULL,
  `Status` VARCHAR(42) NULL,
  `Filled_Quantity` DECIMAL NULL,
  `Remaining_Quantity` DECIMAL NULL,
  `AvgPrice` DECIMAL NULL,
  `Currency` BIGINT(12) NULL,
  `GrossValue` DECIMAL NULL,
  `NetValue` DECIMAL NULL,
  `TotalCharges` DECIMAL NULL,
  `ChargeCurrency` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Currency`
    FOREIGN KEY (`Currency`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Charge_Currency`
    FOREIGN KEY (`ChargeCurrency`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Currency_idx` ON `Order_Completion` (`Currency` ASC) VISIBLE;

CREATE INDEX `Charge_Currency_idx` ON `Order_Completion` (`ChargeCurrency` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Organization_Structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Organization_Structure` ;

CREATE TABLE IF NOT EXISTS `Organization_Structure` (
  `id` BIGINT(12) NOT NULL,
  `Parent` BIGINT(12) NULL,
  `Child` BIGINT(12) NULL,
  `Level` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ParentOE`
    FOREIGN KEY (`Parent`)
    REFERENCES `Organizational_Entitiy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ChildOE`
    FOREIGN KEY (`Child`)
    REFERENCES `Organizational_Entitiy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Parent_idx` ON `Organization_Structure` (`Parent` ASC) VISIBLE;

CREATE INDEX `Child_idx` ON `Organization_Structure` (`Child` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Organizational_Entitiy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Organizational_Entitiy` ;

CREATE TABLE IF NOT EXISTS `Organizational_Entitiy` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Internal_referenz` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Person` ;

CREATE TABLE IF NOT EXISTS `Person` (
  `id` BIGINT(12) NOT NULL,
  `Person_Type` BIGINT(12) NULL,
  `Nick_Name` VARCHAR(45) NULL,
  `PII` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `PersonType`
    FOREIGN KEY (`Person_Type`)
    REFERENCES `Person_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PII`
    FOREIGN KEY (`PII`)
    REFERENCES `Person_PII` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Type_idx` ON `Person` (`Person_Type` ASC) VISIBLE;

CREATE INDEX `PII_idx` ON `Person` (`PII` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Person_PII`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Person_PII` ;

CREATE TABLE IF NOT EXISTS `Person_PII` (
  `id` BIGINT(12) NOT NULL,
  `Person` BIGINT(12) NULL,
  `First_Name` VARCHAR(45) NULL,
  `Middle_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Birth_Date` DATE NULL,
  `Title` BIGINT(12) NULL,
  `Language` BIGINT(12) NULL,
  `Organization_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Title`
    FOREIGN KEY (`Title`)
    REFERENCES `Title` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Language`
    FOREIGN KEY (`Language`)
    REFERENCES `Language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Title_idx` ON `Person_PII` (`Title` ASC) VISIBLE;

CREATE INDEX `Language_idx` ON `Person_PII` (`Language` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Person_Relation_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Person_Relation_Type` ;

CREATE TABLE IF NOT EXISTS `Person_Relation_Type` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the person relation types',
  `name` VARCHAR(32) NOT NULL COMMENT 'Name of person relation (internal use only - no dictionary)',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Person_Relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Person_Relationship` ;

CREATE TABLE IF NOT EXISTS `Person_Relationship` (
  `id` BIGINT(12) NOT NULL COMMENT 'Maps the person to person relationship',
  `Person` BIGINT(12) NOT NULL COMMENT 'ID of person',
  `Associated_Person` BIGINT(12) NOT NULL COMMENT 'ID of associated person',
  `Relation_Type` BIGINT(12) NOT NULL COMMENT 'ID of relation type',
  PRIMARY KEY (`id`),
  CONSTRAINT `relation_type_id`
    FOREIGN KEY (`Relation_Type`)
    REFERENCES `Person_Relation_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Person`
    FOREIGN KEY (`Person`)
    REFERENCES `Person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Associated_Person`
    FOREIGN KEY (`Associated_Person`)
    REFERENCES `Person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `relation_type_id_idx` ON `Person_Relationship` (`Relation_Type` ASC) VISIBLE;

CREATE INDEX `Person_idx` ON `Person_Relationship` (`Person` ASC) VISIBLE;

CREATE INDEX `Associated_Person_idx` ON `Person_Relationship` (`Associated_Person` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Person_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Person_Type` ;

CREATE TABLE IF NOT EXISTS `Person_Type` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Portfolio` ;

CREATE TABLE IF NOT EXISTS `Portfolio` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the portfolio objects',
  `business_partner_id` BIGINT(12) NOT NULL COMMENT 'ID of business partner',
  `reference_currency_id` BIGINT(12) NOT NULL COMMENT 'ID of portfolio reference currency',
  `type_id` BIGINT(12) NOT NULL,
  `Investment_Strategy` BIGINT(12) NULL,
  `virtual` TINYINT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `is_group` TINYINT NULL,
  `Book` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `reference_currency_id`
    FOREIGN KEY (`reference_currency_id`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `type_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `Portfolio_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Strategy`
    FOREIGN KEY (`Investment_Strategy`)
    REFERENCES `Investment_Strategy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Book`
    FOREIGN KEY (`Book`)
    REFERENCES `Book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `reference_currency_id_idx` ON `Portfolio` (`reference_currency_id` ASC) VISIBLE;

CREATE INDEX `type_id_idx` ON `Portfolio` (`type_id` ASC) VISIBLE;

CREATE INDEX `Strategy_idx` ON `Portfolio` (`Investment_Strategy` ASC) VISIBLE;

CREATE INDEX `Book_idx` ON `Portfolio` (`Book` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Portfolio_Structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Portfolio_Structure` ;

CREATE TABLE IF NOT EXISTS `Portfolio_Structure` (
  `id` BIGINT(12) NOT NULL,
  `Parent` BIGINT(12) NULL,
  `Child` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ParentPortfolio`
    FOREIGN KEY (`Parent`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ChildPortfolio`
    FOREIGN KEY (`Child`)
    REFERENCES `Portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Parent_idx` ON `Portfolio_Structure` (`Parent` ASC) VISIBLE;

CREATE INDEX `Child_idx` ON `Portfolio_Structure` (`Child` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Portfolio_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Portfolio_Type` ;

CREATE TABLE IF NOT EXISTS `Portfolio_Type` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the financial account type (internal use only- no dictionary)',
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Position` ;

CREATE TABLE IF NOT EXISTS `Position` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the portfolio position objects',
  `financial_account_id` BIGINT(12) NOT NULL,
  `instrument_id` BIGINT(12) NOT NULL COMMENT 'ID of the instrument',
  `original_id` BIGINT(12) NULL COMMENT 'orginal ID is used by source and simulated position in order to have the link to the ID of real position',
  `quantity` DECIMAL(25,9) NOT NULL COMMENT 'Quantity / units of the position',
  `market_value` DECIMAL(25,9) NOT NULL COMMENT 'market_value of the position in currency',
  `accruals` DECIMAL(25,9) NOT NULL COMMENT 'Accruals of the position',
  `cost_price` DECIMAL(25,9) NOT NULL,
  `currency_id` BIGINT(12) NOT NULL COMMENT 'ID of the position reference currency',
  `create_datetime` DATETIME(3) NOT NULL COMMENT 'Date when the position was created',
  `market_value_percentage_modifiable` TINYINT NOT NULL COMMENT 'Flag whether the market value percentage is modifiable',
  PRIMARY KEY (`id`),
  CONSTRAINT `currency_id`
    FOREIGN KEY (`currency_id`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_position_financial_account1`
    FOREIGN KEY (`financial_account_id`)
    REFERENCES `Financial_Account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Instrument`
    FOREIGN KEY (`instrument_id`)
    REFERENCES `Instrument` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `currency_id_idx` ON `Position` (`currency_id` ASC) VISIBLE;

CREATE INDEX `fk_position_financial_account1_idx` ON `Position` (`financial_account_id` ASC) VISIBLE;

CREATE INDEX `Instrument_idx` ON `Position` (`instrument_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Region` ;

CREATE TABLE IF NOT EXISTS `Region` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restriction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction` ;

CREATE TABLE IF NOT EXISTS `Restriction` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Owner` BIGINT(12) NULL,
  `Pre_Deal_Check` TINYINT NULL,
  `Batch_Check` TINYINT NULL,
  `Overridable` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restriction_Definition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction_Definition` ;

CREATE TABLE IF NOT EXISTS `Restriction_Definition` (
  `id` BIGINT(12) NOT NULL,
  `Restriction_Type` BIGINT(12) NULL,
  `Operator` ENUM("=", ">", "<", ">=", "<=", "<>") NULL,
  `Value` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `RestrictionType`
    FOREIGN KEY (`Restriction_Type`)
    REFERENCES `Restriction_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_idx` ON `Restriction_Definition` (`Restriction_Type` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Restriction_Set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction_Set` ;

CREATE TABLE IF NOT EXISTS `Restriction_Set` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Owner` BIGINT(12) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restriction_Set_Hierachy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction_Set_Hierachy` ;

CREATE TABLE IF NOT EXISTS `Restriction_Set_Hierachy` (
  `id` BIGINT(12) NOT NULL,
  `Child` BIGINT(12) NULL,
  `Parent` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `RestrictionSetParent`
    FOREIGN KEY (`Parent`)
    REFERENCES `Restriction_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RestrictionSetChild`
    FOREIGN KEY (`Child`)
    REFERENCES `Restriction_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Child_idx` ON `Restriction_Set_Hierachy` (`Child` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Restriction_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction_Type` ;

CREATE TABLE IF NOT EXISTS `Restriction_Type` (
  `id` BIGINT(12) NOT NULL,
  `Restriction` BIGINT(12) NULL,
  `Instrument_Attribute` BIGINT(12) NULL,
  `Node` BIGINT(12) NULL,
  `Summable` TINYINT NULL,
  `Type` ENUM("Node", "Attribute") NULL,
  `Restriction_Typecol` VARCHAR(45) NULL,
  `Instrument_Field` VARCHAR(45) NULL,
  `Link_Type` VARCHAR(3) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id`
    FOREIGN KEY (`Restriction`)
    REFERENCES `Restriction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Instrument_Attribute`
    FOREIGN KEY (`Instrument_Attribute`)
    REFERENCES `Instrument__Attribute_Definition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Node`
    FOREIGN KEY (`Node`)
    REFERENCES `Asset_Classification_Node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_idx` ON `Restriction_Type` (`Restriction` ASC) VISIBLE;

CREATE INDEX `Instrument_Attribute_idx` ON `Restriction_Type` (`Instrument_Attribute` ASC) VISIBLE;

CREATE INDEX `Node_idx` ON `Restriction_Type` (`Node` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Restriction_to_Set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Restriction_to_Set` ;

CREATE TABLE IF NOT EXISTS `Restriction_to_Set` (
  `id` BIGINT(12) NOT NULL,
  `Resriction_Set` BIGINT(12) NULL,
  `Restriction` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `RestrictionSet`
    FOREIGN KEY (`Resriction_Set`)
    REFERENCES `Restriction_Set` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Restriction`
    FOREIGN KEY (`Restriction`)
    REFERENCES `Restriction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Restriction_Set_idx` ON `Restriction_to_Set` (`Resriction_Set` ASC) VISIBLE;

CREATE INDEX `Restriction_idx` ON `Restriction_to_Set` (`Restriction` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Risk_Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Risk_Profile` ;

CREATE TABLE IF NOT EXISTS `Risk_Profile` (
  `id` BIGINT(12) NOT NULL,
  `Risk_Type` BIGINT(12) NULL,
  `Risk_Value` DECIMAL(25,9) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Role` ;

CREATE TABLE IF NOT EXISTS `Role` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Title` ;

CREATE TABLE IF NOT EXISTS `Title` (
  `id` BIGINT(12) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transaction_Meta_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Transaction_Meta_Type` ;

CREATE TABLE IF NOT EXISTS `Transaction_Meta_Type` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains transaction meta types',
  `name` BIGINT(12) NOT NULL COMMENT 'Name of the transaction meta type (internal use only - no dictionary needed)',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transaction_Relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Transaction_Relation` ;

CREATE TABLE IF NOT EXISTS `Transaction_Relation` (
  `id` BIGINT(12) NOT NULL,
  `Source` BIGINT(12) NULL,
  `Associated` BIGINT(12) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Source`
    FOREIGN KEY (`Source`)
    REFERENCES `Transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Associated`
    FOREIGN KEY (`Associated`)
    REFERENCES `Transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Source_idx` ON `Transaction_Relation` (`Source` ASC) VISIBLE;

CREATE INDEX `Associated_idx` ON `Transaction_Relation` (`Associated` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Transaction_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Transaction_Type` ;

CREATE TABLE IF NOT EXISTS `Transaction_Type` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains transaction types',
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Transactions` ;

CREATE TABLE IF NOT EXISTS `Transactions` (
  `id` BIGINT(12) NOT NULL COMMENT 'Contains the transactions',
  `position_id` BIGINT(12) NOT NULL COMMENT 'ID of the position',
  `verification_date` DATETIME NULL COMMENT 'Verification Date (Completion date of the entire trade verification process incl. confirmation, affirmation and allocation)\n',
  `Transaction_Date` DATETIME NOT NULL COMMENT 'Trade Date (Execution date of the trade, relevant for tax rules and holding periods)\n',
  `performance_date` DATETIME NULL COMMENT 'Performance Date (date from which performance should be calculated - custodians are mostly settlement oriented while most performance reporting systems are trade date oriented)\n',
  `settlement_date` DATETIME NULL COMMENT 'Settlement Date (relevant for brokers re funding of trades and to determine legal ownership)\n',
  `transaction_type_id` BIGINT(12) NOT NULL COMMENT 'ID of the transaction type\n',
  `transaction_meta_type_id` BIGINT(12) NULL COMMENT 'ID of the meta type\n',
  `quantity` DECIMAL(25,9) NOT NULL COMMENT 'quantity traded\n',
  `cost_price` DECIMAL(25,9) NOT NULL COMMENT 'Average execution price for transaction',
  `cost_price_currency_id` BIGINT(12) NOT NULL COMMENT 'ID of the cost price currency',
  `transaction_value` DECIMAL(25,9) NULL COMMENT 'Transaction value in trade currency\n',
  `transaction_value_currency_id` BIGINT(12) NULL COMMENT 'Currency ID of Transaction value \n',
  `internal_book_text` VARCHAR(45) NULL COMMENT 'Internal booking text\n',
  `external_book_text` VARCHAR(45) NULL COMMENT 'External booking text\n',
  `Fill` BIGINT(12) NULL,
  `ExternalID` VARCHAR(45) NULL,
  `InternalID` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `position_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `Position` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cost_price_currency_id`
    FOREIGN KEY (`cost_price_currency_id`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transaction_type_id`
    FOREIGN KEY (`transaction_type_id`)
    REFERENCES `Transaction_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transaction_meta_type_id`
    FOREIGN KEY (`transaction_meta_type_id`)
    REFERENCES `Transaction_Meta_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transaction_value_currency_id`
    FOREIGN KEY (`transaction_value_currency_id`)
    REFERENCES `Currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fill`
    FOREIGN KEY (`Fill`)
    REFERENCES `Fill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `position_id_idx` ON `Transactions` (`position_id` ASC) VISIBLE;

CREATE INDEX `cost_price_currency_id_idx` ON `Transactions` (`cost_price_currency_id` ASC) VISIBLE;

CREATE INDEX `transaction_type_id_idx` ON `Transactions` (`transaction_type_id` ASC) VISIBLE;

CREATE INDEX `transaction_meta_type_id_idx` ON `Transactions` (`transaction_meta_type_id` ASC) VISIBLE;

CREATE INDEX `transaction_value_currency_id_idx` ON `Transactions` (`transaction_value_currency_id` ASC) VISIBLE;

CREATE INDEX `Fill_idx` ON `Transactions` (`Fill` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `id` BIGINT(12) NOT NULL,
  `Person` BIGINT(12) NOT NULL,
  `username` VARCHAR(32) NOT NULL,
  `hash` VARCHAR(254) NOT NULL,
  `account_non_expired` TINYINT(1) NOT NULL,
  `account_non_locked` TINYINT(1) NOT NULL,
  `credentials_non_expired` TINYINT(1) NOT NULL,
  `enabled` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `UserPerson`
    FOREIGN KEY (`Person`)
    REFERENCES `Person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Person_idx` ON `User` (`Person` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `User_To_Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User_To_Role` ;

CREATE TABLE IF NOT EXISTS `User_To_Role` (
  `id` BIGINT(12) NOT NULL,
  `user_id` BIGINT(12) NOT NULL,
  `role_id` BIGINT(12) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Role`
    FOREIGN KEY (`role_id`)
    REFERENCES `Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `user_id_idx` ON `User_To_Role` (`user_id` ASC) INVISIBLE;

CREATE INDEX `Role_idx` ON `User_To_Role` (`role_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Wave_Entitiy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Wave_Entitiy` ;

CREATE TABLE IF NOT EXISTS `Wave_Entitiy` (
  `UUID` VARCHAR(12) NOT NULL,
  `Creator` BIGINT(12) NULL,
  `Owner` BIGINT(12) NULL,
  `Created_Date` DATETIME NULL,
  `Object_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`UUID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

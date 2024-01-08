-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `LittleLemon` ;

-- -----------------------------------------------------
-- Table `LittleLemon`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`customer` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`customer` (
  `customerID` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(12) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Employees` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Role` VARCHAR(100) NULL DEFAULT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `Contact_Number` INT NULL DEFAULT NULL,
  `Email` VARCHAR(255) NULL DEFAULT NULL,
  `Annual_Salary` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `EmployeeID` INT NOT NULL,
  `date` DATE NOT NULL DEFAULT '2024-01-01',
  `customerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `bookToCust_idx` (`customerID` ASC) VISIBLE,
  INDEX `bookToEmp_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `bookToCust`
    FOREIGN KEY (`customerID`)
    REFERENCES `LittleLemon`.`customer` (`customerID`),
  CONSTRAINT `bookToEmp`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemon`.`Employees` (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LittleLemon`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`MenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`MenuItems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL DEFAULT NULL,
  `Type` VARCHAR(100) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Menus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Menus` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Menus` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL DEFAULT NULL,
  `type` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`, `ItemID`),
  INDEX `menuToItem_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `menuToItem`
    FOREIGN KEY (`ItemID`)
    REFERENCES `LittleLemon`.`MenuItems` (`ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Orders` (
  `OrderID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `date` DATE NOT NULL DEFAULT '2024-01-01',
  PRIMARY KEY (`OrderID`, `TableNo`),
  INDEX `ordToMenu_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `ordToMenu`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon`.`Menus` (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `LittleLemon` ;

-- -----------------------------------------------------
-- procedure BasicSalesReport
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`BasicSalesReport`;

DELIMITER $$
USE `LittleLemon`$$
CREATE DEFINER=`liam`@`localhost` PROCEDURE `BasicSalesReport`()
begin
select sum(billamount), avg(billamount), min(billamount), max(billamount)
from orders;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GuestStatus
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`GuestStatus`;

DELIMITER $$
USE `LittleLemon`$$
CREATE DEFINER=`liam`@`localhost` PROCEDURE `GuestStatus`()
begin
select concat(guestfirstname, " ", guestlastname) as Guest,
case 
    when e.role in ('Manager', 'Assistant Manager') then 'Ready to pay'
    when e.role = 'Head Chef' then 'Ready to serve'
    when e.role = 'Assistant Chef' then 'Preparing Order'
    when e.role = 'Head Waiter' then 'Order served'
    end as "Status"
from bookings as b join employees as e
on e.employeeid = b.employeeid;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PeakHours
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`PeakHours`;

DELIMITER $$
USE `LittleLemon`$$
CREATE DEFINER=`liam`@`localhost` PROCEDURE `PeakHours`()
begin
select hour(bookingslot) as Timeslot, count(bookingid) as bookings
from bookings
group by hour(bookingslot)
order by bookings desc;
end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
MySQL Data Transfer
Source Host: localhost
Source Database: ddd_assignment
Target Host: localhost
Target Database: ddd_assignment
Date: 7/29/2017 11:02:53 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for appointments_info
-- ----------------------------
DROP TABLE IF EXISTS `appointments_info`;
CREATE TABLE `appointments_info` (
  `Appointment_Id` int(15) NOT NULL DEFAULT '0',
  `Appointment_Cost` double(10,0) DEFAULT NULL,
  `Appointment_Date` date DEFAULT NULL,
  `Appointment_Time` varchar(255) DEFAULT NULL,
  `Vehicle_Id` varchar(10) DEFAULT NULL,
  `Mechanic_Id` int(10) DEFAULT NULL,
  PRIMARY KEY (`Appointment_Id`),
  KEY `Appointment_Id` (`Appointment_Id`),
  KEY `Mechanic_Id` (`Mechanic_Id`),
  KEY `Vehicle_Id` (`Vehicle_Id`),
  CONSTRAINT `appointments_info_ibfk_1` FOREIGN KEY (`Mechanic_Id`) REFERENCES `mechanics_info` (`Mechanic_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_info_ibfk_2` FOREIGN KEY (`Vehicle_Id`) REFERENCES `vehicles_info` (`Vehicle_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for car_model_info
-- ----------------------------
DROP TABLE IF EXISTS `car_model_info`;
CREATE TABLE `car_model_info` (
  `Car_Model_Id` int(10) NOT NULL DEFAULT '0',
  `Car_Model_Name` varchar(20) DEFAULT NULL,
  `Maker_Id` int(10) DEFAULT NULL,
  PRIMARY KEY (`Car_Model_Id`),
  KEY `Car_Model_Name` (`Car_Model_Name`),
  KEY `Maker_Id` (`Maker_Id`),
  KEY `Car_Model_Name_2` (`Car_Model_Name`,`Car_Model_Id`),
  CONSTRAINT `car_model_info_ibfk_1` FOREIGN KEY (`Maker_Id`) REFERENCES `makers_info` (`Maker_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for dealers_info
-- ----------------------------
DROP TABLE IF EXISTS `dealers_info`;
CREATE TABLE `dealers_info` (
  `Dealer_Id` int(10) NOT NULL DEFAULT '0',
  `Dealer_Name` varchar(50) DEFAULT NULL,
  `Maker_Id` int(10) DEFAULT NULL,
  PRIMARY KEY (`Dealer_Id`),
  KEY `Maker_Id` (`Maker_Id`),
  CONSTRAINT `dealers_info_ibfk_1` FOREIGN KEY (`Maker_Id`) REFERENCES `makers_info` (`Maker_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for makers_info
-- ----------------------------
DROP TABLE IF EXISTS `makers_info`;
CREATE TABLE `makers_info` (
  `Maker_Id` int(10) NOT NULL DEFAULT '0',
  `Maker_Name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Maker_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for mechanics_info
-- ----------------------------
DROP TABLE IF EXISTS `mechanics_info`;
CREATE TABLE `mechanics_info` (
  `Mechanic_Id` int(10) NOT NULL DEFAULT '0',
  `Mechanic_Name` varchar(25) DEFAULT NULL,
  `Monthly_Salary` float DEFAULT NULL,
  PRIMARY KEY (`Mechanic_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for owner_info
-- ----------------------------
DROP TABLE IF EXISTS `owner_info`;
CREATE TABLE `owner_info` (
  `Owner_Number` varchar(15) NOT NULL DEFAULT '',
  `Owner_Name` varchar(60) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Owner_Telephone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Owner_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for parts_info
-- ----------------------------
DROP TABLE IF EXISTS `parts_info`;
CREATE TABLE `parts_info` (
  `Parts_Number` int(10) NOT NULL DEFAULT '0',
  `Parts_Name` varchar(100) DEFAULT NULL,
  `Parts_Type_Id` int(10) DEFAULT NULL,
  `Part_Quantity` int(2) DEFAULT NULL,
  PRIMARY KEY (`Parts_Number`),
  KEY `Parts_Type_Id` (`Parts_Type_Id`),
  CONSTRAINT `parts_info_ibfk_1` FOREIGN KEY (`Parts_Type_Id`) REFERENCES `parts_type_info` (`Parts_Type_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for parts_type_info
-- ----------------------------
DROP TABLE IF EXISTS `parts_type_info`;
CREATE TABLE `parts_type_info` (
  `Parts_Type_Id` int(10) NOT NULL DEFAULT '0',
  `Parts_Type_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Parts_Type_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for referral_info
-- ----------------------------
DROP TABLE IF EXISTS `referral_info`;
CREATE TABLE `referral_info` (
  `Referral_Id` int(10) NOT NULL DEFAULT '0',
  `Appointment_Id` int(15) DEFAULT NULL,
  `Referral_Date` date DEFAULT NULL,
  `Dealer_Id` int(10) DEFAULT NULL,
  PRIMARY KEY (`Referral_Id`),
  KEY `Appointment_Id` (`Appointment_Id`),
  KEY `D3` (`Dealer_Id`),
  CONSTRAINT `D3` FOREIGN KEY (`Dealer_Id`) REFERENCES `dealers_info` (`Dealer_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referral_info_ibfk_1` FOREIGN KEY (`Appointment_Id`) REFERENCES `appointments_info` (`Appointment_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for referral_parts_type
-- ----------------------------
DROP TABLE IF EXISTS `referral_parts_type`;
CREATE TABLE `referral_parts_type` (
  `Referral_Parts_Type_Id` varchar(15) NOT NULL DEFAULT '0',
  `Referral_Id` int(10) DEFAULT NULL,
  `Parts_Type_Id` int(10) DEFAULT NULL,
  PRIMARY KEY (`Referral_Parts_Type_Id`),
  KEY `Parts_Type_Id` (`Parts_Type_Id`),
  KEY `Referral_Id` (`Referral_Id`),
  CONSTRAINT `referral_parts_type_ibfk_1` FOREIGN KEY (`Parts_Type_Id`) REFERENCES `parts_type_info` (`Parts_Type_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referral_parts_type_ibfk_2` FOREIGN KEY (`Referral_Id`) REFERENCES `referral_info` (`Referral_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for repair_parts
-- ----------------------------
DROP TABLE IF EXISTS `repair_parts`;
CREATE TABLE `repair_parts` (
  `Repair_Parts_Id` varchar(10) NOT NULL DEFAULT '0',
  `Repair_Id` int(10) DEFAULT NULL,
  `Parts_Number` int(10) DEFAULT NULL,
  PRIMARY KEY (`Repair_Parts_Id`),
  KEY `Parts_Number` (`Parts_Number`),
  KEY `Repair_Id` (`Repair_Id`),
  CONSTRAINT `repair_parts_ibfk_1` FOREIGN KEY (`Parts_Number`) REFERENCES `parts_info` (`Parts_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `repair_parts_ibfk_2` FOREIGN KEY (`Repair_Id`) REFERENCES `repairs_info` (`Repair_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for repairs_info
-- ----------------------------
DROP TABLE IF EXISTS `repairs_info`;
CREATE TABLE `repairs_info` (
  `Repair_Id` int(10) NOT NULL DEFAULT '0',
  `Appointment_id` int(15) DEFAULT NULL,
  `Problems_Repair` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Repair_Id`),
  KEY `Repair_Id` (`Repair_Id`),
  KEY `Appointment_id` (`Appointment_id`),
  CONSTRAINT `repairs_info_ibfk_1` FOREIGN KEY (`Appointment_id`) REFERENCES `appointments_info` (`Appointment_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for vehicles_info
-- ----------------------------
DROP TABLE IF EXISTS `vehicles_info`;
CREATE TABLE `vehicles_info` (
  `Vehicle_Id` varchar(10) NOT NULL DEFAULT '',
  `Owner_Number` varchar(15) DEFAULT NULL,
  `Car_Model_Name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`Vehicle_Id`),
  KEY `Owner_Number` (`Owner_Number`),
  KEY `Car_Model_Name` (`Car_Model_Name`),
  CONSTRAINT `vehicles_info_ibfk_1` FOREIGN KEY (`Owner_Number`) REFERENCES `owner_info` (`Owner_Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicles_info_ibfk_2` FOREIGN KEY (`Car_Model_Name`) REFERENCES `car_model_info` (`Car_Model_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `appointments_info` VALUES ('11', '60', '2017-01-01', '2.00PM', 'LS10 TYU', '361');
INSERT INTO `appointments_info` VALUES ('12', '60', '2017-01-02', '2.00PM', 'PR23 TEE', '361');
INSERT INTO `appointments_info` VALUES ('13', '60', '2017-01-02', '3.00PM', 'PR78 WER', '362');
INSERT INTO `appointments_info` VALUES ('14', '60', '2017-01-15', '10.00AM', 'LS10 TYU', '362');
INSERT INTO `appointments_info` VALUES ('15', '60', '2017-01-15', '2.00PM', 'RL33 900', '363');
INSERT INTO `appointments_info` VALUES ('16', '60', '2017-01-18', '3.00PM', '5AT PAL', '361');
INSERT INTO `appointments_info` VALUES ('17', '60', '2017-02-01', '3.00PM', 'LS10 TYU', '362');
INSERT INTO `appointments_info` VALUES ('18', '60', '2017-02-15', '3.00PM', 'DR3 AVE', '362');
INSERT INTO `appointments_info` VALUES ('19', '60', '2017-02-16', '10.00AM', '5AT PAL', '363');
INSERT INTO `appointments_info` VALUES ('20', '60', '2017-01-01', '2.00PM', 'PR78 WER', '362');
INSERT INTO `appointments_info` VALUES ('21', '60', '2017-01-01', '2.00PM', 'RL33 900', '363');
INSERT INTO `car_model_info` VALUES ('631', 'Chevy Sonic', '3425');
INSERT INTO `car_model_info` VALUES ('632', 'Honda Fit', '3426');
INSERT INTO `car_model_info` VALUES ('633', 'Chevy Malibu', '3427');
INSERT INTO `car_model_info` VALUES ('634', 'Ford Focus', '3426');
INSERT INTO `car_model_info` VALUES ('635', 'Chevy Cruze', '3425');
INSERT INTO `car_model_info` VALUES ('636', 'Honda Accord', '3427');
INSERT INTO `dealers_info` VALUES ('221', 'Middlesex Ford', '3425');
INSERT INTO `dealers_info` VALUES ('222', 'Leytonstone Chevy Dealership', '3426');
INSERT INTO `dealers_info` VALUES ('223', 'Wood Street Honda', '3427');
INSERT INTO `makers_info` VALUES ('3425', 'Ford');
INSERT INTO `makers_info` VALUES ('3426', 'Chevy');
INSERT INTO `makers_info` VALUES ('3427', 'Honda');
INSERT INTO `mechanics_info` VALUES ('361', 'Stephanie Thomas', '1000');
INSERT INTO `mechanics_info` VALUES ('362', 'Carol Shields', '1000');
INSERT INTO `mechanics_info` VALUES ('363', 'Sally Perkins', '1000');
INSERT INTO `owner_info` VALUES ('1985-123', 'Sandra Flanders', '27 Wolfe Road, Greenwich, London, SE10 9HE', '0207 544 9800 ');
INSERT INTO `owner_info` VALUES ('1986-108', 'Colin Wilson', '55 Peckham Hill Street, Peckham, London, SE15THR', '0207 506 9823');
INSERT INTO `owner_info` VALUES ('1986-333', 'Anna Wells', '109 Flaggstaff Avenue, Nunhead, SE15 TRR', '020 888 1234');
INSERT INTO `owner_info` VALUES ('1999-001', 'Patrick Fitzgerald', '33 Lark Street, Bermondsey, SE16 8TU', '020 506 1342');
INSERT INTO `parts_info` VALUES ('360', 'Starter Motor S456', '41', '1');
INSERT INTO `parts_info` VALUES ('361', 'Air filters A344', '42', '1');
INSERT INTO `parts_info` VALUES ('362', 'Fan blades B456 x 5', '43', '5');
INSERT INTO `parts_type_info` VALUES ('41', 'Start Motor');
INSERT INTO `parts_type_info` VALUES ('42', 'Filter');
INSERT INTO `parts_type_info` VALUES ('43', 'Fan Blades');
INSERT INTO `referral_info` VALUES ('301', '11', '2017-02-01', '222');
INSERT INTO `referral_info` VALUES ('302', '13', '2017-02-01', '223');
INSERT INTO `referral_info` VALUES ('303', '18', '2017-02-18', '221');
INSERT INTO `referral_parts_type` VALUES ('PT 382 TT', '302', '42');
INSERT INTO `referral_parts_type` VALUES ('RP 480 TE', '301', '41');
INSERT INTO `referral_parts_type` VALUES ('RT 23TI', '303', '43');
INSERT INTO `repair_parts` VALUES ('PR 23T', '112', '361');
INSERT INTO `repair_parts` VALUES ('RP 32S', '110', '360');
INSERT INTO `repair_parts` VALUES ('TR 33S', '111', '362');
INSERT INTO `repairs_info` VALUES ('110', '11', 'Starter motor not functioning');
INSERT INTO `repairs_info` VALUES ('111', '11', 'Air-conditioning not functioning');
INSERT INTO `repairs_info` VALUES ('112', '11', 'Air-bag not functioning');
INSERT INTO `vehicles_info` VALUES ('5AT PAL', '1986-333', 'Ford Focus');
INSERT INTO `vehicles_info` VALUES ('DR3 AVE', '1999-001', 'Chevy Cruze');
INSERT INTO `vehicles_info` VALUES ('LS10 ADL', '1986-108', 'Chevy Cruze');
INSERT INTO `vehicles_info` VALUES ('LS10 TYU', '1985-123', 'Chevy Sonic');
INSERT INTO `vehicles_info` VALUES ('LS90 URZ', '1986-108', 'Honda Fit');
INSERT INTO `vehicles_info` VALUES ('PR23 TEE', '1986-108', 'Honda Fit');
INSERT INTO `vehicles_info` VALUES ('PR78 WER', '1986-333', 'Ford Focus');
INSERT INTO `vehicles_info` VALUES ('R60 HPP', '1999-001', 'Honda Accord');
INSERT INTO `vehicles_info` VALUES ('RL33 900', '1986-108', 'Chevy Cruze');
INSERT INTO `vehicles_info` VALUES ('RS60 APP', '1985-123', 'Chevy Malibu');

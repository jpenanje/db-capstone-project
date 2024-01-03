-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingID` int NOT NULL,
  `TableNumber` int NOT NULL,
  `BookingSlot` time NOT NULL,
  `Staff_StaffID` int NOT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_Bookings_Staff1_idx` (`Staff_StaffID`),
  CONSTRAINT `fk_Bookings_Staff1` FOREIGN KEY (`Staff_StaffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL,
  `CustomerFirstName` varchar(45) NOT NULL,
  `CustomerLastName` varchar(45) NOT NULL,
  `PhoneNumber` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `PhoneNumber_UNIQUE` (`PhoneNumber`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `MenuID` int NOT NULL,
  `MenuName` varchar(45) NOT NULL,
  `Cuisine` varchar(100) NOT NULL,
  `ItemID` int NOT NULL,
  PRIMARY KEY (`MenuID`),
  KEY `fk_menuitems_idx` (`ItemID`),
  CONSTRAINT `fk_menuitems` FOREIGN KEY (`ItemID`) REFERENCES `menuitems` (`ItemID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `ItemID` int NOT NULL,
  `CourseName` varchar(45) NOT NULL,
  `StarterName` varchar(45) NOT NULL,
  `DesertName` decimal(45,0) NOT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdeliverystatus`
--

DROP TABLE IF EXISTS `orderdeliverystatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdeliverystatus` (
  `OrderDeliveryStatusID` int NOT NULL,
  `DeliveryDate` date NOT NULL,
  `Status` varchar(45) NOT NULL,
  `Orders_OrderID` int NOT NULL,
  PRIMARY KEY (`OrderDeliveryStatusID`),
  KEY `fk_OrderDeliveryStatus_Orders1_idx` (`Orders_OrderID`),
  CONSTRAINT `fk_OrderDeliveryStatus_Orders1` FOREIGN KEY (`Orders_OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdeliverystatus`
--

LOCK TABLES `orderdeliverystatus` WRITE;
/*!40000 ALTER TABLE `orderdeliverystatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdeliverystatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL,
  `TableNo` int NOT NULL,
  `Quantity` int NOT NULL,
  `TotalCost` decimal(10,0) NOT NULL,
  `Menu_MenuID` int NOT NULL,
  `Customer_CustomerID` int NOT NULL,
  `Bookings_BookingID` int NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `fk_Orders_Menu1_idx` (`Menu_MenuID`),
  KEY `fk_Orders_Customer1_idx` (`Customer_CustomerID`),
  KEY `fk_Orders_Bookings1_idx` (`Bookings_BookingID`),
  CONSTRAINT `fk_Orders_Bookings1` FOREIGN KEY (`Bookings_BookingID`) REFERENCES `bookings` (`BookingID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Customer1` FOREIGN KEY (`Customer_CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Orders_Menu1` FOREIGN KEY (`Menu_MenuID`) REFERENCES `menu` (`MenuID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` int NOT NULL,
  `StaffName` varchar(45) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `PhoneNumber` int NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Salary` varchar(45) NOT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `PhoneNumber_UNIQUE` (`PhoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-03  9:20:44

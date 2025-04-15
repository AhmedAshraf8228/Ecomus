CREATE DATABASE  IF NOT EXISTS `mindmaze` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mindmaze`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mindmaze
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`userId`,`productId`),
  KEY `cart-productId_idx` (`productId`),
  CONSTRAINT `cart-productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `cart-userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (22,1,2),(22,5,1),(22,8,3),(24,2,4),(24,7,2),(26,4,1),(26,9,2),(29,6,1),(36,10,3),(39,1,1),(39,6,2),(40,3,2),(41,5,1),(42,8,2),(43,2,1),(45,4,3),(46,7,1),(47,9,2),(48,10,1),(49,1,2),(50,3,1),(51,5,3),(53,6,2),(54,2,1),(55,4,2),(56,8,1),(57,9,3),(58,10,2),(59,1,1),(60,1,3),(62,5,1),(63,7,2),(64,2,1),(64,9,3);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`categoryId`),
  UNIQUE KEY `categoryId_UNIQUE` (`categoryId`),
  UNIQUE KEY `categoryName_UNIQUE` (`categoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=9922 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (9,'Brain Teasers'),(3,'Card Games'),(8,'Classic Games'),(5,'Educational Games'),(10,'Escape Room Games'),(9921,'Fun Games'),(6,'Party Games'),(1,'Puzzle Games'),(7,'Role-Playing Games'),(4,'Strategy Games');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `orderDetailsId` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`orderDetailsId`),
  UNIQUE KEY `orderDetailsId_UNIQUE` (`orderDetailsId`),
  KEY `details-orderId_idx` (`orderId`),
  KEY `details-productId_idx` (`productId`),
  CONSTRAINT `details-orderId` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `details-productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,1,2,2999),(2,1,3,1,1499),(4,3,2,3,2499),(5,4,4,2,1999),(6,5,6,1,4499),(7,6,7,1,3999),(8,7,8,2,1799),(9,8,9,1,2999),(10,9,10,3,1299),(11,10,1,1,2999),(12,11,3,2,1499),(13,12,5,1,3499),(14,13,7,1,3999),(15,14,9,2,2999),(16,15,2,1,2499),(17,16,4,3,1999),(18,17,6,1,4499),(19,18,8,2,1799),(20,19,10,1,1299),(21,20,1,2,2999),(22,21,3,1,1499),(23,22,5,3,3499),(24,23,7,2,3999),(25,24,9,1,2999),(26,25,2,1,2499),(27,26,4,2,1999),(28,27,6,1,4499),(29,28,8,1,1799),(30,29,10,2,1299),(31,30,1,1,2999),(33,32,5,1,3499),(34,33,7,3,3999),(35,34,9,1,2999),(36,35,2,2,2499),(37,36,4,1,1999),(38,37,6,1,4499),(39,38,8,2,1799),(40,39,10,1,1299),(41,40,1,3,2999),(42,41,3,1,1499),(43,42,5,2,3499),(44,43,7,1,3999),(45,44,9,1,2999),(46,45,2,1,2499),(47,46,4,2,1999),(48,47,6,3,4499),(49,48,8,1,1799),(50,49,10,2,1299),(51,50,1,1,2999),(52,51,3,2,1499),(53,52,5,1,3499),(54,53,7,1,3999),(55,54,9,3,2999),(56,55,2,2,2499),(57,56,4,1,1999),(58,57,6,1,4499),(59,58,8,2,1799),(60,59,10,1,1299),(62,61,3,1,1499),(63,62,5,1,3499),(64,63,7,2,3999),(65,64,9,1,2999),(66,65,2,3,2499),(67,66,4,1,1999),(68,67,6,2,4499),(69,68,8,1,1799),(70,69,10,1,1299),(71,70,1,1,2999),(72,71,3,2,1499),(73,72,5,1,3499),(74,73,7,1,3999),(75,74,9,2,2999),(76,75,2,1,2499),(77,76,4,3,1999),(78,77,6,1,4499),(79,78,8,1,1799),(80,79,10,2,1299),(81,80,1,2,2999),(82,81,3,1,1499),(83,82,5,3,3499),(84,83,7,2,3999),(85,84,9,1,2999),(86,85,2,1,2499),(87,86,4,2,1999),(88,87,6,1,4499),(89,88,8,1,1799),(90,89,10,3,1299),(91,90,1,1,2999),(101,88,1,13,2999),(102,88,2,71,2499),(103,88,3,136,1499),(104,88,4,2,1999),(105,88,5,20,3499),(106,88,8,2,1799),(107,88,9,4,2999),(108,88,10,1,1299),(109,89,2,10,2499),(110,89,3,1,1499),(111,89,4,5,1999),(112,89,5,10,3499),(113,90,4,6,1999);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `date` datetime(6) NOT NULL,
  `payType` enum('CASH','CREDIT') NOT NULL,
  `price` int NOT NULL,
  `status` enum('CANCELED','COMPLETED','PROCESSING') NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`orderId`),
  KEY `FK4xqhrpwrfhpv4bif865ircrbj` (`userId`),
  CONSTRAINT `FK4xqhrpwrfhpv4bif865ircrbj` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'123 Main St, Giza','2025-01-15 10:30:00.000000','CREDIT',7497,'COMPLETED',22),(3,'789 Pine Rd, Alexandria','2025-01-17 09:15:00.000000','CREDIT',7497,'COMPLETED',24),(4,'321 Elm St, Luxor','2025-01-18 11:20:00.000000','CASH',3998,'CANCELED',26),(5,'654 Maple Dr, Aswan','2025-01-19 16:30:00.000000','CREDIT',4499,'COMPLETED',29),(6,'987 Cedar Ln, Sharm','2025-01-20 13:10:00.000000','CASH',3999,'COMPLETED',36),(7,'135 Walnut Blvd, Hurghada','2025-01-21 15:45:00.000000','CREDIT',3598,'CANCELED',39),(8,'246 Birch St, Dahab','2025-01-22 12:00:00.000000','CASH',2999,'COMPLETED',40),(9,'369 Spruce Ave, Marsa Alam','2025-01-23 10:15:00.000000','CREDIT',3897,'COMPLETED',41),(10,'482 Pineapple Rd, Siwa','2025-01-24 14:30:00.000000','CASH',2999,'PROCESSING',42),(11,'615 Orange Dr, Fayoum','2025-01-25 09:45:00.000000','CREDIT',2998,'COMPLETED',43),(12,'748 Peach Ln, Minya','2025-01-26 11:00:00.000000','CASH',3499,'COMPLETED',45),(13,'871 Apple Blvd, Sohag','2025-01-27 16:15:00.000000','CREDIT',3999,'COMPLETED',46),(14,'994 Grape St, Qena','2025-01-28 13:30:00.000000','CASH',5998,'COMPLETED',47),(15,'117 Cherry Ave, Port Said','2025-01-29 10:45:00.000000','CREDIT',2499,'COMPLETED',48),(16,'230 Berry Rd, Ismailia','2025-01-30 15:00:00.000000','CASH',5997,'COMPLETED',49),(17,'343 Kiwi Dr, Suez','2025-01-31 12:15:00.000000','CREDIT',4499,'COMPLETED',50),(18,'456 Mango Ln, Damietta','2025-02-01 09:30:00.000000','CASH',3598,'CANCELED',51),(19,'569 Banana Blvd, Mansoura','2025-02-02 14:45:00.000000','CREDIT',1299,'COMPLETED',53),(20,'682 Lemon St, Zagazig','2025-02-03 11:00:00.000000','CASH',5998,'COMPLETED',54),(21,'795 Lime Ave, Tanta','2025-02-04 16:15:00.000000','CREDIT',1499,'COMPLETED',55),(22,'808 Melon Rd, Benha','2025-02-05 13:30:00.000000','CASH',10497,'COMPLETED',56),(23,'921 Pear Dr, Kafr El Sheikh','2025-02-06 10:45:00.000000','CREDIT',7998,'COMPLETED',57),(24,'034 Plum Ln, Menoufia','2025-02-07 15:00:00.000000','CASH',2999,'COMPLETED',58),(25,'147 Fig Blvd, Beheira','2025-02-08 12:15:00.000000','CREDIT',2499,'COMPLETED',59),(26,'250 Date St, Gharbia','2025-02-09 09:30:00.000000','CASH',3998,'COMPLETED',60),(27,'363 Apricot Ave, Dakahlia','2025-02-10 14:45:00.000000','CREDIT',4499,'COMPLETED',62),(28,'476 Guava Rd, Sharqia','2025-02-11 11:00:00.000000','CASH',1799,'CANCELED',63),(29,'589 Papaya Dr, Qalyubia','2025-02-12 16:15:00.000000','CREDIT',2598,'COMPLETED',64),(30,'702 Coconut Ln, Giza','2025-02-13 13:30:00.000000','CASH',2999,'COMPLETED',22),(32,'928 Orange St, Alexandria','2025-02-15 15:00:00.000000','CASH',3499,'COMPLETED',24),(33,'041 Peach Ave, Luxor','2025-02-16 12:15:00.000000','CREDIT',11997,'COMPLETED',26),(34,'154 Apple Rd, Aswan','2025-02-17 09:30:00.000000','CASH',2999,'COMPLETED',29),(35,'267 Grape Dr, Sharm','2025-02-18 14:45:00.000000','CREDIT',4998,'PROCESSING',36),(36,'380 Cherry Ln, Hurghada','2025-02-19 11:00:00.000000','CASH',1999,'COMPLETED',39),(37,'493 Berry Blvd, Dahab','2025-02-20 16:15:00.000000','CREDIT',4499,'COMPLETED',40),(38,'506 Kiwi St, Marsa Alam','2025-02-21 13:30:00.000000','CASH',3598,'COMPLETED',41),(39,'619 Mango Ave, Siwa','2025-02-22 10:45:00.000000','CREDIT',1299,'CANCELED',42),(40,'732 Banana Rd, Fayoum','2025-02-23 15:00:00.000000','CASH',8997,'COMPLETED',43),(41,'845 Lemon Dr, Minya','2025-02-24 12:15:00.000000','CREDIT',1499,'COMPLETED',45),(42,'958 Lime Ln, Sohag','2025-02-25 09:30:00.000000','CASH',6998,'COMPLETED',46),(43,'071 Melon Blvd, Qena','2025-02-26 14:45:00.000000','CREDIT',3999,'PROCESSING',47),(44,'184 Pear St, Port Said','2025-02-27 11:00:00.000000','CASH',2999,'COMPLETED',48),(45,'297 Plum Ave, Ismailia','2025-02-28 16:15:00.000000','CREDIT',2499,'COMPLETED',49),(46,'310 Fig Rd, Suez','2025-03-01 13:30:00.000000','CASH',3998,'COMPLETED',50),(47,'423 Date Dr, Damietta','2025-03-02 10:45:00.000000','CREDIT',13497,'COMPLETED',51),(48,'536 Apricot Ln, Mansoura','2025-03-03 15:00:00.000000','CASH',1799,'COMPLETED',53),(49,'649 Guava Blvd, Zagazig','2025-03-04 12:15:00.000000','CREDIT',2598,'CANCELED',54),(50,'762 Papaya St, Tanta','2025-03-05 09:30:00.000000','CASH',2999,'COMPLETED',55),(51,'875 Coconut Ave, Benha','2025-03-06 14:45:00.000000','CREDIT',2998,'PROCESSING',56),(52,'988 Pineapple Rd, Kafr El Sheikh','2025-03-07 11:00:00.000000','CASH',3499,'COMPLETED',57),(53,'101 Orange Dr, Menoufia','2025-03-08 16:15:00.000000','CREDIT',3999,'COMPLETED',58),(54,'214 Peach Ln, Beheira','2025-03-09 13:30:00.000000','CASH',8997,'COMPLETED',59),(55,'327 Apple Blvd, Gharbia','2025-03-10 10:45:00.000000','CREDIT',2999,'COMPLETED',60),(56,'440 Grape St, Dakahlia','2025-03-11 15:00:00.000000','CASH',4998,'COMPLETED',62),(57,'553 Cherry Ave, Sharqia','2025-03-12 12:15:00.000000','CREDIT',1999,'PROCESSING',63),(58,'666 Berry Rd, Qalyubia','2025-03-13 09:30:00.000000','CASH',4499,'COMPLETED',64),(59,'779 Kiwi Dr, Giza','2025-03-14 14:45:00.000000','CREDIT',3598,'COMPLETED',22),(61,'005 Banana Blvd, Alexandria','2025-03-16 16:15:00.000000','CREDIT',8997,'COMPLETED',24),(62,'118 Lemon St, Luxor','2025-03-17 13:30:00.000000','CASH',1499,'COMPLETED',26),(63,'231 Lime Ave, Aswan','2025-03-18 10:45:00.000000','CREDIT',6998,'COMPLETED',29),(64,'344 Melon Rd, Sharm','2025-03-19 15:00:00.000000','CASH',3999,'PROCESSING',36),(65,'457 Pear Dr, Hurghada','2025-03-20 12:15:00.000000','CREDIT',2999,'COMPLETED',39),(66,'570 Plum Ln, Dahab','2025-03-21 09:30:00.000000','CASH',2499,'COMPLETED',40),(67,'683 Fig Blvd, Marsa Alam','2025-03-22 14:45:00.000000','CREDIT',3998,'COMPLETED',41),(68,'796 Date St, Siwa','2025-03-23 11:00:00.000000','CASH',13497,'COMPLETED',42),(69,'909 Apricot Ave, Fayoum','2025-03-24 16:15:00.000000','CREDIT',1799,'COMPLETED',43),(70,'022 Guava Rd, Minya','2025-03-25 13:30:00.000000','CASH',2598,'CANCELED',45),(71,'135 Papaya Dr, Sohag','2025-03-26 10:45:00.000000','CREDIT',2999,'COMPLETED',46),(72,'248 Coconut Ln, Qena','2025-03-27 15:00:00.000000','CASH',2998,'PROCESSING',47),(73,'361 Pineapple Blvd, Port Said','2025-03-28 12:15:00.000000','CREDIT',3499,'COMPLETED',48),(74,'474 Orange St, Ismailia','2025-03-29 09:30:00.000000','CASH',3999,'COMPLETED',49),(75,'587 Peach Ave, Suez','2025-03-30 14:45:00.000000','CREDIT',8997,'COMPLETED',50),(76,'700 Apple Rd, Damietta','2025-03-31 11:00:00.000000','CASH',2999,'COMPLETED',51),(77,'813 Grape Dr, Mansoura','2025-04-01 16:15:00.000000','CREDIT',4998,'COMPLETED',53),(78,'926 Cherry Ln, Zagazig','2025-04-02 13:30:00.000000','CASH',1999,'PROCESSING',54),(79,'039 Berry Blvd, Tanta','2025-04-03 10:45:00.000000','CREDIT',4499,'COMPLETED',55),(80,'152 Kiwi St, Benha','2025-04-04 15:00:00.000000','CASH',3598,'COMPLETED',56),(81,'265 Mango Ave, Kafr El Sheikh','2025-04-05 12:15:00.000000','CREDIT',1299,'CANCELED',57),(82,'378 Banana Rd, Menoufia','2025-04-06 09:30:00.000000','CASH',8997,'COMPLETED',58),(83,'491 Lemon Dr, Beheira','2025-04-07 14:45:00.000000','CREDIT',1499,'COMPLETED',59),(84,'504 Lime Ln, Gharbia','2025-04-08 11:00:00.000000','CASH',6998,'COMPLETED',60),(85,'617 Melon Blvd, Dakahlia','2025-04-09 16:15:00.000000','CREDIT',3999,'PROCESSING',62),(86,'730 Pear St, Sharqia','2025-04-10 13:30:00.000000','CASH',2999,'COMPLETED',63),(87,'843 Plum Ave, Qalyubia','2025-04-11 10:45:00.000000','CREDIT',2499,'COMPLETED',64),(88,'ss, monib, giza, Building 5','2025-04-14 12:35:45.679000','CREDIT',511151,'PROCESSING',60),(89,'ss, giza, giza, Building 5','2025-04-14 14:15:38.322000','CREDIT',71474,'PROCESSING',65),(90,'sadat city, 9, sadat, Building 1','2025-04-14 17:02:22.813000','CREDIT',11994,'PROCESSING',65);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`productId`),
  UNIQUE KEY `productId_UNIQUE` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'MindMaze Puzzle Box','A challenging 3D puzzle box with multiple compartments to unlock',50,2999),(2,'Strategy Master Board','Advanced strategy board game for 2-4 players',35,2499),(3,'Brain Teaser Cards','Set of 100 challenging brain teaser cards',200,1499),(4,'Escape Room Kit','Complete home escape room experience for 4-6 players',27,1999),(5,'Educational Adventure','Fun educational game that teaches math and science concepts',37,3499),(6,'Party Game Collection','10 different party games in one box',30,4499),(7,'RPG Starter Set','Everything you need to start playing role-playing games',45,3999),(8,'Classic Puzzle Set','Collection of 50 classic wooden puzzles',100,1799),(9,'Logic Maze Challenge','Electronic logic maze game with 100+ levels',58,2999),(10,'Word Brain Game','Word association and vocabulary building game',0,1299),(11,'Joypad Junction','Joypad Junction desc',200,100),(12,'PixelQuest','Embark on a retro adventure in PixelQuest! Explore pixelated lands, fight quirky enemies, solve puzzles, and restore balance to a digital world — all backed by a nostalgic chiptune soundtrack.',30,300),(13,'GameHaven','GameHaven is your ultimate gaming sanctuary! Discover, explore, and shop your favorite titles across genres. From indie gems to AAA hits, GameHaven is where every gamer finds their next adventure. Your next game is just a click away!',23,200),(14,'Play Nation','Play Nation desc',22,220),(15,'new product','desc',90,100),(16,'new pro 2','2 desc',20,400),(17,'new pro3','desc 3',30,300),(18,'new product 4','desc 4',4,40),(19,'pro 5','desc 5',5,50),(20,'pro 6','desc 6',60,100),(21,'pro 7','pro 7 desc',7,7);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcategory`
--

DROP TABLE IF EXISTS `productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcategory` (
  `productId` int NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`productId`,`categoryId`),
  KEY `productCategory-cid_idx` (`categoryId`),
  CONSTRAINT `productCategory-cid` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productCategory-pid` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcategory`
--

LOCK TABLES `productcategory` WRITE;
/*!40000 ALTER TABLE `productcategory` DISABLE KEYS */;
INSERT INTO `productcategory` VALUES (1,1),(8,1),(9,1),(17,1),(3,3),(14,3),(15,3),(16,3),(20,3),(21,3),(2,4),(5,5),(10,5),(14,5),(18,5),(19,5),(6,6),(10,6),(17,6),(18,6),(7,7),(8,8),(14,8),(18,8),(19,8),(1,9),(3,9),(9,9),(15,9),(16,9),(20,9),(21,9),(4,10),(17,9921);
/*!40000 ALTER TABLE `productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `BD` date DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `buildingNo` varchar(255) DEFAULT NULL,
  `creditNo` varchar(255) DEFAULT NULL,
  `creditLimit` int DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (22,'ahmed','ava@example.com','123','2019-01-01','','','','','','',0,''),(24,'ahmed','asa@exam.s','123','2019-01-01','','','','','','',0,''),(26,'ahmed','ada@exam','123','2019-01-01','','','','','','',0,''),(29,'ahmed','aa@ex','123','2019-01-01','','','','','','',0,''),(36,'aa','saa@example.com','123','2019-01-01','','','','','','',0,''),(39,'ahmed','aav@example.com','123','2019-01-01','','','','','','',0,''),(40,'ahmed','aa5@example.com','123','2019-01-01','','','','','','',0,''),(41,'ahmed','aasas@example.com','123','2019-01-01','','','','','','',0,''),(42,'ahmed','aad@example.com','123','2019-01-01','','','','','','',0,''),(43,'ahmed','aa32@example.com','123','2019-01-01','','','','','','',0,''),(45,'ahmed','aa81@example.com','123',NULL,'','','','','','',0,''),(46,'ahmed','aacxz@example.com','123','2019-01-01','dev','giza','monibe','aa','5','',0,'asdas'),(47,'ahmed','aa66@example.com','123',NULL,'','','','','','',0,'01551872050'),(48,'ahmed','axzaa@example.com','',NULL,'','','','','','',0,''),(49,'ahmed','a3213@example.com','321',NULL,'','','','','','',0,''),(50,'ahmed','aasdfdcv@example.com','233',NULL,'','','','','','',0,''),(51,'ahmed','sruyiyuhi.y@gmail.com','123456',NULL,'','','','','','',0,''),(53,'ahmed','sruyiysssuhi.y@gmail.com','123456',NULL,'','','','','','',0,''),(54,'ahmed','sruyiyuhiddfvy@gmail.com','123456','2025-03-30','dev','giza','monib','mahar','5','1111-2222 3333 4444',563,'01551872050'),(55,'ahmed','sruyiyuhigny@gmail.com','207a7183f9654a24af6fd7bcbdb62b83:e0817019094c33327ba1b5884dae24c729e5c2a5db85dfcf778fd3aa14a38d36',NULL,'','','','','','',0,''),(56,'ahmed','a555a@example.com','05ffd8918d4f59fc8bac7120f7a347f8:f3367c4977e822b094fddd0aac63a57a2fb3026bdddd7a50d378e33560e37ba8','2025-03-30','dev','giza','','mahar','3','',0,''),(57,'username','azxca@example.com','6300c4878a0826fa5f4d7bbd6dda7403:d9f3afd18fe6fed59c54f1dc5064c3bb6338021a2b03fb7c812fca1c8991f139',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(58,'ahmed','3040128010dd1582@std.women.asu.edu.eg','554b70e790ed7249b9ca7b30883ba3d8:4fc7093e91d695d4739d3595feeca8746fd6f5361a61defb6a2623cd77708c19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(59,'username','adasxza@example.com','47b9a1b67b21a88d6e9e9b56cbdcb9f5:5406c8f633aa55644073863bb0a32dd552fdd92694cddd97c4df25c3c53d5131','2025-03-30','dev',NULL,NULL,NULL,NULL,NULL,0,'01551872050'),(60,'ahmed','12422021612796@pg.cu.edu.eg','6972f73b0ba1877a2a430d128b1e40b8:0696f1bd630b80026d14cf8151c0e5f2efd5d9ea503c0f8e1614fcc21f676403',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'123456789'),(62,'ahmed ashraf','ahmed@gmail.com','80584d4b457c1a0448b5286e299a3d0b:2a13681d2e2e83db7decfbc56d03ca290dde4b6e8eb8c809d36806a92038b933','2000-02-05','dev','giza','giza','mahar','7','1111222233334444',5000,'01551872050'),(63,'ahmed','asdx@pg.cu.edu.eg','c5a118ba00160e0c862cf45dafa1a28a:1f8247f300ff1920ec2c8f1bad92fcd548b5ff8ce628d0d23d87305d243036ce',NULL,'ssd','d','dxz','sad','6',NULL,51,NULL),(64,'ahmed','aasdsdsss@example.com','4c6efab71a8da154ef0a6c5cdf348395:d864e0df489c681ea971bcd8b9001128c446199a84bc05f8fb04283e86f6165d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(65,'username','ahmed123@gmail.com','aa1482573749d5757fb2f0746f77708f:c3bfd547d5cb8cc500e2aa13bba7e0fe38462024c958850c4e7e76a303560208',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'01208725394');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  PRIMARY KEY (`userId`,`productId`),
  KEY `Wishlist-pid_idx` (`productId`),
  CONSTRAINT `Wishlist-pid` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `Wishlist-uid` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (36,1),(43,1),(49,1),(55,1),(59,1),(22,2),(40,2),(46,2),(51,2),(56,2),(62,2),(24,3),(36,3),(45,3),(50,3),(55,3),(60,3),(26,4),(41,4),(47,4),(53,4),(57,4),(63,4),(24,5),(39,5),(43,5),(48,5),(54,5),(59,5),(29,6),(41,6),(46,6),(51,6),(58,6),(63,6),(22,7),(39,7),(45,7),(50,7),(56,7),(62,7),(29,8),(42,8),(49,8),(57,8),(64,8),(40,9),(47,9),(53,9),(60,9),(26,10),(42,10),(48,10),(54,10),(58,10),(64,10);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-15  9:39:31

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
INSERT INTO `cart` VALUES (72,26,1),(72,40,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=9936 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (9931,'Bag'),(9924,'blouse'),(9929,'Dress'),(9932,'Glasses'),(9927,'Gym Sets'),(9926,'Hoody'),(9928,'Jackets'),(9930,'Leggings'),(9925,'pants'),(9934,'ring'),(9935,'shirt'),(9933,'Sock');
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
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (130,103,25,4,2500),(131,104,31,1,400),(132,104,40,1,230),(133,105,26,1,1500),(134,105,27,1,700),(135,105,32,1,400),(136,106,38,2,2500),(137,106,39,2,1200),(138,107,37,2,300),(139,107,38,4,2500),(140,108,29,5,600),(141,108,30,1,300),(142,109,25,1,2500),(143,109,37,2,300),(144,110,37,2,300);
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (103,'4, 5, Nasr, Building 200','2025-04-16 20:12:18.752000','CASH',10000,'PROCESSING',71),(104,'sadat city, 9, sadat, Building 160','2025-04-16 20:30:13.826000','CASH',1030,'PROCESSING',70),(105,'sadat city, 9, sadat, Building 160','2025-04-16 20:53:52.528000','CASH',4100,'PROCESSING',70),(106,'7, 5, Nasr, Building 200','2025-04-16 21:50:51.935000','CREDIT',7400,'PROCESSING',71),(107,'6, 5, Nasr, Building 200','2025-04-16 22:06:28.486000','CREDIT',10600,'PROCESSING',71),(108,'sadat city, 9, sadat, Building 30','2025-04-16 22:18:10.253000','CREDIT',3300,'PROCESSING',70),(109,'sadat city, 9, cairo, Building 20','2025-04-16 22:29:46.530000','CASH',3100,'CANCELED',70),(110,'sadat city, 9, sadat, Building 1','2025-04-16 22:32:29.295000','CREDIT',600,'PROCESSING',70);
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (24,'LC WAKIKI blouse','Soft and breathable fabric  Relaxed fit for everyday comfort  Versatile design – dress it up or down  Available in multiple colors & prints  Ideal for spring and summer wear  Material: 100% Cotton (or Polyester blend, depending on actual)',40,1000),(25,'LC WAKIKI Hoddie','tay cozy and stylish with this classic LC Waikiki hoodie. Crafted for everyday wear, it features a soft inner lining and a relaxed fit, making it your go-to layer for chilly days or laid-back weekend',51,2500),(26,'LC WAKIKI legn','Add a touch of comfort and style to your wardrobe with LC Waikiki\'s signature leggings. Designed with a flattering fit and stretch fabric, these leggings move with you—perfect for daily wear, workouts, or cozy loungin',26,1500),(27,'LC WAKIKI blouse','Discover effortless elegance with this versatile LC Waikiki blouse. Crafted from lightweight, breathable fabric, it features a relaxed silhouette, button-down front, and soft-touch texture — ideal for both work and casual settings.',39,700),(28,'LC WAKIKI blouse','Discover effortless elegance with this versatile LC Waikiki blouse. Crafted from lightweight, breathable fabric, it features a relaxed silhouette, button-down front, and soft-touch texture — ideal for both work and casual settings.',70,500),(29,'MAC Bag','he MAC Bag is a stylish and versatile accessory designed to complement your daily outfits',53,600),(30,'tshirt','This classic t-shirt is a must-have for any wardrobe. Made from soft, breathable cotton fabric,',39,300),(31,'MAC Glasses','The MAC Glasses combine cutting-edge design with unmatched functionality, making them the perfect accessory for those who value both style and performance.',78,400),(32,'LC WAKIKI Bag','The LC Waikiki Bag is the perfect blend of style, functionality, and quality. Designed to meet the needs of the modern individual, this bag is made from durable, high-quality materials that ensure long-lasting use.',54,400),(33,'ZARA Gym Set','Elevate your workout wardrobe with the ZARA Gym Set, designed for both style and performance',57,500),(34,'LC WAKIKI Socks','Step into everyday comfort with LC Waikiki Socks, designed to offer the perfect balance of softness, durability, and style. Made from high-quality, breathable materials, these socks ensure all-day freshness and a snug fit',196,100),(35,'LC WAKIKI Bag','Practical meets trendy with the LC Waikiki Bag—your go-to accessory for everyday style and convenience. Crafted from quality, long-lasting materials',60,800),(36,'LC WAKIKI glasses','Complete your look with LC Waikiki Glasses—where fashion meets everyday functionality. Designed with modern trends in mind, these glasses feature lightweight yet durable frames that ensure a comfortable fit for all-day wear.',40,200),(37,'ZARA blouse','Elevate your wardrobe with this elegant ZARA Blouse—where effortless sophistication meets modern design. Crafted from soft, breathable fabric',0,300),(38,'mango pants','Step out in style with Mango Pants—where contemporary fashion meets everyday comfort. Expertly tailored from high-quality fabrics, these pants offer a flattering fit and a sleek silhouette',54,2500),(39,'LC WAKIKI Shirt','Discover everyday style and comfort with the LC Waikiki Shirt—designed to suit any occasion with ease. Made from soft, breathable fabric, this shirt ensures a comfortable fit',98,1200),(40,'Defacto Rings','Add a touch of elegance to your look with DeFacto Rings—crafted to complement your style with charm and simplicity. Whether you prefer minimal designs or bold statement pieces, DeFacto offers a wide range of rings featuring modern shapes',299,230),(41,'Defacto Bag','the DeFacto Bag—designed for fashion-forward functionality. Crafted from quality materials, this bag offers a sleek design with ample space to carry your daily essentials. Whether it\'s a crossbody, tote, or backpack,',240,1000);
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
INSERT INTO `productcategory` VALUES (24,9924),(27,9924),(28,9924),(37,9924),(38,9925),(25,9926),(26,9927),(30,9927),(33,9927),(26,9930),(29,9931),(32,9931),(35,9931),(41,9931),(31,9932),(36,9932),(34,9933),(40,9934),(39,9935);
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (68,'Amina Emad','amina@gmail.com','0da42b9fcc3f0ba87b7d86ae8b9a873a:f2fe6516efcf7f3175f44d1297713b651ea08092aaa545a6d8e8650917786ca4','2025-03-31',NULL,'Mansora',NULL,NULL,NULL,NULL,0,'01008605648'),(70,'Engy Turky','engy@gmail.com','9b8a6ca88f5ee6ee4cbee7102ee4a7cb:1e94fff6db375b9267dc91e76ede5070d39d06aa9ceece6b1a25fcbf286712cc','2025-03-31','','','','','','',1100,'01207999917'),(71,'Ahmed Ashraf','ahmed@gmail.com','bcf46a0a6e3510d475d8ef19a00e190e:a1715573f4317f266b5969d2397afd2f248254f79ee2450281be66d0245a4470','2025-03-31','','Nasr','5','','200','1111 2222 3333 4444',19400,'01065490950'),(72,'Rana atallah','rana@gmail.com','f9284f45bb206515ad73700e2582be89:cefb0e8ca88b285ff085a02f24792b9f39233045e3990d1100bcf14f05b144e5','2025-03-22',NULL,'sadat',NULL,'sadat city',NULL,NULL,0,'01020342684');
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

-- Dump completed on 2025-04-16 22:35:42

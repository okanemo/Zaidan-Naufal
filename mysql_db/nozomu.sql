-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: nozomu
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `member`
--

DROP TABLE IF EXISTS `member`;
/*!50001 DROP VIEW IF EXISTS `member`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `member` AS SELECT 
 1 AS `id_user`,
 1 AS `total_unit_per_uid`,
 1 AS `total_amount`,
 1 AS `rupiah_per_uid`,
 1 AS `CurrentNab`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `nab`
--

DROP TABLE IF EXISTS `nab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nab` (
  `id_nab` int NOT NULL AUTO_INCREMENT,
  `nab` float(65,5) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nab`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nab`
--

LOCK TABLES `nab` WRITE;
/*!40000 ALTER TABLE `nab` DISABLE KEYS */;
INSERT INTO `nab` VALUES (5,1.20000,'2021-04-27 06:25:03'),(6,1.00000,'2021-04-27 06:41:50'),(7,1.00000,'2021-04-27 06:44:04'),(8,1.00000,'2021-04-27 06:56:26'),(9,1.00000,'2021-04-27 06:57:19'),(10,1.00000,'2021-04-27 07:51:25'),(11,1.00000,'2021-04-27 07:52:25'),(12,0.80000,'2021-04-27 07:53:23'),(13,0.80000,'2021-04-27 08:21:04');
/*!40000 ALTER TABLE `nab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `nab_now`
--

DROP TABLE IF EXISTS `nab_now`;
/*!50001 DROP VIEW IF EXISTS `nab_now`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `nab_now` AS SELECT 
 1 AS `nab`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_trans`
--

DROP TABLE IF EXISTS `total_trans`;
/*!50001 DROP VIEW IF EXISTS `total_trans`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_trans` AS SELECT 
 1 AS `id_user`,
 1 AS `total_unit_per_uid`,
 1 AS `rupiah_per_uid`,
 1 AS `CurrentNAB`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaksi`
--

DROP TABLE IF EXISTS `transaksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaksi` (
  `id_trans` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `tipe` enum('topup','withdraw') DEFAULT NULL,
  `unit` float(65,4) NOT NULL,
  PRIMARY KEY (`id_trans`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `userdata` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksi`
--

LOCK TABLES `transaksi` WRITE;
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdata`
--

DROP TABLE IF EXISTS `userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdata` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdata`
--

LOCK TABLES `userdata` WRITE;
/*!40000 ALTER TABLE `userdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `userdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `member`
--

/*!50001 DROP VIEW IF EXISTS `member`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `member` AS with `total` as (select sum(`total_trans`.`total_unit_per_uid`) AS `total_amount` from `total_trans`) select `total_trans`.`id_user` AS `id_user`,`total_trans`.`total_unit_per_uid` AS `total_unit_per_uid`,`total`.`total_amount` AS `total_amount`,`total_trans`.`rupiah_per_uid` AS `rupiah_per_uid`,`total_trans`.`CurrentNAB` AS `CurrentNab` from (`total_trans` join `total`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `nab_now`
--

/*!50001 DROP VIEW IF EXISTS `nab_now`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `nab_now` AS select `nab`.`nab` AS `nab` from `nab` order by `nab`.`date` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_trans`
--

/*!50001 DROP VIEW IF EXISTS `total_trans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_trans` AS with `trans_base` as (select `transaksi`.`id_user` AS `id_user`,sum((case when (`transaksi`.`tipe` = 'topup') then `transaksi`.`unit` when (`transaksi`.`tipe` = 'withdraw') then -(`transaksi`.`unit`) end)) AS `total_unit_per_uid` from `transaksi` group by `transaksi`.`id_user`) select distinct `trans_base`.`id_user` AS `id_user`,`trans_base`.`total_unit_per_uid` AS `total_unit_per_uid`,(`trans_base`.`total_unit_per_uid` * `nab_now`.`nab`) AS `rupiah_per_uid`,`nab_now`.`nab` AS `CurrentNAB` from ((`transaksi` join `trans_base`) join `nab_now`) where (`trans_base`.`id_user` = `transaksi`.`id_user`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-27  8:39:44

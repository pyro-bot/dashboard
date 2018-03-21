-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: teplo
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.17.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `counters`
--

DROP TABLE IF EXISTS `counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters` (
  `id_counters` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `address` varchar(45) NOT NULL,
  `flat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_counters`,`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters`
--

LOCK TABLES `counters` WRITE;
/*!40000 ALTER TABLE `counters` DISABLE KEYS */;
INSERT INTO `counters` VALUES (1,'тепло',1,'00741814',1),(2,'тепло',1,'00757879',2);
/*!40000 ALTER TABLE `counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counters_parametrs`
--

DROP TABLE IF EXISTS `counters_parametrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters_parametrs` (
  `id_counters_parametrs` int(11) NOT NULL,
  `id_counters` int(11) DEFAULT NULL,
  `id_parametrs` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_counters_parametrs`),
  KEY `fk_counters_parametrs_1_idx` (`id_counters`),
  KEY `fk_counters_parametrs_2_idx` (`id_parametrs`),
  CONSTRAINT `fk_counters_parametrs_1` FOREIGN KEY (`id_counters`) REFERENCES `counters` (`id_counters`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_counters_parametrs_2` FOREIGN KEY (`id_parametrs`) REFERENCES `parametrs` (`id_parametrs`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters_parametrs`
--

LOCK TABLES `counters_parametrs` WRITE;
/*!40000 ALTER TABLE `counters_parametrs` DISABLE KEYS */;
INSERT INTO `counters_parametrs` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7);
/*!40000 ALTER TABLE `counters_parametrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `id_history` int(11) NOT NULL,
  `id_counters_parametrs` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `values` decimal(5,3) DEFAULT NULL,
  PRIMARY KEY (`id_history`),
  KEY `fk_history_1_idx` (`id_counters_parametrs`),
  CONSTRAINT `fk_history_1` FOREIGN KEY (`id_counters_parametrs`) REFERENCES `counters_parametrs` (`id_counters_parametrs`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametrs`
--

DROP TABLE IF EXISTS `parametrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametrs` (
  `id_parametrs` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_parametrs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametrs`
--

LOCK TABLES `parametrs` WRITE;
/*!40000 ALTER TABLE `parametrs` DISABLE KEYS */;
INSERT INTO `parametrs` VALUES (1,'температура вход','град'),(2,'температура выход','град'),(3,'Перепад температур','град'),(4,'Мощность','Гкал/ч'),(5,'Энергия','Гкал'),(6,'Объем','м3'),(7,'Расход','м3/ч');
/*!40000 ALTER TABLE `parametrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `val`
--

DROP TABLE IF EXISTS `val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `val` (
  `id_values` int(11) NOT NULL AUTO_INCREMENT,
  `id_counters_parametrs` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `value` decimal(5,3) DEFAULT NULL,
  PRIMARY KEY (`id_values`),
  KEY `fk_val_1_idx` (`id_counters_parametrs`),
  CONSTRAINT `fk_val_1` FOREIGN KEY (`id_counters_parametrs`) REFERENCES `counters_parametrs` (`id_counters_parametrs`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `val`
--

LOCK TABLES `val` WRITE;
/*!40000 ALTER TABLE `val` DISABLE KEYS */;
INSERT INTO `val` VALUES (1,1,'2018-03-21 14:59:06',22.231),(2,2,'2018-03-21 14:59:06',22.246),(3,3,'2018-03-21 14:59:06',-0.015),(4,4,'2018-03-21 14:59:06',0.000),(5,5,'2018-03-21 14:59:06',0.000),(6,6,'2018-03-21 14:59:06',0.024),(7,7,'2018-03-21 14:59:06',0.000);
/*!40000 ALTER TABLE `val` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-21 14:59:07

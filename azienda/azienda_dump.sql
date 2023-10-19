-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: azienda
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dipartimenti`
--

DROP TABLE IF EXISTS `dipartimenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dipartimenti` (
  `codice` char(5) NOT NULL,
  `nomeDip` char(35) NOT NULL,
  `sede` char(35) DEFAULT NULL,
  `dirigente` int(11) DEFAULT NULL,
  PRIMARY KEY (`codice`),
  KEY `dirigente` (`dirigente`),
  CONSTRAINT `dipartimenti_ibfk_1` FOREIGN KEY (`dirigente`) REFERENCES `impiegati` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipartimenti`
--

LOCK TABLES `dipartimenti` WRITE;
/*!40000 ALTER TABLE `dipartimenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `dipartimenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impiegati`
--

DROP TABLE IF EXISTS `impiegati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impiegati` (
  `matricola` int(11) NOT NULL AUTO_INCREMENT,
  `nome` char(30) NOT NULL,
  `cognome` char(30) NOT NULL,
  `residenza` char(25) DEFAULT NULL,
  `stipendio` decimal(9,2) DEFAULT NULL,
  `codDip` char(5) DEFAULT NULL,
  PRIMARY KEY (`matricola`),
  KEY `codDip` (`codDip`),
  CONSTRAINT `impiegati_ibfk_1` FOREIGN KEY (`codDip`) REFERENCES `dipartimenti` (`codice`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiegati`
--

LOCK TABLES `impiegati` WRITE;
/*!40000 ALTER TABLE `impiegati` DISABLE KEYS */;
/*!40000 ALTER TABLE `impiegati` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-29 10:26:47

-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: teatro
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `entradas`
--

DROP TABLE IF EXISTS `entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entradas` (
  `id_entrada` int NOT NULL AUTO_INCREMENT,
  `id_funcion` int NOT NULL,
  `id_usuario` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `fecha_compra` datetime NOT NULL,
  PRIMARY KEY (`id_entrada`),
  KEY `id_funcion` (`id_funcion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`id_funcion`) REFERENCES `funciones` (`id_funcion`),
  CONSTRAINT `entradas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entradas`
--

LOCK TABLES `entradas` WRITE;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` VALUES (1,1,1,2000.00,'2025-01-10 12:00:00'),(2,2,2,1500.00,'2025-01-12 15:30:00'),(3,3,3,2500.00,'2025-01-14 18:45:00'),(4,1,3,123.00,'2025-01-28 20:43:14');
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_entrada_update` AFTER UPDATE ON `entradas` FOR EACH ROW BEGIN
    INSERT INTO teatro.historial_entradas (id_entrada, accion, fecha_accion)
    VALUES (NEW.id_entrada, 'Actualización de entrada', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `entradas_compradas`
--

DROP TABLE IF EXISTS `entradas_compradas`;
/*!50001 DROP VIEW IF EXISTS `entradas_compradas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entradas_compradas` AS SELECT 
 1 AS `id_entrada`,
 1 AS `precio`,
 1 AS `fecha_compra`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `titulo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `espectaculos`
--

DROP TABLE IF EXISTS `espectaculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espectaculos` (
  `id_espectaculo` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `duracion` int NOT NULL,
  `id_genero` int NOT NULL,
  PRIMARY KEY (`id_espectaculo`),
  KEY `id_genero` (`id_genero`),
  CONSTRAINT `espectaculos_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espectaculos`
--

LOCK TABLES `espectaculos` WRITE;
/*!40000 ALTER TABLE `espectaculos` DISABLE KEYS */;
INSERT INTO `espectaculos` VALUES (1,'El Gran Show','2025-02-10','20:00:00',120,1),(2,'Drama en la Noche','2025-02-15','21:00:00',150,2),(3,'Canta con Nosotros','2025-03-01','19:30:00',90,3),(4,'Pesadilla Oscura','2025-03-05','22:00:00',100,4),(5,'Mundo Mágico','2025-03-10','18:00:00',130,5);
/*!40000 ALTER TABLE `espectaculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `id_entrada` int NOT NULL,
  `fecha_factura` datetime NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `id_entrada` (`id_entrada`),
  CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`id_entrada`) REFERENCES `entradas` (`id_entrada`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,1,'2025-01-10 12:35:00',200.00),(2,2,'2025-01-12 16:15:00',150.00);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `facturas_detalle`
--

DROP TABLE IF EXISTS `facturas_detalle`;
/*!50001 DROP VIEW IF EXISTS `facturas_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `facturas_detalle` AS SELECT 
 1 AS `id_factura`,
 1 AS `monto`,
 1 AS `fecha_factura`,
 1 AS `id_entrada`,
 1 AS `nombre`,
 1 AS `apellido`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `funciones`
--

DROP TABLE IF EXISTS `funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funciones` (
  `id_funcion` int NOT NULL AUTO_INCREMENT,
  `id_espectaculo` int NOT NULL,
  `id_sala` int NOT NULL,
  `fecha_funcion` date NOT NULL,
  `hora_funcion` time NOT NULL,
  PRIMARY KEY (`id_funcion`),
  KEY `id_espectaculo` (`id_espectaculo`),
  KEY `id_sala` (`id_sala`),
  CONSTRAINT `funciones_ibfk_1` FOREIGN KEY (`id_espectaculo`) REFERENCES `espectaculos` (`id_espectaculo`),
  CONSTRAINT `funciones_ibfk_2` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funciones`
--

LOCK TABLES `funciones` WRITE;
/*!40000 ALTER TABLE `funciones` DISABLE KEYS */;
INSERT INTO `funciones` VALUES (1,1,1,'2025-02-10','20:00:00'),(2,2,2,'2025-02-15','21:00:00'),(3,3,1,'2025-03-01','19:30:00'),(4,4,2,'2025-03-05','22:00:00'),(5,5,1,'2025-03-10','18:00:00');
/*!40000 ALTER TABLE `funciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_funcion_update` AFTER UPDATE ON `funciones` FOR EACH ROW BEGIN
    INSERT INTO teatro.historial_funciones (id_funcion, accion, fecha_accion)
    VALUES (NEW.id_funcion, 'Actualización de función', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generos` (
  `id_genero` int NOT NULL AUTO_INCREMENT,
  `genero` varchar(50) NOT NULL,
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generos`
--

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;
INSERT INTO `generos` VALUES (1,'Comedia'),(2,'Drama'),(3,'Musical'),(4,'Terror'),(5,'Fantasía');
/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_entradas`
--

DROP TABLE IF EXISTS `historial_entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_entradas` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
  `id_entrada` int NOT NULL,
  `accion` varchar(255) NOT NULL,
  `fecha_accion` datetime NOT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `id_entrada` (`id_entrada`),
  CONSTRAINT `historial_entradas_ibfk_1` FOREIGN KEY (`id_entrada`) REFERENCES `entradas` (`id_entrada`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_entradas`
--

LOCK TABLES `historial_entradas` WRITE;
/*!40000 ALTER TABLE `historial_entradas` DISABLE KEYS */;
INSERT INTO `historial_entradas` VALUES (1,1,'Entrada comprada','2025-01-10 12:00:00'),(2,2,'Entrada cancelada','2025-01-12 16:00:00');
/*!40000 ALTER TABLE `historial_entradas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_funciones`
--

DROP TABLE IF EXISTS `historial_funciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_funciones` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
  `id_funcion` int NOT NULL,
  `accion` varchar(255) NOT NULL,
  `fecha_accion` datetime NOT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `id_funcion` (`id_funcion`),
  CONSTRAINT `historial_funciones_ibfk_1` FOREIGN KEY (`id_funcion`) REFERENCES `funciones` (`id_funcion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_funciones`
--

LOCK TABLES `historial_funciones` WRITE;
/*!40000 ALTER TABLE `historial_funciones` DISABLE KEYS */;
INSERT INTO `historial_funciones` VALUES (1,1,'Se agregó nueva función','2025-01-01 10:00:00'),(2,2,'Se reprogramó la fecha de función','2025-01-05 14:00:00');
/*!40000 ALTER TABLE `historial_funciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `historial_funciones_view`
--

DROP TABLE IF EXISTS `historial_funciones_view`;
/*!50001 DROP VIEW IF EXISTS `historial_funciones_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `historial_funciones_view` AS SELECT 
 1 AS `id_historial`,
 1 AS `accion`,
 1 AS `fecha_accion`,
 1 AS `id_funcion`,
 1 AS `titulo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `metodos_de_pago`
--

DROP TABLE IF EXISTS `metodos_de_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_de_pago` (
  `id_metodo` int NOT NULL AUTO_INCREMENT,
  `metodo_pago` varchar(50) NOT NULL,
  PRIMARY KEY (`id_metodo`),
  CONSTRAINT `metodos_de_pago_chk_1` CHECK ((`metodo_pago` in (_utf8mb4'Tarjeta_credito',_utf8mb4'Tarjeta_debito',_utf8mb4'Mercado_pago',_utf8mb4'efectivo')))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_de_pago`
--

LOCK TABLES `metodos_de_pago` WRITE;
/*!40000 ALTER TABLE `metodos_de_pago` DISABLE KEYS */;
INSERT INTO `metodos_de_pago` VALUES (1,'efectivo'),(2,'Tarjeta_credito'),(3,'Tarjeta_debito'),(4,'Mercado_pago');
/*!40000 ALTER TABLE `metodos_de_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_entrada` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `id_metodo_pago` int NOT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_entrada` (`id_entrada`),
  KEY `id_metodo_pago` (`id_metodo_pago`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_entrada`) REFERENCES `entradas` (`id_entrada`),
  CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodos_de_pago` (`id_metodo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,1,2000.00,'2025-01-10 12:30:00',1),(2,2,1500.00,'2025-01-12 15:45:00',2),(3,3,2500.00,'2025-01-14 19:00:00',3),(4,4,123.00,'2025-01-28 20:43:14',2);
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `pagos_detalle`
--

DROP TABLE IF EXISTS `pagos_detalle`;
/*!50001 DROP VIEW IF EXISTS `pagos_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pagos_detalle` AS SELECT 
 1 AS `id_pago`,
 1 AS `monto`,
 1 AS `fecha_pago`,
 1 AS `id_entrada`,
 1 AS `nombre`,
 1 AS `apellido`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Acceso total a todos los recursos y configuraciones'),(2,'Usuario','Acceso limitado a funciones básicas'),(3,'Premium','Acceso a funciones avanzadas y contenido exclusivo');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas` (
  `id_sala` int NOT NULL AUTO_INCREMENT,
  `nombre_sala` varchar(100) NOT NULL,
  `capacidad` int NOT NULL,
  PRIMARY KEY (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
INSERT INTO `salas` VALUES (1,'Sala Principal',500),(2,'Sala Secundaria',200),(3,'Sala VIP',50);
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id_ticket` int NOT NULL AUTO_INCREMENT,
  `id_entrada` int NOT NULL,
  `estado` enum('pendiente','validado') NOT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `id_entrada` (`id_entrada`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`id_entrada`) REFERENCES `entradas` (`id_entrada`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,'validado'),(2,2,'pendiente');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Juan','Pérez','juanperez@example.com','1234567890'),(2,'María','González','mariagonzalez@example.com','0987654321'),(3,'Carlos','Rodríguez','carlosrodriguez@example.com','1122334455'),(4,'Dasya','Drake','ddrake0@independent.co.uk','+237 475 209 5619'),(5,'Glynnis','Gummoe','ggummoe1@furl.net','+504 102 664 8056'),(6,'Katrina','Darlaston','kdarlaston2@opera.com','+86 248 983 9892'),(7,'Kalvin','Jillett','kjillett3@simplemachines.org','+86 224 811 8613'),(8,'Bev','Austin','baustin4@infoseek.co.jp','+255 585 279 3284'),(9,'Claudianus','Calderhead','ccalderhead5@nps.gov','+7 925 318 2072'),(10,'Gavan','Tremayle','gtremayle6@mediafire.com','+86 451 863 7910'),(11,'Georgie','Bater','gbater7@zdnet.com','+358 759 479 2931'),(12,'Caron','Bagenal','cbagenal8@google.co.jp','+63 833 449 7041'),(13,'Katee','Kropach','kkropach9@creativecommons.org','+62 621 401 5103'),(14,'Steffane','Murfin','smurfina@shutterfly.com','+92 571 901 3244'),(15,'Cortney','Baggot','cbaggotb@economist.com','+54 746 479 3944'),(16,'Thaddus','Bartholomaus','tbartholomausc@example.com','+385 420 397 8115'),(17,'Henryetta','Fominov','hfominovd@chron.com','+55 211 790 0878'),(18,'Padraig','Balthasar','pbalthasare@indiatimes.com','+66 268 913 2613'),(19,'Delmor','Ferroni','dferronif@redcross.org','+1 477 586 6635'),(20,'Liesa','Purnell','lpurnellg@wired.com','+86 290 394 4382'),(21,'Thia','Van Schafflaer','tvanschafflaerh@blogger.com','+86 250 267 9987'),(22,'Ashlee','Woodrooffe','awoodrooffei@ted.com','+374 551 331 1973'),(23,'Norine','Malser','nmalserj@timesonline.co.uk','+63 270 900 3565'),(24,'Dewey','Mulran','dmulrank@yandex.ru','+63 741 767 4615'),(25,'Trixy','McKenna','tmckennal@eventbrite.com','+593 319 925 7399'),(26,'Trix','Seabridge','tseabridgem@dmoz.org','+86 397 926 1484'),(27,'Curtis','Dockrell','cdockrelln@squarespace.com','+86 833 424 9352'),(28,'Minny','Frift','mfrifto@google.ru','+351 652 896 4916'),(29,'Silas','Ellcome','sellcomep@deliciousdays.com','+358 436 761 0993'),(30,'Filippo','Degg','fdeggq@last.fm','+86 747 589 8712'),(31,'Kalle','Rodway','krodwayr@dagondesign.com','+81 631 873 4341'),(32,'Kinny','Rosenblatt','krosenblatts@nba.com','+86 925 969 0448'),(33,'Scotti','Brazur','sbrazurt@springer.com','+84 780 841 2338'),(34,'Gawen','Caulkett','gcaulkettu@comcast.net','+46 335 341 6818'),(35,'Ermentrude','Goscar','egoscarv@addthis.com','+502 462 988 2337'),(36,'Xylia','Sedgwick','xsedgwickw@yelp.com','+7 762 137 4055'),(37,'Fredek','Hellwich','fhellwichx@youtu.be','+374 174 322 5548'),(38,'Cornie','Gallager','cgallagery@surveymonkey.com','+7 123 562 6608'),(39,'Vince','Print','vprintz@ameblo.jp','+48 566 417 0399'),(40,'Darren','Gregorio','dgregorio10@51.la','+63 330 226 6556'),(41,'Claudia','Lemanu','clemanu11@smugmug.com','+84 835 192 4868'),(42,'Ingaberg','Rist','irist12@wunderground.com','+385 254 776 9030'),(43,'Harbert','MacGilrewy','hmacgilrewy13@thetimes.co.uk','+963 326 118 6455'),(44,'Sabrina','Castellet','scastellet14@ocn.ne.jp','+387 340 289 4341'),(45,'Findlay','Litherborough','flitherborough15@histats.com','+62 247 786 2980'),(46,'Carlye','Brookwell','cbrookwell16@mozilla.org','+1 895 744 6224'),(47,'Dorey','Howen','dhowen17@whitehouse.gov','+359 699 154 5945'),(48,'Mirilla','Burrett','mburrett18@google.com.au','+33 650 376 5259'),(49,'Dwayne','Harback','dharback19@abc.net.au','+33 936 608 5098'),(50,'Lincoln','Lackie','llackie1a@ifeng.com','+62 797 800 7497'),(51,'Hinda','Shearmur','hshearmur1b@wikia.com','+54 792 498 7348'),(52,'Glynis','Franken','gfranken1c@yale.edu','+58 321 813 9816'),(53,'Adolpho','Tree','atree1d@auda.org.au','+86 151 101 4548'),(54,'Maurizio','Ginity','mginity1e@dyndns.org','+84 491 502 9676'),(55,'Hanna','Beckham','hbeckham1f@nsw.gov.au','+62 642 492 3699'),(56,'Arlina','Sinnett','asinnett1g@timesonline.co.uk','+47 199 161 9292'),(57,'Devora','L\' Anglois','dlanglois1h@edublogs.org','+358 724 527 1193'),(58,'Bella','Bunney','bbunney1i@bbc.co.uk','+55 855 791 4728'),(59,'Gerianne','Josephs','gjosephs1j@theglobeandmail.com','+86 108 938 5075'),(60,'Terri','Sazio','tsazio1k@vistaprint.com','+55 686 754 8728'),(61,'Trent','Heenan','theenan1l@4shared.com','+355 102 138 2704'),(62,'Briant','D\'Adda','bdadda1m@wikipedia.org','+377 237 957 3706'),(63,'Price','Silbermann','psilbermann1n@senate.gov','+55 348 398 4845'),(64,'Drud','Colombier','dcolombier1o@jugem.jp','+63 397 311 5259'),(65,'Pavia','Whyte','pwhyte1p@dagondesign.com','+62 732 229 0432'),(66,'Rachel','Cowan','rcowan1q@slideshare.net','+7 173 738 2792'),(67,'Edgar','Radloff','eradloff1r@example.com','+86 637 928 5450'),(68,'Marlee','Sharer','msharer1s@patch.com','+260 608 913 4005'),(69,'Ailsun','Gorcke','agorcke1t@dropbox.com','+381 968 276 4447'),(70,'Duky','Scates','dscates1u@quantcast.com','+55 827 730 4504'),(71,'Keelby','Beedle','kbeedle1v@zdnet.com','+63 436 920 5598'),(72,'Penni','Guille','pguille1w@ucsd.edu','+86 733 485 1106'),(73,'Twila','Kingstne','tkingstne1x@apache.org','+63 830 538 4099'),(74,'Audry','Ladson','aladson1y@businesswire.com','+98 853 248 9711'),(75,'Sherwin','Jan','sjan1z@tripadvisor.com','+1 239 140 1267'),(76,'Drona','Scrivinor','dscrivinor20@samsung.com','+30 887 878 9718'),(77,'Waite','Benning','wbenning21@deliciousdays.com','+86 995 205 6762'),(78,'Tiffanie','Joy','tjoy22@canalblog.com','+86 854 883 4147'),(79,'Evaleen','Hanselmann','ehanselmann23@ebay.com','+218 724 286 3298'),(80,'Emmalee','Detloff','edetloff24@nature.com','+506 982 943 5568'),(81,'Ewart','Maker','emaker25@netlog.com','+44 894 833 6351'),(82,'Kikelia','Tommasi','ktommasi26@comcast.net','+7 596 853 3400'),(83,'Arden','Deedes','adeedes27@liveinternet.ru','+33 444 518 3310'),(84,'Carrol','Henrichs','chenrichs28@reddit.com','+7 670 163 0838'),(85,'Bard','Sharville','bsharville29@joomla.org','+7 496 793 1963'),(86,'Della','Elington','delington2a@live.com','+86 985 824 7056'),(87,'Cathe','Jiri','cjiri2b@t.co','+62 722 446 7795'),(88,'Joann','Haensel','jhaensel2c@pbs.org','+63 612 755 0706'),(89,'Ardra','Laws','alaws2d@mediafire.com','+57 521 665 1034'),(90,'Phoebe','Blagbrough','pblagbrough2e@hibu.com','+33 243 995 8916'),(91,'Odilia','Boothebie','oboothebie2f@reference.com','+49 622 805 8004'),(92,'Olia','Treske','otreske2g@hatena.ne.jp','+54 986 568 2722'),(93,'Angele','McAughtrie','amcaughtrie2h@army.mil','+1 209 112 8786'),(94,'Weider','Forri','wforri2i@slashdot.org','+380 176 806 3843'),(95,'Kariotta','Kuhn','kkuhn2j@usnews.com','+55 963 772 5923'),(96,'Eugenie','Agdahl','eagdahl2k@xing.com','+86 241 997 2016'),(97,'Maurits','Landsborough','mlandsborough2l@4shared.com','+52 400 548 9169'),(98,'Kermy','MacArd','kmacard2m@jugem.jp','+7 711 761 6573'),(99,'Flor','Sharple','fsharple2n@jugem.jp','+62 469 698 4757'),(100,'Osbourne','Vigers','ovigers2o@bluehost.com','+380 696 556 2891'),(101,'Noami','Kures','nkures2p@techcrunch.com','+86 501 290 8170'),(102,'Datha','Jost','djost2q@biglobe.ne.jp','+63 476 118 8372'),(103,'Benji','Shoulder','bshoulder2r@yellowpages.com','+7 221 574 4462'),(104,'Tabatha','Mordue','tmordue2s@360.cn','+251 405 882 1489'),(105,'Aretha','Fitzsimon','afitzsimon2t@howstuffworks.com','+62 407 966 1698'),(106,'Crissy','Anespie','canespie2u@xing.com','+62 616 101 9223'),(107,'Hilly','Skoof','hskoof2v@tuttocitta.it','+54 278 914 7089'),(108,'Audrey','Huonic','ahuonic2w@ebay.co.uk','+7 677 166 1060'),(109,'Morly','Kneath','mkneath2x@123-reg.co.uk','+62 941 369 5187'),(110,'Bent','Holstein','bholstein2y@ask.com','+7 805 695 2679'),(111,'Gardner','Dominy','gdominy2z@tmall.com','+7 852 913 5951'),(112,'Ted','Gascard','tgascard30@homestead.com','+355 765 829 9191'),(113,'Miguelita','Poleye','mpoleye31@shop-pro.jp','+1 719 939 7139'),(114,'Mara','Norgan','mnorgan32@narod.ru','+385 712 385 7656'),(115,'Malynda','Laing','mlaing33@diigo.com','+86 763 210 5873'),(116,'Henry','Brooke','hbrooke34@bloglovin.com','+63 914 567 2929'),(117,'Papageno','Kippax','pkippax35@usda.gov','+60 409 403 3185'),(118,'Dewie','Cuzen','dcuzen36@woothemes.com','+998 417 469 0929'),(119,'Vachel','Bakeup','vbakeup37@google.pl','+20 257 126 5316'),(120,'Berty','Upwood','bupwood38@etsy.com','+55 290 283 2170'),(121,'Bridie','Smeaton','bsmeaton39@edublogs.org','+63 345 764 4882'),(122,'Merissa','Corneljes','mcorneljes3a@vkontakte.ru','+252 356 526 1555'),(123,'Eden','Wilcox','ewilcox3b@webeden.co.uk','+55 666 590 1818'),(124,'Mendy','Rockall','mrockall3c@engadget.com','+7 602 219 5077'),(125,'Boone','Liverseege','bliverseege3d@nationalgeographic.com','+998 358 222 0212'),(126,'Debbi','Aberhart','daberhart3e@cdc.gov','+48 464 133 6596'),(127,'Renelle','Trowill','rtrowill3f@foxnews.com','+256 727 561 5962'),(128,'Rozalin','Omrod','romrod3g@google.co.jp','+1 702 957 6249'),(129,'Jamil','Ramalhete','jramalhete3h@sphinn.com','+62 395 458 5869'),(130,'Howard','Murby','hmurby3i@xinhuanet.com','+351 527 169 9957'),(131,'Susanna','Eagan','seagan3j@reuters.com','+54 632 969 9217'),(132,'Darcee','Toke','dtoke3k@google.ca','+86 899 803 3617'),(133,'Geoffrey','Tawton','gtawton3l@360.cn','+62 320 430 3118'),(134,'Korey','Bynert','kbynert3m@apache.org','+264 124 506 6067'),(135,'Joby','Conquest','jconquest3n@quantcast.com','+84 360 628 8197'),(136,'Chen','Phelips','cphelips3o@bbb.org','+267 843 988 2456'),(137,'Martino','Klamman','mklamman3p@walmart.com','+374 232 490 6328'),(138,'Marline','Kesteven','mkesteven3q@miitbeian.gov.cn','+48 804 396 9218'),(139,'Siobhan','Allenby','sallenby3r@nydailynews.com','+86 920 533 3643'),(140,'George','Gasparro','ggasparro3s@sbwire.com','+84 592 848 5721'),(141,'Whitaker','Valens-Smith','wvalenssmith3t@weebly.com','+86 151 155 8841'),(142,'Willie','Piggrem','wpiggrem3u@bloglovin.com','+1 512 801 9066'),(143,'Roddy','Hanaford','rhanaford3v@samsung.com','+506 979 853 0312'),(144,'Ilse','Stonham','istonham3w@skyrock.com','+86 945 278 3422'),(145,'Gerrie','Audrey','gaudrey3x@g.co','+505 148 578 3440'),(146,'Rheta','McConway','rmcconway3y@bloglines.com','+242 911 176 0453'),(147,'Janean','Elverstone','jelverstone3z@ucoz.ru','+63 961 471 3571'),(148,'Renae','Fache','rfache40@nba.com','+63 592 358 4740'),(149,'Bertrando','Ring','bring41@nymag.com','+255 215 835 6702'),(150,'Ulberto','Terrill','uterrill42@woothemes.com','+86 657 968 8249'),(151,'Friederike','Whereat','fwhereat43@illinois.edu','+7 272 140 4127'),(152,'Dot','MacCawley','dmaccawley44@qq.com','+98 288 995 1342'),(153,'Dode','Austin','daustin45@cafepress.com','+62 400 691 9955'),(154,'Isidor','Liggens','iliggens46@telegraph.co.uk','+46 780 893 5737'),(155,'Kristian','Cliff','kcliff47@yolasite.com','+420 595 758 8993'),(156,'Roberta','Aleksahkin','raleksahkin48@chronoengine.com','+86 854 843 0403'),(157,'Leone','Di Boldi','ldiboldi49@phpbb.com','+86 830 448 6762'),(158,'Siana','Older','solder4a@360.cn','+7 817 743 5664'),(159,'Carlynn','Weigh','cweigh4b@biblegateway.com','+237 939 576 6653'),(160,'Dewey','Bremond','dbremond4c@sbwire.com','+55 881 702 4048'),(161,'Effie','Yackiminie','eyackiminie4d@nhs.uk','+31 775 592 0544'),(162,'Rainer','Brobeck','rbrobeck4e@scribd.com','+55 511 808 4163'),(163,'Flemming','Kinsley','fkinsley4f@phoca.cz','+60 559 430 1825'),(164,'Marianne','Kleinhaus','mkleinhaus4g@meetup.com','+86 676 556 7495'),(165,'Christabel','McMains','cmcmains4h@craigslist.org','+86 369 850 9941'),(166,'Robb','Capelow','rcapelow4i@privacy.gov.au','+86 157 377 1392'),(167,'Ellette','Bingall','ebingall4j@globo.com','+55 769 996 7674'),(168,'Almeria','Tregensoe','atregensoe4k@people.com.cn','+212 265 623 5599'),(169,'Kara','Pilipyak','kpilipyak4l@canalblog.com','+212 699 569 0493'),(170,'Jerrold','Danielsson','jdanielsson4m@ameblo.jp','+92 905 903 1603'),(171,'Averill','Biggadyke','abiggadyke4n@home.pl','+7 985 608 3333'),(172,'Ileana','Giraudot','igiraudot4o@quantcast.com','+233 976 662 0956'),(173,'Clea','Jirka','cjirka4p@baidu.com','+1 310 549 8457'),(174,'Lynelle','Stollenberg','lstollenberg4q@omniture.com','+66 111 304 4849'),(175,'Bradly','Cowell','bcowell4r@usda.gov','+51 614 829 5901'),(176,'Orsa','Chancellor','ochancellor4s@e-recht24.de','+86 942 811 7819'),(177,'Ransom','Lightowlers','rlightowlers4t@amazonaws.com','+46 268 289 7578'),(178,'Shurlock','Archanbault','sarchanbault4u@sun.com','+86 324 719 9029'),(179,'Gael','Gilphillan','ggilphillan4v@nih.gov','+226 179 159 1425'),(180,'Bevin','Waszkiewicz','bwaszkiewicz4w@ezinearticles.com','+62 856 388 0016'),(181,'Viviyan','Mannagh','vmannagh4x@eepurl.com','+62 734 945 0081'),(182,'Moise','Danielot','mdanielot4y@techcrunch.com','+62 919 568 8030'),(183,'Brand','Noyce','bnoyce4z@dmoz.org','+964 866 448 3962'),(184,'Helaine','Toal','htoal50@cnbc.com','+62 295 162 8788'),(185,'Betti','Westhead','bwesthead51@ask.com','+1 904 704 3970'),(186,'Allys','Carmont','acarmont52@g.co','+86 724 742 2137'),(187,'Micky','Culross','mculross53@lycos.com','+62 115 679 1057'),(188,'Willie','Elstow','welstow54@dropbox.com','+54 876 422 8326'),(189,'Trip','Muir','tmuir55@ucsd.edu','+33 639 724 2650'),(190,'Kippie','Bennington','kbennington56@ox.ac.uk','+63 794 583 7448'),(191,'Ruttger','Bladen','rbladen57@dell.com','+86 843 153 8958'),(192,'Ara','Bramhill','abramhill58@squarespace.com','+86 626 280 4633'),(193,'Simeon','Harbage','sharbage59@loc.gov','+373 697 107 9591'),(194,'Jessie','Mushett','jmushett5a@ifeng.com','+86 195 137 2017'),(195,'Esme','Aizikowitz','eaizikowitz5b@ucoz.ru','+81 688 764 9831'),(196,'Delphine','Lottrington','dlottrington5c@360.cn','+62 600 140 2968'),(197,'Roxy','Manchett','rmanchett5d@lycos.com','+86 297 432 8413'),(198,'Sella','Belasco','sbelasco5e@hubpages.com','+1 903 412 2894'),(199,'Keir','Sancho','ksancho5f@gravatar.com','+48 522 917 2939'),(200,'Sylas','Vane','svane5g@photobucket.com','+81 617 323 1124'),(201,'Any','Francescoccio','afrancescoccio5h@mapquest.com','+351 721 520 6094'),(202,'Marillin','Hunnawill','mhunnawill5i@live.com','+86 591 917 3640'),(203,'Thornie','Dowglass','tdowglass5j@ocn.ne.jp','+30 985 360 2794'),(204,'Nathan','Bugdell','nbugdell5k@china.com.cn','+7 793 573 9074'),(205,'Ambrose','Dranfield','adranfield5l@meetup.com','+52 700 604 0839'),(206,'Boycey','Ghelerdini','bghelerdini5m@mediafire.com','+7 331 124 5776'),(207,'Aileen','Rofe','arofe5n@bigcartel.com','+30 483 504 6446'),(208,'Collen','Farland','cfarland5o@google.com','+86 807 608 7220'),(209,'Christophorus','Saffon','csaffon5p@paypal.com','+66 869 231 1134'),(210,'Raynell','Slaymaker','rslaymaker5q@nba.com','+48 219 717 0656'),(211,'Galven','Gerrey','ggerrey5r@youtube.com','+62 373 618 8469'),(212,'Terri','Fedorski','tfedorski5s@blogger.com','+353 318 544 1984'),(213,'Hirsch','Pollicatt','hpollicatt5t@newsvine.com','+62 601 579 4109'),(214,'Gun','Buff','gbuff5u@google.co.uk','+66 802 729 2953'),(215,'Bartie','Chotty','bchotty5v@dion.ne.jp','+30 195 622 0375'),(216,'Di','Akett','dakett5w@wix.com','+63 650 936 4719'),(217,'Cirstoforo','Courcey','ccourcey5x@goo.gl','+55 319 781 4394'),(218,'Darcy','Heibel','dheibel5y@china.com.cn','+39 246 380 9129'),(219,'Tamara','Kilcullen','tkilcullen5z@naver.com','+352 767 112 2693'),(220,'Pammy','McKomb','pmckomb60@vistaprint.com','+86 443 291 5074'),(221,'Faydra','Beaven','fbeaven61@elpais.com','+62 889 292 4207'),(222,'Hedda','Olifaunt','holifaunt62@about.com','+261 137 256 0562'),(223,'Merrill','Flockhart','mflockhart63@virginia.edu','+86 974 402 7555'),(224,'Gordy','Ounsworth','gounsworth64@moonfruit.com','+386 914 226 3319'),(225,'Cosimo','Geillier','cgeillier65@independent.co.uk','+48 734 553 3913'),(226,'Susan','Ilchuk','silchuk66@ibm.com','+62 601 112 1178'),(227,'Brice','Shave','bshave67@mozilla.com','+33 223 249 8285'),(228,'Felicio','Cheesley','fcheesley68@pcworld.com','+54 391 675 6700'),(229,'Gill','Ody','gody69@stanford.edu','+63 898 452 9314'),(230,'Silvia','Vale','svale6a@epa.gov','+62 630 442 6876'),(231,'Papagena','Cattroll','pcattroll6b@wunderground.com','+1 650 423 4403'),(232,'Minny','Powderham','mpowderham6c@uiuc.edu','+48 906 329 2710'),(233,'Kerr','Sleep','ksleep6d@economist.com','+54 516 364 5402'),(234,'Jephthah','Dobrovolny','jdobrovolny6e@fda.gov','+221 257 447 9074'),(235,'Melly','Jirka','mjirka6f@prnewswire.com','+66 623 922 6038'),(236,'Audre','Attwoull','aattwoull6g@foxnews.com','+86 287 133 2848'),(237,'Oralie','Duer','oduer6h@wp.com','+389 233 251 7914'),(238,'Doe','Zanicchelli','dzanicchelli6i@mac.com','+51 354 203 6840'),(239,'Cassandra','Hairsine','chairsine6j@opensource.org','+7 167 352 6558'),(240,'Janene','Refford','jrefford6k@washington.edu','+86 665 284 4738'),(241,'Thorvald','Pennoni','tpennoni6l@bloomberg.com','+27 309 381 0278'),(242,'Stanley','Keers','skeers6m@istockphoto.com','+53 525 454 5180'),(243,'Ellyn','Tripney','etripney6n@hp.com','+48 405 426 6073'),(244,'Consuelo','Kornyshev','ckornyshev6o@issuu.com','+54 666 777 4660'),(245,'Wendel','Tern','wtern6p@google.cn','+62 896 208 8308'),(246,'Merla','Waite','mwaite6q@cbsnews.com','+48 371 401 4607'),(247,'Rurik','Bolino','rbolino6r@ning.com','+62 382 168 6851'),(248,'Abbie','Drescher','adrescher6s@comsenz.com','+1 859 810 2678'),(249,'Orly','Erskine','oerskine6t@ox.ac.uk','+269 337 785 9693'),(250,'Jewelle','Saice','jsaice6u@wired.com','+504 619 321 2887'),(251,'Verney','Havelin','vhavelin6v@scribd.com','+81 944 821 9920'),(252,'Stefa','Everitt','severitt6w@theglobeandmail.com','+7 252 653 1784'),(253,'Buckie','Floweth','bfloweth6x@dyndns.org','+81 118 881 0168'),(254,'Godfrey','Gernier','ggernier6y@t.co','+976 631 749 2617'),(255,'Gregor','Southam','gsoutham6z@japanpost.jp','+86 284 810 1001'),(256,'Rhoda','Sissland','rsissland70@vinaora.com','+386 803 622 2663'),(257,'Rebbecca','Akroyd','rakroyd71@parallels.com','+86 106 283 1088'),(258,'Glenine','Hurnell','ghurnell72@vimeo.com','+7 370 894 3959'),(259,'Eveline','Batson','ebatson73@delicious.com','+86 868 118 3345'),(260,'Antonie','Muris','amuris74@java.com','+351 908 828 5356'),(261,'Des','Hallibone','dhallibone75@telegraph.co.uk','+7 966 776 1364'),(262,'Aldis','Kristiansen','akristiansen76@google.co.uk','+81 947 591 3622'),(263,'Kissee','Semble','ksemble77@artisteer.com','+86 610 529 8129'),(264,'Myranda','Reddin','mreddin78@hibu.com','+57 254 539 6268'),(265,'Munmro','Jacketts','mjacketts79@mozilla.com','+1 952 943 5038'),(266,'Guillermo','Chataignier','gchataignier7a@instagram.com','+46 406 502 6997'),(267,'Hedvig','Elce','helce7b@webmd.com','+52 370 893 7611'),(268,'Haywood','Fyfield','hfyfield7c@seattletimes.com','+385 130 580 5425'),(269,'Claudine','Brodley','cbrodley7d@telegraph.co.uk','+359 185 591 7626'),(270,'Mohandas','McCroft','mmccroft7e@cornell.edu','+52 517 644 3764'),(271,'Katalin','Snalum','ksnalum7f@wikipedia.org','+63 733 801 1299'),(272,'Abner','Booeln','abooeln7g@baidu.com','+55 328 698 6636'),(273,'Gan','Antoons','gantoons7h@businesswire.com','+353 840 414 1641'),(274,'Torey','Sutherel','tsutherel7i@springer.com','+51 184 825 1503'),(275,'Barth','Blakemore','bblakemore7j@people.com.cn','+33 402 398 7405'),(276,'Theodoric','Mabb','tmabb7k@naver.com','+62 350 295 8383'),(277,'Kristoforo','Bembridge','kbembridge7l@reddit.com','+55 348 863 8220'),(278,'Tedda','Knutton','tknutton7m@illinois.edu','+62 210 215 5769'),(279,'Fitzgerald','Gyde','fgyde7n@java.com','+62 481 106 5835'),(280,'Lydia','Cossentine','lcossentine7o@sitemeter.com','+81 657 374 3431'),(281,'Guinna','Peplaw','gpeplaw7p@wufoo.com','+62 724 323 9660'),(282,'Ealasaid','McGeneay','emcgeneay7q@phpbb.com','+55 578 577 5887'),(283,'Artemas','Yashaev','ayashaev7r@github.io','+31 218 503 9059'),(284,'Carin','Budden','cbudden7s@discuz.net','+353 312 912 7145'),(285,'Franky','Feild','ffeild7t@globo.com','+66 472 108 2716'),(286,'Stefa','Leale','sleale7u@salon.com','+62 971 867 5649'),(287,'Andrei','Buttfield','abuttfield7v@wordpress.com','+47 138 686 2942'),(288,'Denice','Filgate','dfilgate7w@loc.gov','+51 987 507 2697'),(289,'Giacomo','Alfonsetto','galfonsetto7x@bravesites.com','+234 255 678 3245'),(290,'Judd','Alway','jalway7y@istockphoto.com','+55 326 237 1193'),(291,'Madeleine','Lynde','mlynde7z@zdnet.com','+62 865 263 1315'),(292,'Kissie','Bountiff','kbountiff80@adobe.com','+55 560 985 6031'),(293,'Pippo','Vain','pvain81@google.com.br','+351 908 128 2865'),(294,'Georas','Canto','gcanto82@nih.gov','+351 201 443 3558'),(295,'Nicol','Shermar','nshermar83@last.fm','+60 167 678 6440'),(296,'Lindsy','Ledwith','lledwith84@jalbum.net','+502 214 388 4756'),(297,'Terrell','Beevers','tbeevers85@lycos.com','+86 385 255 2230'),(298,'Dennie','Dunnett','ddunnett86@google.it','+1 404 136 0816'),(299,'Torrin','Rappa','trappa87@foxnews.com','+86 642 666 3303'),(300,'Sig','Morteo','smorteo88@businesswire.com','+62 343 487 4639'),(301,'Kelbee','Coniff','kconiff89@salon.com','+7 754 950 3855'),(302,'Jamie','Marchand','jmarchand8a@accuweather.com','+52 210 112 0967'),(303,'Liza','Palmby','lpalmby8b@typepad.com','+1 699 511 3116'),(304,'Flossi','Barton','fbarton8c@domainmarket.com','+86 321 798 6240'),(305,'Lyndsey','Tollady','ltollady8d@state.tx.us','+62 563 713 4611'),(306,'Warner','Beney','wbeney8e@tumblr.com','+251 592 814 5470'),(307,'Gerald','Lamburne','glamburne8f@stumbleupon.com','+62 530 445 9193'),(308,'Lauretta','Strickler','lstrickler8g@tinyurl.com','+46 879 948 6615'),(309,'Dru','Mayhow','dmayhow8h@eventbrite.com','+86 203 199 1280'),(310,'Lock','Kauschke','lkauschke8i@fema.gov','+86 779 545 4472'),(311,'Esmeralda','Baynton','ebaynton8j@php.net','+46 548 256 5827'),(312,'Ilario','Grinyer','igrinyer8k@angelfire.com','+63 329 304 8287'),(313,'Ulrikaumeko','Liverseege','uliverseege8l@google.cn','+47 656 156 5814'),(314,'Gabriella','Ghidotti','gghidotti8m@usa.gov','+504 516 970 0336'),(315,'Kenneth','Barday','kbarday8n@spotify.com','+81 991 661 4108'),(316,'Ailee','Jeannot','ajeannot8o@nsw.gov.au','+30 528 914 9526'),(317,'Shoshana','Delacour','sdelacour8p@noaa.gov','+51 584 236 1548'),(318,'Lotta','Cordeux','lcordeux8q@com.com','+63 916 175 9811'),(319,'Patton','Karolovsky','pkarolovsky8r@upenn.edu','+49 684 125 9001'),(320,'Natka','Cordingly','ncordingly8s@phpbb.com','+33 876 855 2010'),(321,'Elmo','Forestel','eforestel8t@unblog.fr','+55 586 139 4035'),(322,'Ardith','McPeeters','amcpeeters8u@ted.com','+33 825 365 1506'),(323,'Hyatt','McCutheon','hmccutheon8v@opera.com','+509 664 680 1791'),(324,'Dre','Neles','dneles8w@microsoft.com','+1 901 721 7895'),(325,'Emlen','Malecky','emalecky8x@usa.gov','+420 620 913 3986'),(326,'Roze','Nealon','rnealon8y@ovh.net','+46 786 403 3985'),(327,'Yvor','Hadley','yhadley8z@youtu.be','+86 612 629 1824'),(328,'Ephrem','Meaney','emeaney90@dailymail.co.uk','+241 714 805 4599'),(329,'Joycelin','Korbmaker','jkorbmaker91@apache.org','+57 438 908 5137'),(330,'Mira','Dicey','mdicey92@alibaba.com','+63 866 815 2922'),(331,'Isaac','Kleinzweig','ikleinzweig93@vinaora.com','+66 625 311 6820'),(332,'Bernie','Abrahamson','babrahamson94@csmonitor.com','+420 628 514 6375'),(333,'Lenci','Wycliff','lwycliff95@paypal.com','+86 516 208 5548'),(334,'Chloette','Spadoni','cspadoni96@xinhuanet.com','+55 511 957 0908'),(335,'Meredith','Styche','mstyche97@skyrock.com','+55 234 290 1517'),(336,'Lacie','Brickett','lbrickett98@mediafire.com','+976 216 721 8197'),(337,'Cathee','Drinkhall','cdrinkhall99@cbslocal.com','+86 870 362 1291'),(338,'Irwinn','Dibden','idibden9a@nydailynews.com','+505 442 471 0545'),(339,'Zorana','Lambdin','zlambdin9b@dion.ne.jp','+33 298 525 2369'),(340,'Rosanne','Crate','rcrate9c@accuweather.com','+351 886 641 7068'),(341,'Yetta','Bootell','ybootell9d@wikispaces.com','+86 477 492 1683'),(342,'Heriberto','Moses','hmoses9e@ning.com','+420 818 653 0823'),(343,'Hamnet','Camel','hcamel9f@house.gov','+63 655 229 7355'),(344,'Toiboid','Fattore','tfattore9g@php.net','+48 588 522 4055'),(345,'Roxi','Silversmidt','rsilversmidt9h@sogou.com','+590 805 453 2223'),(346,'Caitrin','Brookhouse','cbrookhouse9i@marriott.com','+86 790 163 9967'),(347,'Meyer','Sacher','msacher9j@oaic.gov.au','+55 548 791 9896'),(348,'Say','Haddow','shaddow9k@comcast.net','+62 820 193 2618'),(349,'Leigh','De Bischop','ldebischop9l@webeden.co.uk','+7 172 157 6081'),(350,'Terrence','Bathurst','tbathurst9m@vinaora.com','+7 163 370 7328'),(351,'Mathilda','Lipyeat','mlipyeat9n@tmall.com','+62 853 641 8640'),(352,'Dolores','Aubrey','daubrey9o@t-online.de','+351 792 524 3366'),(353,'Katalin','Marcum','kmarcum9p@sourceforge.net','+33 210 469 3366'),(354,'Auroora','Georgel','ageorgel9q@i2i.jp','+54 326 610 2419'),(355,'Selby','Bester','sbester9r@weather.com','+234 991 966 7098'),(356,'Roberto','Plascott','rplascott9s@squidoo.com','+54 769 308 6718'),(357,'Hansiain','Duckers','hduckers9t@people.com.cn','+241 816 456 6608'),(358,'Rey','Angless','rangless9u@huffingtonpost.com','+86 866 912 4019'),(359,'Marena','Abate','mabate9v@europa.eu','+7 362 818 8139'),(360,'Carlye','Shorthill','cshorthill9w@indiatimes.com','+62 948 135 0518'),(361,'Javier','Kainz','jkainz9x@buzzfeed.com','+86 136 705 4610'),(362,'Godart','Westerman','gwesterman9y@amazon.de','+62 602 946 2778'),(363,'Addie','Yarr','ayarr9z@blogtalkradio.com','+86 575 984 4004'),(364,'Blakeley','Sollam','bsollama0@studiopress.com','+86 124 903 5880'),(365,'Jenelle','Seckington','jseckingtona1@github.com','+55 606 469 5360'),(366,'Ulrikaumeko','McCombe','umccombea2@sina.com.cn','+1 312 767 0975'),(367,'Baillie','Garken','bgarkena3@angelfire.com','+7 810 326 9352'),(368,'Cristal','Vsanelli','cvsanellia4@sciencedaily.com','+62 974 419 3142'),(369,'Katrine','Lightowlers','klightowlersa5@addtoany.com','+46 476 586 6205'),(370,'Ilysa','Blazek','iblazeka6@creativecommons.org','+86 827 456 8956'),(371,'Delainey','Popeley','dpopeleya7@studiopress.com','+48 973 293 4715'),(372,'Dori','Fussey','dfusseya8@sakura.ne.jp','+62 506 384 6147'),(373,'Madeleine','Dick','mdicka9@patch.com','+351 127 560 7744'),(374,'Riane','Quince','rquinceaa@nsw.gov.au','+1 619 192 0167'),(375,'Guglielmo','Sloam','gsloamab@wikimedia.org','+252 925 896 8544'),(376,'Sanders','Goodluck','sgoodluckac@e-recht24.de','+1 513 855 8338'),(377,'Dode','Lathwood','dlathwoodad@phpbb.com','+998 542 232 3967'),(378,'Port','Collumbine','pcollumbineae@indiatimes.com','+62 554 487 7939'),(379,'Sheridan','Taborre','staborreaf@google.pl','+7 423 475 4297'),(380,'Prudy','Eitter','peitterag@wunderground.com','+86 191 849 7400'),(381,'Michal','Redish','mredishah@topsy.com','+62 438 723 7379'),(382,'Yale','Carah','ycarahai@time.com','+62 345 229 2500'),(383,'Anders','Matashkin','amatashkinaj@prnewswire.com','+20 645 697 3846'),(384,'Rayna','Grandin','rgrandinak@google.cn','+30 860 164 8923'),(385,'Jerrie','Sidden','jsiddenal@salon.com','+506 831 234 8042'),(386,'Killie','Hodges','khodgesam@bigcartel.com','+48 678 903 9745'),(387,'Kalvin','Greader','kgreaderan@list-manage.com','+351 988 700 3231'),(388,'Gerhard','Sugarman','gsugarmanao@meetup.com','+62 391 632 2575'),(389,'Sibyl','Dowderswell','sdowderswellap@about.me','+234 282 771 5529'),(390,'Adorne','Ortells','aortellsaq@yale.edu','+375 749 319 6096'),(391,'Guthrey','Ivanilov','givanilovar@goodreads.com','+62 978 683 5262'),(392,'Sherye','McGifford','smcgiffordas@mac.com','+62 685 454 1900'),(393,'Cordie','Storey','cstoreyat@51.la','+62 405 184 7877'),(394,'Waiter','Wallbanks','wwallbanksau@ehow.com','+7 501 726 5028'),(395,'Nettie','Barras','nbarrasav@blogs.com','+994 229 648 5137'),(396,'Fidole','Jamary','fjamaryaw@studiopress.com','+51 839 311 5975'),(397,'Constancy','Kenealy','ckenealyax@a8.net','+880 875 890 2412'),(398,'Averill','Arrol','aarrolay@marriott.com','+7 523 872 2454'),(399,'Oralie','Storre','ostorreaz@google.com','+33 576 301 4861'),(400,'Warren','Showler','wshowlerb0@scientificamerican.com','+52 312 479 7626'),(401,'Serene','McDougal','smcdougalb1@biglobe.ne.jp','+236 374 411 9741'),(402,'Jana','Korn','jkornb2@sohu.com','+1 916 494 0831'),(403,'Woodrow','Johanning','wjohanningb3@yelp.com','+84 134 155 1204'),(404,'Raymund','Tiesman','rtiesmanb4@army.mil','+62 795 234 0157'),(405,'Annmaria','Gorusso','agorussob5@youku.com','+86 686 813 2784'),(406,'Arley','Verbeke','averbekeb6@disqus.com','+60 233 950 3456'),(407,'Hermina','Juden','hjudenb7@wikispaces.com','+62 475 670 8574'),(408,'Chic','Pocknoll','cpocknollb8@devhub.com','+63 132 337 9751'),(409,'Manfred','Lilion','mlilionb9@ed.gov','+86 159 847 5884'),(410,'Leone','Opy','lopyba@washingtonpost.com','+55 111 715 2671'),(411,'Kendal','Belford','kbelfordbb@list-manage.com','+62 430 642 1402'),(412,'Efrem','Bull','ebullbc@cisco.com','+63 388 970 8535'),(413,'Frederica','Warsap','fwarsapbd@ed.gov','+62 217 330 6178'),(414,'Lissie','Jendrusch','ljendruschbe@list-manage.com','+976 648 415 4418'),(415,'Ralf','Colwill','rcolwillbf@gmpg.org','+52 706 356 5912'),(416,'Jamil','Patry','jpatrybg@yandex.ru','+850 563 931 1387'),(417,'Kristy','Tees','kteesbh@prnewswire.com','+33 226 954 0138'),(418,'Elwyn','Strephan','estrephanbi@twitter.com','+46 314 538 3475'),(419,'Netti','Barfford','nbarffordbj@opera.com','+93 997 834 7597'),(420,'Jackqueline','Godfery','jgodferybk@163.com','+86 589 628 3409'),(421,'Will','Topliss','wtoplissbl@g.co','+86 305 400 2937'),(422,'Trude','Angood','tangoodbm@xinhuanet.com','+46 461 342 7361'),(423,'Etta','Shackelton','eshackeltonbn@geocities.com','+62 546 941 1545'),(424,'Traci','Faire','tfairebo@jigsy.com','+63 924 352 8741'),(425,'Garrot','Abbess','gabbessbp@examiner.com','+63 152 824 4959'),(426,'Hi','Reditt','hredittbq@51.la','+33 532 241 1839'),(427,'Huberto','Folks','hfolksbr@virginia.edu','+48 755 303 1940'),(428,'Dall','Dooman','ddoomanbs@seesaa.net','+86 382 342 3924'),(429,'Alexandr','McIsaac','amcisaacbt@delicious.com','+93 806 944 4420'),(430,'Elfrida','De Launde','edelaundebu@latimes.com','+62 315 433 0077'),(431,'Jory','MacConnal','jmacconnalbv@wikimedia.org','+55 611 932 4589'),(432,'Gabrila','Kleeborn','gkleebornbw@youtu.be','+504 268 487 4801'),(433,'Franklin','Twell','ftwellbx@reference.com','+54 218 746 9373'),(434,'Terri-jo','Pattesall','tpattesallby@rediff.com','+234 302 140 8430'),(435,'Mehetabel','Leguay','mleguaybz@bizjournals.com','+62 751 998 3993'),(436,'Barbaraanne','McLanachan','bmclanachanc0@biblegateway.com','+46 251 122 0189'),(437,'Scarlet','Chieco','schiecoc1@berkeley.edu','+30 311 489 0205'),(438,'Lucais','Grimston','lgrimstonc2@nationalgeographic.com','+62 755 545 2825'),(439,'Jocelyne','Boutwell','jboutwellc3@imdb.com','+48 545 824 4704'),(440,'Diandra','Rose','drosec4@cpanel.net','+880 465 421 5060'),(441,'Yasmin','Boyn','yboync5@booking.com','+86 902 615 0353'),(442,'Nell','Danit','ndanitc6@chronoengine.com','+63 643 350 4276'),(443,'Binky','Nuttall','bnuttallc7@stumbleupon.com','+7 711 353 6228'),(444,'Gail','O\'Doghesty','godoghestyc8@ameblo.jp','+1 952 466 4117'),(445,'Marney','Norree','mnorreec9@delicious.com','+81 597 100 7797'),(446,'Sonnie','Palleske','spalleskeca@microsoft.com','+54 253 570 6879'),(447,'Adelaide','Brauner','abraunercb@newyorker.com','+66 607 536 4842'),(448,'Kayle','Croydon','kcroydoncc@imdb.com','+86 254 684 5704'),(449,'Cristobal','Itshak','citshakcd@dot.gov','+972 725 927 4648'),(450,'Gilemette','Jakubiak','gjakubiakce@nifty.com','+86 141 492 3925'),(451,'Arlen','Moan','amoancf@psu.edu','+263 284 945 9257'),(452,'Cherida','Wincom','cwincomcg@reddit.com','+7 500 989 8342'),(453,'Prent','Glidden','pgliddench@nyu.edu','+93 989 415 7672'),(454,'Lisetta','Garrettson','lgarrettsonci@howstuffworks.com','+62 811 567 8101'),(455,'Robena','Sayes','rsayescj@cam.ac.uk','+7 728 237 5874'),(456,'Isabelita','Romera','iromerack@sfgate.com','+63 322 884 1119'),(457,'Damaris','Semper','dsempercl@shop-pro.jp','+93 628 391 3260'),(458,'Burk','Deporte','bdeportecm@jigsy.com','+51 491 900 7039'),(459,'Karyl','Winscom','kwinscomcn@skyrock.com','+62 441 735 1724'),(460,'Misty','Regina','mreginaco@japanpost.jp','+7 854 240 7433'),(461,'Cher','Parfett','cparfettcp@forbes.com','+351 633 944 8569'),(462,'Tracey','Karpov','tkarpovcq@fc2.com','+86 628 523 5229'),(463,'Crichton','Balma','cbalmacr@mozilla.org','+504 830 171 4152'),(464,'Morey','Eddis','meddiscs@yellowbook.com','+962 794 177 5137'),(465,'Kendricks','Ashwood','kashwoodct@ed.gov','+62 804 403 2413'),(466,'Vidovic','Cappleman','vcapplemancu@networkadvertising.org','+86 680 697 2074'),(467,'Shina','Bridgman','sbridgmancv@marriott.com','+212 309 808 3193'),(468,'Keven','McKaile','kmckailecw@hhs.gov','+55 916 693 5788'),(469,'Amargo','Spendley','aspendleycx@ocn.ne.jp','+51 714 323 7138'),(470,'Faber','Boxill','fboxillcy@ocn.ne.jp','+46 214 290 6281'),(471,'Zorana','Brake','zbrakecz@privacy.gov.au','+86 909 831 8319'),(472,'Clair','Buer','cbuerd0@gravatar.com','+55 509 391 0363'),(473,'Dori','Cowans','dcowansd1@virginia.edu','+86 863 983 1926'),(474,'Guenevere','Thurlbeck','gthurlbeckd2@tiny.cc','+60 481 660 4683'),(475,'Theadora','Tilley','ttilleyd3@vkontakte.ru','+353 708 517 9439'),(476,'Brannon','Stoakes','bstoakesd4@soundcloud.com','+86 189 487 3822'),(477,'Ondrea','Sandbatch','osandbatchd5@hibu.com','+51 663 152 2413'),(478,'Livia','Dawdary','ldawdaryd6@mysql.com','+86 201 709 1954'),(479,'Fenelia','Randalson','frandalsond7@ucoz.ru','+1 887 618 2466'),(480,'Wynn','Bootton','wboottond8@tumblr.com','+46 897 299 6874'),(481,'Gene','Venour','gvenourd9@ft.com','+86 904 194 0122'),(482,'Kaleb','Senter','ksenterda@amazon.co.jp','+81 206 161 5132'),(483,'Von','Dumingo','vdumingodb@yelp.com','+226 254 308 7189'),(484,'Joby','Wescott','jwescottdc@loc.gov','+86 324 237 6126'),(485,'Christy','Perrelle','cperrelledd@cdbaby.com','+31 764 278 0355'),(486,'Lula','Aylott','laylottde@cbsnews.com','+224 472 304 2194'),(487,'Neddie','Brammer','nbrammerdf@cam.ac.uk','+380 395 940 7069'),(488,'Jarret','Cunnow','jcunnowdg@bloomberg.com','+55 120 143 9541'),(489,'Pooh','Blei','pbleidh@house.gov','+86 929 811 9399'),(490,'Oliver','Blaxland','oblaxlanddi@sfgate.com','+86 711 972 2520'),(491,'Harrietta','Itzkovici','hitzkovicidj@npr.org','+46 191 704 6061'),(492,'Fernandina','Ciani','fcianidk@wisc.edu','+1 916 553 2774'),(493,'Erma','Defries','edefriesdl@blogtalkradio.com','+86 459 272 3312'),(494,'Douglas','Ruspine','druspinedm@umn.edu','+86 636 636 5524'),(495,'Trumann','Heathfield','theathfielddn@census.gov','+502 401 295 1464'),(496,'Tammie','Worsfold','tworsfolddo@diigo.com','+7 250 734 7333'),(497,'Artemus','Piscopo','apiscopodp@blogs.com','+505 394 298 9815'),(498,'Jania','Brabant','jbrabantdq@github.io','+7 846 918 3428'),(499,'Lincoln','Davidovics','ldavidovicsdr@histats.com','+48 903 255 4513'),(500,'Taffy','Cotterill','tcotterillds@sourceforge.net','+62 954 484 9570'),(501,'Silva','Mailey','smaileydt@home.pl','+86 984 160 8712'),(502,'Fidole','Bainton','fbaintondu@odnoklassniki.ru','+995 504 396 4292'),(503,'Tallou','Brand-Hardy','tbrandhardydv@trellian.com','+420 390 536 6190'),(504,'Far','Hryskiewicz','fhryskiewiczdw@plala.or.jp','+45 598 635 4158'),(505,'Shamus','De Few','sdefewdx@tumblr.com','+7 723 434 6518'),(506,'Arlyne','Mulqueeny','amulqueenydy@tiny.cc','+352 780 637 0717'),(507,'Cindie','Francillo','cfrancillodz@gmpg.org','+7 277 150 3150'),(508,'Marten','Khadir','mkhadire0@webmd.com','+33 786 211 9693'),(509,'Rutter','Merle','rmerlee1@digg.com','+596 114 800 3484'),(510,'Linn','Sellen','lsellene2@mapy.cz','+994 481 103 2132'),(511,'Zachery','Ricardet','zricardete3@netscape.com','+1 209 262 1951'),(512,'Britteny','Purkins','bpurkinse4@dailymotion.com','+86 268 385 2542'),(513,'Raffarty','Darrington','rdarringtone5@aol.com','+86 638 794 2975'),(514,'Ellen','Ricoald','ericoalde6@qq.com','+20 469 633 2910'),(515,'Barclay','Daw','bdawe7@digg.com','+62 590 259 0570'),(516,'Georgy','Abbott','gabbotte8@soundcloud.com','+355 996 724 6454'),(517,'Skyler','Lanaway','slanawaye9@networkadvertising.org','+856 655 920 0828'),(518,'Marie-ann','Wickstead','mwicksteadea@ifeng.com','+62 428 333 3019'),(519,'Yvon','Choke','ychokeeb@51.la','+48 660 427 3598'),(520,'Tiffie','Yedy','tyedyec@wired.com','+62 293 670 7366'),(521,'Adella','Ledamun','aledamuned@businesswire.com','+62 393 914 3472'),(522,'Kennedy','McIvor','kmcivoree@ted.com','+86 351 976 2663'),(523,'Cammi','Witts','cwittsef@adobe.com','+55 782 602 6981'),(524,'Rosamond','Blonfield','rblonfieldeg@ox.ac.uk','+86 353 700 5217'),(525,'Ginny','Josum','gjosumeh@irs.gov','+62 312 975 1974'),(526,'Ingamar','Lambal','ilambalei@ihg.com','+351 602 276 6971'),(527,'Fayina','Colthurst','fcolthurstej@blogger.com','+62 874 377 9612'),(528,'Nicolea','Chattington','nchattingtonek@wikia.com','+7 762 839 3424'),(529,'Lonnie','Harlow','lharlowel@pagesperso-orange.fr','+48 330 716 9167'),(530,'Rosie','Lineen','rlineenem@about.com','+54 634 373 2303'),(531,'Ruby','Rebert','rreberten@ed.gov','+86 566 245 5424'),(532,'Brittaney','Boswell','bboswelleo@discovery.com','+86 224 415 1219'),(533,'Emlen','Berrigan','eberriganep@wix.com','+251 288 901 1176'),(534,'Tessy','Capelin','tcapelineq@imdb.com','+86 253 333 0431'),(535,'Leicester','Graeme','lgraemeer@trellian.com','+62 908 587 8972'),(536,'Samaria','Bolin','sbolines@imdb.com','+86 167 407 8144'),(537,'Heidi','Falconar','hfalconaret@ebay.co.uk','+33 380 487 5756'),(538,'Lauretta','Leonarde','lleonardeeu@tinyurl.com','+46 839 558 4192'),(539,'Inglis','Hallihane','ihallihaneev@dot.gov','+55 703 717 0115'),(540,'Hortensia','Connachan','hconnachanew@vkontakte.ru','+86 359 660 7131'),(541,'Cleveland','Callar','ccallarex@lulu.com','+86 939 777 5455'),(542,'Garfield','Gisburn','ggisburney@ezinearticles.com','+234 272 180 1644'),(543,'Chiquita','Eagland','ceaglandez@amazon.co.uk','+84 278 316 2786'),(544,'Aharon','Pidgeley','apidgeleyf0@360.cn','+48 341 182 9553'),(545,'Estele','Vaughton','evaughtonf1@marketwatch.com','+81 506 939 1316'),(546,'Roz','Bett','rbettf2@washingtonpost.com','+86 920 288 4023'),(547,'Samaria','Labeuil','slabeuilf3@marriott.com','+1 804 387 0214'),(548,'Lucian','Kibel','lkibelf4@tinyurl.com','+86 214 211 0690'),(549,'Mohandis','Heijne','mheijnef5@creativecommons.org','+86 149 614 4146'),(550,'Hilliary','Tran','htranf6@vkontakte.ru','+972 359 522 4889'),(551,'Tan','Stedall','tstedallf7@youku.com','+1 404 130 7008'),(552,'Enrico','Grewcock','egrewcockf8@dropbox.com','+62 131 961 2553'),(553,'Carmel','Yankishin','cyankishinf9@netvibes.com','+269 670 724 4978'),(554,'Aube','Noel','anoelfa@reference.com','+92 213 504 9837'),(555,'Con','Demead','cdemeadfb@ftc.gov','+84 738 753 1511'),(556,'Abeu','Dolley','adolleyfc@smh.com.au','+263 796 975 0068'),(557,'Olympia','Ashborne','oashbornefd@umich.edu','+218 943 510 6516'),(558,'Elmore','Ablett','eablettfe@nifty.com','+46 751 369 5836'),(559,'Alanah','Tiddy','atiddyff@umn.edu','+966 211 627 8075'),(560,'Allistir','Eve','aevefg@wikispaces.com','+31 971 791 7362'),(561,'Scottie','Hazel','shazelfh@epa.gov','+56 818 397 3769'),(562,'Celina','Matthewman','cmatthewmanfi@photobucket.com','+880 529 887 4162'),(563,'Dasha','Mosley','dmosleyfj@unblog.fr','+57 754 705 8529'),(564,'Brand','Maddison','bmaddisonfk@plala.or.jp','+86 559 737 9302'),(565,'Connie','MacIlory','cmaciloryfl@miibeian.gov.cn','+86 608 578 6042'),(566,'Victoria','Speedin','vspeedinfm@spiegel.de','+53 767 794 4510'),(567,'Merry','Tithecote','mtithecotefn@usatoday.com','+62 899 220 8041'),(568,'Drugi','Dorre','ddorrefo@youtube.com','+351 129 246 8605'),(569,'Adriane','Simnel','asimnelfp@merriam-webster.com','+86 676 545 6832'),(570,'Alidia','Kees','akeesfq@wordpress.com','+62 850 434 1164'),(571,'Sigrid','Drissell','sdrissellfr@businesswire.com','+86 375 412 7353'),(572,'Charmion','Monnoyer','cmonnoyerfs@t.co','+1 805 519 2045'),(573,'Darya','Seaking','dseakingft@craigslist.org','+381 874 711 3931'),(574,'Bing','Lidyard','blidyardfu@sourceforge.net','+48 465 836 4588'),(575,'Binky','Gunda','bgundafv@taobao.com','+86 370 457 5703'),(576,'Adela','Selwyne','aselwynefw@multiply.com','+420 279 298 7730'),(577,'Marcelia','Gregoire','mgregoirefx@wufoo.com','+7 361 186 5492'),(578,'Albrecht','Korneichik','akorneichikfy@sphinn.com','+375 392 202 5920'),(579,'Brittne','Blodg','bblodgfz@apple.com','+62 907 636 6415'),(580,'Holly-anne','Haley','hhaleyg0@cloudflare.com','+7 925 475 3649'),(581,'Dolph','Biscomb','dbiscombg1@about.me','+1 360 485 3659'),(582,'Bethanne','Klampk','bklampkg2@redcross.org','+86 655 747 2864'),(583,'Lenora','Van Dalen','lvandaleng3@printfriendly.com','+880 577 848 1736'),(584,'Natka','Raistrick','nraistrickg4@hp.com','+33 888 213 3301'),(585,'Ethyl','Ciepluch','eciepluchg5@squidoo.com','+86 708 196 1301'),(586,'Adorne','Truitt','atruittg6@phpbb.com','+355 106 436 9398'),(587,'Vaclav','De la Yglesia','vdelayglesiag7@tripod.com','+86 548 140 8587'),(588,'Meredithe','Canizares','mcanizaresg8@nifty.com','+7 760 764 3543'),(589,'Neille','Blinman','nblinmang9@twitter.com','+55 319 738 7022'),(590,'Renaud','Suerz','rsuerzga@mysql.com','+593 762 918 9283'),(591,'Forester','Elstob','felstobgb@163.com','+63 640 183 9767'),(592,'Rand','Piniur','rpiniurgc@prweb.com','+86 201 544 3084'),(593,'Kristien','Andryunin','kandryuningd@telegraph.co.uk','+86 918 453 9381'),(594,'Lissie','Doag','ldoagge@arstechnica.com','+92 296 274 5244'),(595,'Beniamino','Kerry','bkerrygf@xing.com','+234 163 125 3697'),(596,'Emelyne','Pacitti','epacittigg@discuz.net','+62 165 598 9944'),(597,'Humfried','Warrior','hwarriorgh@seesaa.net','+53 414 469 4917'),(598,'Allissa','De Domenico','adedomenicogi@fema.gov','+374 942 730 1113'),(599,'Rois','Ragless','rraglessgj@addthis.com','+81 738 591 8195'),(600,'Jeana','Crumpton','jcrumptongk@tripadvisor.com','+7 208 846 6059'),(601,'Laurene','Lyndon','llyndongl@tamu.edu','+680 893 824 0667'),(602,'Locke','Olliffe','lolliffegm@mysql.com','+86 563 725 4386'),(603,'Renelle','Truggian','rtruggiangn@sakura.ne.jp','+66 270 568 5041'),(604,'Penelopa','Fincken','pfinckengo@army.mil','+54 996 423 4204'),(605,'Zackariah','Nassie','znassiegp@cbslocal.com','+7 868 179 7363'),(606,'Marthe','Liddicoat','mliddicoatgq@dot.gov','+353 874 411 8813'),(607,'Aridatha','Steffans','asteffansgr@mapy.cz','+48 241 686 2849'),(608,'Niki','Gage','ngagegs@github.io','+27 378 561 2013'),(609,'Lynelle','Pharoah','lpharoahgt@dyndns.org','+86 856 308 8242'),(610,'Costa','Cowtherd','ccowtherdgu@cpanel.net','+86 794 269 1134'),(611,'Gaylor','Kuhle','gkuhlegv@list-manage.com','+86 121 941 8297'),(612,'Chaim','Aberdeen','caberdeengw@cnet.com','+62 868 569 3775'),(613,'Lara','Gotcliff','lgotcliffgx@newsvine.com','+385 913 734 6965'),(614,'Jamaal','Rostern','jrosterngy@multiply.com','+63 158 805 4223'),(615,'Harlan','Follen','hfollengz@moonfruit.com','+48 859 192 9275'),(616,'Hurlee','Saph','hsaphh0@imdb.com','+81 514 870 3841'),(617,'Andrey','Bover','aboverh1@naver.com','+47 940 416 5501'),(618,'Deni','Meadley','dmeadleyh2@hao123.com','+7 201 664 3268'),(619,'Gavrielle','Shapter','gshapterh3@skype.com','+31 349 487 4006'),(620,'Sonya','Hiscoe','shiscoeh4@artisteer.com','+269 334 466 4923'),(621,'Elsworth','Dibben','edibbenh5@vinaora.com','+212 864 852 4522'),(622,'Jaimie','Greenset','jgreenseth6@merriam-webster.com','+53 738 883 6837'),(623,'Letisha','Chanson','lchansonh7@wix.com','+51 567 397 1832'),(624,'Charisse','Roll','crollh8@nps.gov','+7 801 523 2519'),(625,'Yehudi','Gingel','ygingelh9@delicious.com','+62 333 965 5546'),(626,'Siffre','Wedgwood','swedgwoodha@jiathis.com','+86 895 457 9173'),(627,'Rancell','Dymoke','rdymokehb@youku.com','+46 799 153 7300'),(628,'Cordy','Skillett','cskilletthc@yahoo.com','+51 293 762 3998'),(629,'Emanuel','Clashe','eclashehd@mtv.com','+33 409 283 6530'),(630,'Dulcea','Schafer','dschaferhe@bing.com','+47 583 914 5623'),(631,'Arley','Pringour','apringourhf@walmart.com','+48 825 371 6527'),(632,'Gill','Fatkin','gfatkinhg@cam.ac.uk','+48 281 390 2989'),(633,'Gannie','Fidelli','gfidellihh@nba.com','+505 364 471 7556'),(634,'Marmaduke','Thayre','mthayrehi@berkeley.edu','+62 145 724 9299'),(635,'Elton','Forsythe','eforsythehj@nih.gov','+7 581 789 8422'),(636,'Yvor','Humbatch','yhumbatchhk@slideshare.net','+1 801 211 2447'),(637,'Slade','Preator','spreatorhl@tuttocitta.it','+86 297 135 7305'),(638,'Celestyn','Matyugin','cmatyuginhm@devhub.com','+234 795 249 7856'),(639,'Nollie','Fullerlove','nfullerlovehn@kickstarter.com','+62 175 687 6839'),(640,'Steffi','Thrustle','sthrustleho@marketwatch.com','+504 306 248 0964'),(641,'Zora','Jodlkowski','zjodlkowskihp@samsung.com','+1 404 187 2281'),(642,'Merrill','Farmer','mfarmerhq@npr.org','+63 305 670 5121'),(643,'Winnie','Sallnow','wsallnowhr@merriam-webster.com','+1 353 590 6654'),(644,'Monika','Candwell','mcandwellhs@salon.com','+86 757 322 3493'),(645,'Cicily','Billington','cbillingtonht@huffingtonpost.com','+48 377 387 3538'),(646,'Tiff','Blumire','tblumirehu@pen.io','+353 531 652 8495'),(647,'Malvin','Falls','mfallshv@engadget.com','+86 457 285 9562'),(648,'Estele','Rubra','erubrahw@patch.com','+1 637 837 8321'),(649,'Gerri','Poundsford','gpoundsfordhx@list-manage.com','+63 536 151 4152'),(650,'Scarface','Westwick','swestwickhy@noaa.gov','+86 846 567 2547'),(651,'Jamima','Goves','jgoveshz@gravatar.com','+84 876 342 6981'),(652,'Steffie','Plastow','splastowi0@odnoklassniki.ru','+351 489 727 0082'),(653,'Marie-jeanne','Fryd','mfrydi1@t-online.de','+81 861 569 0571'),(654,'Jessie','Megroff','jmegroffi2@sogou.com','+57 283 334 2574'),(655,'Georgette','Pietranek','gpietraneki3@upenn.edu','+1 214 435 0986'),(656,'Catha','Balk','cbalki4@ycombinator.com','+1 772 600 9097'),(657,'Virginia','Bourgourd','vbourgourdi5@posterous.com','+86 661 943 7299'),(658,'Lizzy','Northwood','lnorthwoodi6@odnoklassniki.ru','+48 328 850 8505'),(659,'Miguelita','Blitz','mblitzi7@typepad.com','+86 211 158 1871'),(660,'Helaine','Radolf','hradolfi8@wix.com','+216 590 991 4136'),(661,'Angelita','Skeermer','askeermeri9@geocities.com','+55 518 505 1500'),(662,'Rowen','Stolworthy','rstolworthyia@nsw.gov.au','+54 467 712 7937'),(663,'Erhard','Haglington','ehaglingtonib@businessweek.com','+86 926 749 4673'),(664,'Leigh','Diplock','ldiplockic@slideshare.net','+886 825 136 4597'),(665,'Jaclyn','Balint','jbalintid@aboutads.info','+86 150 787 8767'),(666,'Bale','Sprull','bsprullie@exblog.jp','+998 790 531 7170'),(667,'Rosmunda','Rapp','rrappif@shutterfly.com','+62 696 437 7886'),(668,'Bernadina','Andri','bandriig@usnews.com','+56 137 477 9000'),(669,'Rhys','Vinnick','rvinnickih@nps.gov','+63 132 373 9734'),(670,'Hew','Canto','hcantoii@scribd.com','+62 394 483 4998'),(671,'Raphaela','Cartledge','rcartledgeij@columbia.edu','+66 403 918 3131'),(672,'Andy','Maddicks','amaddicksik@blogtalkradio.com','+7 578 360 1135'),(673,'Rees','Hellikes','rhellikesil@de.vu','+51 700 328 3267'),(674,'Vevay','Amberger','vambergerim@g.co','+7 800 218 8228'),(675,'Michael','Ibarra','mibarrain@wix.com','+62 275 381 6013'),(676,'Diane','Beteriss','dbeterissio@tiny.cc','+86 892 407 0419'),(677,'Raul','Kuzemka','rkuzemkaip@desdev.cn','+81 184 144 7797'),(678,'Grata','Kanter','gkanteriq@vimeo.com','+55 403 406 0747'),(679,'Cedric','Anyene','canyeneir@engadget.com','+62 128 782 2469'),(680,'Sheela','Wilhelmy','swilhelmyis@ucoz.ru','+63 381 906 6271'),(681,'Lou','Addie','laddieit@multiply.com','+7 595 127 7500'),(682,'Vanya','Gallico','vgallicoiu@berkeley.edu','+86 787 897 5068'),(683,'Wolfie','Culpin','wculpiniv@webnode.com','+62 804 501 2242'),(684,'Constantina','Kupker','ckupkeriw@jiathis.com','+48 573 156 7978'),(685,'Brittney','Fideler','bfidelerix@paginegialle.it','+1 432 444 7840'),(686,'Ruthanne','Cosgrove','rcosgroveiy@acquirethisname.com','+48 982 436 5035'),(687,'Demetria','Welford','dwelfordiz@fastcompany.com','+62 988 812 3507'),(688,'Kristan','Juckes','kjuckesj0@flickr.com','+86 428 828 4455'),(689,'Eve','Risley','erisleyj1@gov.uk','+63 559 860 0689'),(690,'Staffard','Brimblecombe','sbrimblecombej2@liveinternet.ru','+86 534 817 7224'),(691,'Catie','Spritt','csprittj3@spiegel.de','+55 953 244 8046'),(692,'Yolanda','O\'Luby','yolubyj4@reference.com','+238 469 686 5287'),(693,'Farlie','Devereux','fdevereuxj5@amazon.com','+66 381 858 1802'),(694,'Beverley','Birden','bbirdenj6@scientificamerican.com','+970 850 403 5683'),(695,'Lucina','Beaton','lbeatonj7@un.org','+972 926 411 9143'),(696,'Ceil','Empson','cempsonj8@blogger.com','+86 906 272 6988'),(697,'Elias','Teodorski','eteodorskij9@java.com','+976 223 606 5793'),(698,'Noami','Hambatch','nhambatchja@sciencedaily.com','+47 858 296 6242'),(699,'Denise','Castelletti','dcastellettijb@un.org','+62 323 227 1993'),(700,'Sebastien','Francesc','sfrancescjc@fc2.com','+670 345 419 2936'),(701,'Austin','Strewther','astrewtherjd@google.com','+251 412 549 2323'),(702,'Iorgo','Ingrey','iingreyje@irs.gov','+63 342 691 6516'),(703,'Lynnet','Thrussell','lthrusselljf@is.gd','+86 896 122 7189'),(704,'Matthus','Bowkett','mbowkettjg@qq.com','+994 993 983 2042'),(705,'Izabel','Bulfoot','ibulfootjh@acquirethisname.com','+225 509 687 5418'),(706,'Webster','Hanssmann','whanssmannji@kickstarter.com','+54 919 158 5881'),(707,'Hilary','Sanzio','hsanziojj@gov.uk','+86 951 802 0796'),(708,'Stanislaw','Lidgard','slidgardjk@google.it','+7 508 397 6186'),(709,'Meriel','Hurley','mhurleyjl@sakura.ne.jp','+86 144 375 8565'),(710,'Koo','Creer','kcreerjm@nature.com','+33 619 485 8513'),(711,'Cull','Salling','csallingjn@slideshare.net','+86 537 875 9759'),(712,'Bess','Zecchinii','bzecchiniijo@nbcnews.com','+81 938 723 5828'),(713,'Florian','Lighterness','flighternessjp@sfgate.com','+506 271 851 5164'),(714,'Hermy','Manes','hmanesjq@technorati.com','+371 618 953 3571'),(715,'Tymothy','Sappson','tsappsonjr@loc.gov','+51 426 847 1156'),(716,'Jacques','Ros','jrosjs@google.de','+55 838 237 5367'),(717,'Nikki','Gelly','ngellyjt@google.com.hk','+373 795 573 0386'),(718,'Jenda','Lago','jlagoju@php.net','+7 455 210 3511'),(719,'Meade','Leggatt','mleggattjv@about.com','+86 963 249 9261'),(720,'Lilian','Hornung','lhornungjw@uol.com.br','+98 456 943 1557'),(721,'Symon','Farrey','sfarreyjx@paginegialle.it','+81 112 214 6386'),(722,'Noble','O\'Doohaine','nodoohainejy@deviantart.com','+62 824 333 0943'),(723,'Kiel','Drewe','kdrewejz@geocities.com','+221 188 466 2180'),(724,'Grissel','Peeke','gpeekek0@go.com','+420 984 150 0327'),(725,'Homere','Pragnell','hpragnellk1@noaa.gov','+86 519 328 4526'),(726,'Maddalena','Gillfillan','mgillfillank2@example.com','+66 776 166 1571'),(727,'Rossie','Skewis','rskewisk3@odnoklassniki.ru','+33 143 317 9126'),(728,'Sharron','Polendine','spolendinek4@newyorker.com','+81 246 555 7921'),(729,'Samara','Kenion','skenionk5@youku.com','+86 431 584 8690'),(730,'Margaretta','Luberti','mlubertik6@seesaa.net','+86 240 476 3733'),(731,'Dru','Menis','dmenisk7@icq.com','+94 484 866 4739'),(732,'Katharyn','Schapiro','kschapirok8@businesswire.com','+62 773 555 8404'),(733,'Mylo','Cranch','mcranchk9@google.ca','+86 975 743 9036'),(734,'Dacy','Seckington','dseckingtonka@dagondesign.com','+504 642 900 3822'),(735,'Patrice','Froude','pfroudekb@yolasite.com','+62 259 809 4903'),(736,'Arlette','Osment','aosmentkc@gizmodo.com','+33 142 286 0752'),(737,'Bernardine','Beardow','bbeardowkd@sohu.com','+64 549 166 7405'),(738,'Auria','Brandrick','abrandrickke@geocities.jp','+7 633 321 4221'),(739,'Rolfe','Itzkovsky','ritzkovskykf@cdbaby.com','+52 480 424 1477'),(740,'Leigh','Tuff','ltuffkg@thetimes.co.uk','+691 281 452 1203'),(741,'Ham','Benitti','hbenittikh@pbs.org','+62 178 452 6067'),(742,'Kelsey','Seagood','kseagoodki@youtube.com','+63 196 626 8696'),(743,'Christian','Lampkin','clampkinkj@cdbaby.com','+55 654 381 4453'),(744,'Cybil','Skellen','cskellenkk@ucsd.edu','+57 361 313 2831'),(745,'Claresta','Canty','ccantykl@google.com.au','+86 326 583 5183'),(746,'Amanda','Vannacci','avannaccikm@yahoo.com','+1 214 607 6601'),(747,'Julienne','Saggs','jsaggskn@ucsd.edu','+297 683 754 1239'),(748,'Arvin','Lopez','alopezko@pinterest.com','+380 215 199 5350'),(749,'Saundra','Stathor','sstathorkp@cisco.com','+86 464 715 7322'),(750,'Antons','Attack','aattackkq@over-blog.com','+55 589 672 8611'),(751,'Brooke','Bernon','bbernonkr@simplemachines.org','+63 610 139 4073'),(752,'Magnum','Filipchikov','mfilipchikovks@bravesites.com','+237 579 471 7799'),(753,'Nannie','Libby','nlibbykt@freewebs.com','+7 730 770 2807'),(754,'Walther','Ferre','wferreku@lycos.com','+62 712 685 5962'),(755,'Ruby','Horstead','rhorsteadkv@timesonline.co.uk','+62 303 463 4956'),(756,'Meriel','Northeast','mnortheastkw@eepurl.com','+86 184 446 7247'),(757,'Goldie','Nana','gnanakx@nifty.com','+33 732 729 1486'),(758,'Netta','Saltern','nsalternky@cmu.edu','+229 119 158 9756'),(759,'Chip','Mongin','cmonginkz@devhub.com','+378 316 580 0905'),(760,'Gaynor','Dymock','gdymockl0@baidu.com','+86 334 480 5967'),(761,'Rebeka','MacGauhy','rmacgauhyl1@surveymonkey.com','+57 898 863 7493'),(762,'Jamima','Palombi','jpalombil2@studiopress.com','+380 999 824 0994'),(763,'Roseann','Eberz','reberzl3@economist.com','+504 865 211 9202'),(764,'Lethia','Grent','lgrentl4@umn.edu','+48 703 570 4290'),(765,'Crissie','Burdoun','cburdounl5@qq.com','+86 794 353 3090'),(766,'Andra','Glayzer','aglayzerl6@edublogs.org','+7 805 647 2331'),(767,'Alphard','Rawson','arawsonl7@sitemeter.com','+48 834 342 8805'),(768,'Adriano','Tapenden','atapendenl8@msn.com','+420 104 676 6892'),(769,'Penny','Deary','pdearyl9@zimbio.com','+389 502 392 5460'),(770,'Georgetta','Kirwin','gkirwinla@privacy.gov.au','+507 300 625 5510'),(771,'Hilda','Ebanks','hebankslb@jiathis.com','+692 476 678 3045'),(772,'Caresse','Casely','ccaselylc@uiuc.edu','+86 147 863 1393'),(773,'Warde','Mablestone','wmablestoneld@smugmug.com','+1 801 848 0966'),(774,'Wye','Gallacher','wgallacherle@yahoo.com','+420 200 600 0411'),(775,'Torrin','Leveritt','tleverittlf@imageshack.us','+55 287 888 8657'),(776,'Davine','Tewkesberry','dtewkesberrylg@fastcompany.com','+7 585 158 5252'),(777,'Yankee','Enriques','yenriqueslh@parallels.com','+57 452 714 6834'),(778,'Evie','Hardwidge','ehardwidgeli@symantec.com','+420 928 377 9138'),(779,'Matthaeus','MacVicar','mmacvicarlj@over-blog.com','+381 734 467 0024'),(780,'Court','Rowter','crowterlk@printfriendly.com','+63 914 365 6005'),(781,'Gregg','Chidlow','gchidlowll@shutterfly.com','+54 951 176 6895'),(782,'Ingrim','Ginman','iginmanlm@telegraph.co.uk','+57 995 520 0375'),(783,'Murvyn','Rait','mraitln@un.org','+242 545 507 7974'),(784,'Kaitlynn','Wield','kwieldlo@xing.com','+86 784 581 0462'),(785,'Gerrilee','Strover','gstroverlp@discuz.net','+502 692 936 4620'),(786,'Jorgan','Ropp','jropplq@opensource.org','+595 579 584 8696'),(787,'Wade','Paike','wpaikelr@home.pl','+63 919 734 0690'),(788,'Coreen','Heeley','cheeleyls@illinois.edu','+7 244 270 6184'),(789,'Winifield','Fowell','wfowelllt@nbcnews.com','+351 226 345 2686'),(790,'Ardys','Trewett','atrewettlu@netscape.com','+86 738 376 7376'),(791,'Mada','McKmurrie','mmckmurrielv@sciencedaily.com','+386 540 371 8902'),(792,'Vernon','Liffey','vliffeylw@barnesandnoble.com','+57 374 449 4323'),(793,'Kassia','Nunnerley','knunnerleylx@drupal.org','+46 584 136 3578'),(794,'Tiffany','Tatters','ttattersly@wikia.com','+66 824 658 1136'),(795,'Cindi','O\'Connolly','coconnollylz@japanpost.jp','+81 648 558 8263'),(796,'Olivette','Heinzel','oheinzelm0@nasa.gov','+66 763 988 3051'),(797,'Clyde','Pittwood','cpittwoodm1@disqus.com','+86 183 542 8757'),(798,'Shirline','Reinmar','sreinmarm2@cam.ac.uk','+48 104 449 9316'),(799,'Claudianus','Blaydes','cblaydesm3@usda.gov','+33 555 643 4753'),(800,'Malinda','Andreaccio','mandreacciom4@boston.com','+353 714 642 0284'),(801,'Antonietta','Pedler','apedlerm5@soup.io','+86 848 199 3756'),(802,'Saunder','Harken','sharkenm6@stumbleupon.com','+66 343 636 4781'),(803,'Deeanne','Overal','doveralm7@examiner.com','+86 176 107 7077'),(804,'Elmore','Caspell','ecaspellm8@yelp.com','+27 875 303 1966'),(805,'Hobart','Chidzoy','hchidzoym9@prweb.com','+86 918 583 9065'),(806,'Gilemette','Capper','gcapperma@merriam-webster.com','+212 203 618 2072'),(807,'Arlana','Glowach','aglowachmb@bbc.co.uk','+963 529 763 9804'),(808,'Georgie','Weatherburn','gweatherburnmc@examiner.com','+46 813 803 8357'),(809,'Malvina','Halcro','mhalcromd@merriam-webster.com','+93 990 674 5832'),(810,'Harriott','Bertomier','hbertomierme@acquirethisname.com','+86 218 600 6054'),(811,'Nolly','Swatridge','nswatridgemf@ask.com','+92 634 687 8789'),(812,'Inez','Rochford','irochfordmg@ox.ac.uk','+86 576 505 0679'),(813,'Sapphire','Wong','swongmh@opera.com','+1 794 625 1020'),(814,'Cash','Sommers','csommersmi@rediff.com','+420 485 772 6962'),(815,'Audy','Plitz','aplitzmj@ftc.gov','+7 152 399 5016'),(816,'Ozzie','Banck','obanckmk@lycos.com','+1 602 712 7739'),(817,'Jada','Northleigh','jnorthleighml@acquirethisname.com','+86 856 506 5033'),(818,'Estel','Costelow','ecostelowmm@cnn.com','+51 565 268 1249'),(819,'Paulie','Recher','prechermn@omniture.com','+7 797 692 8463'),(820,'Rosana','Brettor','rbrettormo@youku.com','+7 614 119 6315'),(821,'Sybil','Acedo','sacedomp@smugmug.com','+51 336 618 8858'),(822,'Noelle','Seldner','nseldnermq@jimdo.com','+33 650 886 4314'),(823,'Jacquie','Ishchenko','jishchenkomr@cloudflare.com','+255 247 934 8442'),(824,'Nico','Skene','nskenems@blogger.com','+66 653 422 9925'),(825,'Malina','Brecknall','mbrecknallmt@acquirethisname.com','+86 357 692 6151'),(826,'Webb','Riseborough','wriseboroughmu@cnet.com','+7 175 988 8385'),(827,'Hyacinthe','Gladhill','hgladhillmv@angelfire.com','+54 393 692 8207'),(828,'Alessandro','Gillopp','agilloppmw@utexas.edu','+62 256 836 2329'),(829,'Deane','Krabbe','dkrabbemx@ebay.com','+380 822 532 6199'),(830,'Karla','Stickford','kstickfordmy@jimdo.com','+86 962 209 8530'),(831,'Fedora','Howkins','fhowkinsmz@nps.gov','+86 197 157 7783'),(832,'Isa','Mohun','imohunn0@nps.gov','+86 401 865 5985'),(833,'Olivie','Danell','odanelln1@goo.ne.jp','+385 493 151 1115'),(834,'Hermann','Nyssens','hnyssensn2@xrea.com','+420 616 933 8129'),(835,'Filmore','Killeley','fkilleleyn3@ed.gov','+81 624 161 5521'),(836,'Berti','Lansdown','blansdownn4@patch.com','+692 366 998 3312'),(837,'Madison','Kingzet','mkingzetn5@stumbleupon.com','+86 350 980 7582'),(838,'Jacquette','Deery','jdeeryn6@quantcast.com','+44 330 981 7626'),(839,'Dodi','Fursse','dfurssen7@multiply.com','+86 133 436 7718'),(840,'Alphonse','Adney','aadneyn8@netscape.com','+30 118 565 1457'),(841,'Nevil','Winsiowiecki','nwinsiowieckin9@issuu.com','+86 937 567 1601'),(842,'Skyler','Halford','shalfordna@webeden.co.uk','+351 625 513 0936'),(843,'Vevay','Spoors','vspoorsnb@abc.net.au','+33 855 562 2239'),(844,'Libbie','Toms','ltomsnc@wordpress.com','+1 251 212 0454'),(845,'Ronica','Benneton','rbennetonnd@google.fr','+33 344 653 9759'),(846,'Sasha','Corkell','scorkellne@dyndns.org','+54 875 445 6886'),(847,'Ira','Voss','ivossnf@creativecommons.org','+86 799 856 5937'),(848,'Jaymie','Carvell','jcarvellng@google.it','+48 573 243 5347'),(849,'Kelley','Catterell','kcatterellnh@csmonitor.com','+63 750 775 5964'),(850,'Gnni','Cussins','gcussinsni@goodreads.com','+351 613 481 2640'),(851,'Tamqrah','Tincknell','ttincknellnj@livejournal.com','+86 868 366 9261'),(852,'Delbert','Wigmore','dwigmorenk@ifeng.com','+86 334 623 7085'),(853,'Leigh','Rivaland','lrivalandnl@163.com','+358 660 806 1953'),(854,'Sherlocke','Rosenzwig','srosenzwignm@blogger.com','+86 793 401 2945'),(855,'Benny','Spaunton','bspauntonnn@unc.edu','+84 345 574 5920'),(856,'Grata','Exposito','gexpositono@shinystat.com','+212 643 741 1222'),(857,'Durante','Kirk','dkirknp@ft.com','+86 506 733 5343'),(858,'Hedvige','Kilgrew','hkilgrewnq@bloomberg.com','+371 117 915 0087'),(859,'Chickie','O\'Keaveny','cokeavenynr@liveinternet.ru','+598 856 120 5703'),(860,'Randee','Chatwin','rchatwinns@engadget.com','+86 960 926 5929'),(861,'Sephira','Beals','sbealsnt@jigsy.com','+380 357 603 2388'),(862,'Blondelle','Foulsham','bfoulshamnu@google.de','+383 832 273 3057'),(863,'Arlyn','Kobpac','akobpacnv@chron.com','+670 786 663 3125'),(864,'Ginger','Crew','gcrewnw@example.com','+86 996 926 2390'),(865,'Oberon','Marryatt','omarryattnx@mediafire.com','+33 251 908 1067'),(866,'Rhody','Rate','rrateny@altervista.org','+62 561 273 8874'),(867,'Catherin','Chandler','cchandlernz@cbsnews.com','+55 485 303 8093'),(868,'Garfield','Richardes','grichardeso0@smugmug.com','+63 572 584 7029'),(869,'Janifer','Kleint','jkleinto1@icq.com','+33 477 952 9276'),(870,'Ilise','Siverns','isivernso2@wikispaces.com','+86 573 758 7000'),(871,'Ernie','Bolens','ebolenso3@cpanel.net','+7 160 527 2475'),(872,'Jamey','Sim','jsimo4@chronoengine.com','+48 141 140 5023'),(873,'Myranda','Fillon','mfillono5@4shared.com','+63 998 259 1640'),(874,'Cole','Nussii','cnussiio6@irs.gov','+62 800 155 5092'),(875,'Kari','Mussard','kmussardo7@google.co.uk','+33 214 887 3396'),(876,'Cam','Dudney','cdudneyo8@hibu.com','+62 377 643 8355'),(877,'Justina','Jennison','jjennisono9@bing.com','+62 750 588 6550'),(878,'Tracey','Rustman','trustmanoa@dagondesign.com','+62 162 866 4963'),(879,'Felice','Hedan','fhedanob@craigslist.org','+57 571 557 9292'),(880,'Stillman','Hallex','shallexoc@google.nl','+389 542 747 5636'),(881,'Daile','Fretwell','dfretwellod@blogs.com','+46 294 486 8012'),(882,'Blaire','Cocozza','bcocozzaoe@sitemeter.com','+86 983 586 7735'),(883,'Hetty','Fancet','hfancetof@miibeian.gov.cn','+86 184 510 4945'),(884,'Suzi','Keyzor','skeyzorog@engadget.com','+30 944 357 2405'),(885,'Marquita','Cattermull','mcattermulloh@imageshack.us','+33 224 970 0423'),(886,'Nan','Sibery','nsiberyoi@yellowpages.com','+92 137 722 4057'),(887,'Garrick','Breeds','gbreedsoj@utexas.edu','+81 437 989 5551'),(888,'Nananne','Pepall','npepallok@ning.com','+54 486 404 3679'),(889,'Edita','Fernando','efernandool@nba.com','+62 986 415 4629'),(890,'Eleni','Vellender','evellenderom@g.co','+62 546 498 5706'),(891,'Andonis','McSaul','amcsaulon@vk.com','+420 337 788 2982'),(892,'Bard','Puleston','bpulestonoo@etsy.com','+57 355 910 4078'),(893,'Cathy','Davenhall','cdavenhallop@unesco.org','+86 281 749 8381'),(894,'Basile','Freda','bfredaoq@goo.ne.jp','+33 562 186 6718'),(895,'Collete','O\'Reilly','coreillyor@bluehost.com','+86 566 934 0818'),(896,'Sinclare','Pawle','spawleos@behance.net','+62 848 930 1133'),(897,'Adelaide','Weson','awesonot@nationalgeographic.com','+505 161 898 5403'),(898,'Adham','Henniger','ahennigerou@dailymail.co.uk','+86 859 248 1015'),(899,'Ariel','Whelband','awhelbandov@exblog.jp','+375 108 485 3708'),(900,'Norrie','Oley','noleyow@baidu.com','+46 512 682 1673'),(901,'Jessee','Sudran','jsudranox@unc.edu','+86 165 986 3910'),(902,'Alastair','Lain','alainoy@cpanel.net','+62 113 785 2717'),(903,'Curtice','Fawthorpe','cfawthorpeoz@yellowbook.com','+380 964 323 2729'),(904,'Wilbert','Danjoie','wdanjoiep0@yellowbook.com','+51 820 702 8991'),(905,'Sergei','Jerams','sjeramsp1@vkontakte.ru','+502 696 972 8219'),(906,'Tabitha','Viner','tvinerp2@twitpic.com','+46 359 242 8000'),(907,'Finley','Wenn','fwennp3@hao123.com','+54 565 999 6282'),(908,'Breanne','Atwell','batwellp4@canalblog.com','+86 374 462 8722'),(909,'Traci','Cypler','tcyplerp5@multiply.com','+86 570 571 3055'),(910,'Chaddy','Elegood','celegoodp6@aboutads.info','+234 869 361 9100'),(911,'Kat','Ilyenko','kilyenkop7@reddit.com','+57 421 933 5384'),(912,'Xavier','Hammelberg','xhammelbergp8@arstechnica.com','+86 643 910 7387'),(913,'Aretha','Bosden','abosdenp9@bloglovin.com','+1 573 223 5856'),(914,'Deerdre','Madre','dmadrepa@pinterest.com','+1 535 230 4742'),(915,'Anderea','Crispin','acrispinpb@about.me','+1 772 947 9215'),(916,'Derwin','Surby','dsurbypc@foxnews.com','+55 593 427 4605'),(917,'Flss','Caffin','fcaffinpd@bbb.org','+62 173 245 9767'),(918,'Rebecca','Leborgne','rleborgnepe@scribd.com','+52 185 797 0190'),(919,'Barny','Sargint','bsargintpf@163.com','+1 214 432 7128'),(920,'June','Rignold','jrignoldpg@springer.com','+7 472 166 8329'),(921,'Nealon','Dallinder','ndallinderph@toplist.cz','+255 911 545 6276'),(922,'Jethro','Kirwin','jkirwinpi@npr.org','+670 980 502 4029'),(923,'Melonie','Morcomb','mmorcombpj@i2i.jp','+250 139 587 9232'),(924,'Waiter','Learmonth','wlearmonthpk@networksolutions.com','+1 805 659 1417'),(925,'Addy','Whitelaw','awhitelawpl@zdnet.com','+48 275 462 1993'),(926,'Elwira','Vampouille','evampouillepm@columbia.edu','+53 241 547 2742'),(927,'Gil','Carneck','gcarneckpn@squidoo.com','+86 901 473 8930'),(928,'Glynn','Christopherson','gchristophersonpo@mapquest.com','+62 999 863 3759'),(929,'Terrence','Pedlingham','tpedlinghampp@blinklist.com','+34 128 774 6526'),(930,'Giuditta','Guymer','gguymerpq@bloglovin.com','+7 495 352 9791'),(931,'Lincoln','Lavers','llaverspr@hud.gov','+63 743 895 0785'),(932,'Alonzo','McCurdy','amccurdyps@cisco.com','+86 589 150 8346'),(933,'Mathew','Filippov','mfilippovpt@exblog.jp','+7 421 996 1606'),(934,'Bengt','Montier','bmontierpu@ibm.com','+63 355 624 0628'),(935,'Bev','Gibberd','bgibberdpv@google.fr','+1 610 747 9725'),(936,'Gayleen','Sant','gsantpw@canalblog.com','+63 628 614 3377'),(937,'Oliviero','Northway','onorthwaypx@ucla.edu','+86 849 712 3981'),(938,'Nicolas','Tollmache','ntollmachepy@economist.com','+7 182 774 9824'),(939,'Mureil','Faust','mfaustpz@globo.com','+33 431 181 1871'),(940,'Paten','Waby','pwabyq0@dion.ne.jp','+256 110 684 5769'),(941,'Donall','Castana','dcastanaq1@dell.com','+58 766 556 4919'),(942,'Cross','Frere','cfrereq2@prnewswire.com','+86 469 328 4184'),(943,'Greg','Paz','gpazq3@indiegogo.com','+593 892 284 1968'),(944,'Averell','McMaster','amcmasterq4@mac.com','+84 640 671 4642'),(945,'Wylie','Rosenau','wrosenauq5@vimeo.com','+30 486 275 4143'),(946,'Dunstan','McGilbon','dmcgilbonq6@bing.com','+381 647 691 0583'),(947,'Sherwynd','Craigie','scraigieq7@amazon.de','+62 537 517 3092'),(948,'Sybille','De Dantesie','sdedantesieq8@google.co.uk','+81 998 717 6138'),(949,'Lindsey','Godfree','lgodfreeq9@cafepress.com','+60 386 233 4091'),(950,'Doe','Barbe','dbarbeqa@ox.ac.uk','+86 683 336 2488'),(951,'Dani','Palfreeman','dpalfreemanqb@delicious.com','+380 973 418 3948'),(952,'Sim','Provost','sprovostqc@webeden.co.uk','+62 721 919 4652'),(953,'Othilia','Davson','odavsonqd@addthis.com','+86 916 905 7345'),(954,'Lacie','Fairn','lfairnqe@wsj.com','+351 616 905 8148'),(955,'Ciro','McLoughlin','cmcloughlinqf@indiegogo.com','+351 190 721 5962'),(956,'Godart','Lincke','glinckeqg@hubpages.com','+62 527 197 6212'),(957,'Evangelina','Gillinghams','egillinghamsqh@amazonaws.com','+62 161 398 8303'),(958,'Allen','Vance','avanceqi@ocn.ne.jp','+374 999 855 1155'),(959,'Codie','Pavlovic','cpavlovicqj@shinystat.com','+98 246 888 3189'),(960,'Estrellita','Shills','eshillsqk@vinaora.com','+970 815 468 3885'),(961,'Cletis','Woodyear','cwoodyearql@slashdot.org','+7 667 289 5204'),(962,'Dosi','Waghorne','dwaghorneqm@hugedomains.com','+62 681 222 9896'),(963,'Daisi','Yalden','dyaldenqn@usda.gov','+86 379 221 1604'),(964,'Prentice','McKeachie','pmckeachieqo@free.fr','+62 286 737 5362'),(965,'Cristin','Riceards','criceardsqp@google.cn','+54 698 603 1764'),(966,'Carmelita','Scarce','cscarceqq@cargocollective.com','+46 445 995 5921'),(967,'Heindrick','Henriques','hhenriquesqr@seattletimes.com','+63 927 388 7388'),(968,'Elfrida','Eastcourt','eeastcourtqs@constantcontact.com','+62 577 145 3808'),(969,'Chrissy','Parry','cparryqt@unicef.org','+62 697 855 8554'),(970,'Correna','Charity','ccharityqu@unicef.org','+86 469 676 1451'),(971,'Siana','Merry','smerryqv@oaic.gov.au','+48 976 910 5503'),(972,'Karina','Churcher','kchurcherqw@google.com.br','+992 932 169 1953'),(973,'Amelia','O\'Kielt','aokieltqx@mit.edu','+57 779 308 6075'),(974,'Ariana','Medforth','amedforthqy@google.co.jp','+86 937 683 2786'),(975,'Efrem','Freiberg','efreibergqz@samsung.com','+7 362 355 3094'),(976,'Harper','Wathey','hwatheyr0@nationalgeographic.com','+1 646 283 2345'),(977,'Anna-maria','Himsworth','ahimsworthr1@seattletimes.com','+51 267 338 1958'),(978,'Denni','McCathay','dmccathayr2@usatoday.com','+62 314 716 2824'),(979,'Tiffie','Beckhouse','tbeckhouser3@army.mil','+86 874 706 1735'),(980,'Temp','Ciccone','tcicconer4@github.com','+57 165 956 2786'),(981,'Kaila','Gumbrell','kgumbrellr5@deviantart.com','+265 824 213 3863'),(982,'Damiano','Olman','dolmanr6@usda.gov','+7 919 363 4438'),(983,'Ardeen','Elen','aelenr7@histats.com','+86 832 766 5733'),(984,'Sean','Louthe','slouther8@cdc.gov','+86 613 286 2895'),(985,'Lorenzo','Wakelam','lwakelamr9@sakura.ne.jp','+7 466 647 7976'),(986,'Felice','Pattle','fpattlera@elegantthemes.com','+55 670 268 6086'),(987,'Elmore','Pudner','epudnerrb@comsenz.com','+420 722 687 1980'),(988,'Delila','Hehnke','dhehnkerc@alexa.com','+7 735 878 8336'),(989,'Bengt','Rime','brimerd@51.la','+92 244 669 4175'),(990,'Nevin','Bowles','nbowlesre@cbc.ca','+1 316 476 0888'),(991,'Beverly','Seedull','bseedullrf@freewebs.com','+351 240 688 9038'),(992,'Ceil','Himpson','chimpsonrg@dmoz.org','+86 459 123 6102'),(993,'Carly','Rispen','crispenrh@psu.edu','+86 240 190 0288'),(994,'Roxi','Harsnep','rharsnepri@tripadvisor.com','+86 595 411 3045'),(995,'Lotta','Leinthall','lleinthallrj@nationalgeographic.com','+62 921 487 1431'),(996,'Marlie','Wookey','mwookeyrk@sbwire.com','+54 644 633 8410'),(997,'Cora','Bortoli','cbortolirl@alexa.com','+7 592 677 5172'),(998,'Filmer','Klazenga','fklazengarm@prnewswire.com','+33 415 255 9034'),(999,'Araldo','Sikorsky','asikorskyrn@skyrock.com','+230 950 280 3411'),(1000,'Lorita','Blaksley','lblaksleyro@artisteer.com','+51 900 900 5704'),(1001,'Ame','Danelutti','adaneluttirp@narod.ru','+7 979 338 7628'),(1002,'Parnell','April','paprilrq@histats.com','+351 471 963 6899'),(1003,'Judas','Fourcade','jfourcaderr@pen.io','+86 180 796 1710');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_roles`
--

DROP TABLE IF EXISTS `usuarios_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_roles` (
  `id_usuario` int NOT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_roles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `usuarios_roles_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_roles`
--

LOCK TABLES `usuarios_roles` WRITE;
/*!40000 ALTER TABLE `usuarios_roles` DISABLE KEYS */;
INSERT INTO `usuarios_roles` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `usuarios_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `usuarios_y_roles`
--

DROP TABLE IF EXISTS `usuarios_y_roles`;
/*!50001 DROP VIEW IF EXISTS `usuarios_y_roles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usuarios_y_roles` AS SELECT 
 1 AS `id_usuario`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `nombre_rol`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `valoraciones`
--

DROP TABLE IF EXISTS `valoraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valoraciones` (
  `id_valoracion` int NOT NULL AUTO_INCREMENT,
  `id_funcion` int NOT NULL,
  `id_usuario` int NOT NULL,
  `puntuacion` int NOT NULL,
  `comentario` text,
  `fecha_valoracion` datetime NOT NULL,
  PRIMARY KEY (`id_valoracion`),
  KEY `id_funcion` (`id_funcion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`id_funcion`) REFERENCES `funciones` (`id_funcion`),
  CONSTRAINT `valoraciones_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `valoraciones_chk_1` CHECK (((`puntuacion` >= 1) and (`puntuacion` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valoraciones`
--

LOCK TABLES `valoraciones` WRITE;
/*!40000 ALTER TABLE `valoraciones` DISABLE KEYS */;
INSERT INTO `valoraciones` VALUES (1,1,1,5,'Excelente espectáculo, me encantó!','2025-02-10 22:00:00'),(2,2,2,4,'Muy buena actuación, aunque la historia me pareció lenta','2025-02-15 23:00:00'),(3,3,3,5,'Un show maravilloso, muy recomendable!','2025-03-01 21:00:00'),(4,1,1,5,'Este es un comentario de prueba','2025-01-28 20:43:30');
/*!40000 ALTER TABLE `valoraciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'teatro'
--

--
-- Dumping routines for database 'teatro'
--
/*!50003 DROP FUNCTION IF EXISTS `total_entradas_vendidas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_entradas_vendidas`(id_funcion INT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM entradas
    WHERE id_funcion = id_funcion;
    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_ingresos_funcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_ingresos_funcion`(id_funcion INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(precio) INTO total
    FROM entradas
    WHERE id_funcion = id_funcion;
    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `realizar_pago_y_generar_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `realizar_pago_y_generar_entrada`(
    IN id_funcion INT,
    IN monto DECIMAL(10,2),
    IN email_usuario VARCHAR(100),
    IN id_metodo_pago INT
)
BEGIN
    -- Declaración de variables al inicio del bloque BEGIN
    DECLARE usuario_id INT;
    DECLARE id_entrada INT;
    DECLARE fecha_pago DATETIME;
    DECLARE metodo_pago_valido INT;

    -- Obtener la fecha y hora actuales
    SET fecha_pago = NOW();

    -- Verificar que el id_metodo_pago sea válido
    SELECT COUNT(*) INTO metodo_pago_valido
    FROM metodos_de_pago
    WHERE id_metodo_pago = id_metodo_pago;

    IF metodo_pago_valido = 0 THEN
        SELECT '[fallo] ALGO FALLÓ: MÉTODO DE PAGO NO VÁLIDO' AS msg;
        ROLLBACK;
    END IF;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Verificar si el email proporcionado es válido
    SELECT id_usuario INTO usuario_id
    FROM teatro.usuarios
    WHERE email = email_usuario;

    IF usuario_id IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: EMAIL DEL USUARIO NO VÁLIDO' AS msg;
        ROLLBACK;

    END IF;

    -- Crear la entrada asociada al pago (se inserta primero)
    INSERT INTO teatro.entradas (id_funcion, id_usuario, precio, fecha_compra)
    VALUES (id_funcion, usuario_id, monto, fecha_pago);

    -- Obtener el id_entrada generado
    SET id_entrada = LAST_INSERT_ID();

    -- Verificar que el id_entrada haya sido generado correctamente
    IF id_entrada IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: ERROR AL GENERAR LA ENTRADA' AS msg;
        ROLLBACK;
    END IF;

    -- Realizar el pago (insertar el pago asociando el id_entrada)
    INSERT INTO teatro.pagos (id_entrada, monto, fecha_pago, id_metodo_pago)
    VALUES (id_entrada, monto, fecha_pago, id_metodo_pago);

    -- Confirmar la transacción
    SELECT '[éxito] SUCESS: PAGO EXITOSO' AS msg;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_valoracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_valoracion`(
    IN email_usuario VARCHAR(100),
    IN id_funcion INT,
    IN puntuacion INT,
    IN comentario TEXT
)
BEGIN
    -- Declaración de variables
    DECLARE usuario_id INT;
    DECLARE fecha_valoracion DATETIME;
    DECLARE comentario_valido BOOLEAN;

    -- Obtener la fecha y hora actuales
    SET fecha_valoracion = NOW();

    -- Validar que la puntuación esté en el rango de 1 a 5
    IF puntuacion < 1 OR puntuacion > 5 THEN
        SELECT '[fallo] ALGO FALLÓ: LA PUNTUACIÓN DEBE SER ENTRE 1 Y 5' AS msg;
    END IF;

    -- Validar que el comentario no exceda los 140 caracteres
    SET comentario_valido = LENGTH(comentario) <= 140;
    IF NOT comentario_valido THEN
        SELECT '[fallo] ALGO FALLÓ: EL COMENTARIO NO PUEDE EXCEDER LOS 140 CARACTERES' AS msg;
    END IF;

    -- Verificar si el email del usuario existe
    SELECT id_usuario INTO usuario_id
    FROM teatro.usuarios
    WHERE email = email_usuario;

    IF usuario_id IS NULL THEN
        SELECT '[fallo] ALGO FALLÓ: USUARIO CON ESE EMAIL NO ENCONTRADO' AS msg;
    END IF;

    -- Insertar la valoración en la tabla
    INSERT INTO teatro.valoraciones (id_funcion, id_usuario, puntuacion, comentario, fecha_valoracion)
    VALUES (id_funcion, usuario_id, puntuacion, comentario, fecha_valoracion);

    -- Mensaje de éxito
    SELECT '[éxito] SUCESS: VALORACIÓN REGISTRADA EXITOSAMENTE' AS msg;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `entradas_compradas`
--

/*!50001 DROP VIEW IF EXISTS `entradas_compradas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `entradas_compradas` AS select `e`.`id_entrada` AS `id_entrada`,`e`.`precio` AS `precio`,`e`.`fecha_compra` AS `fecha_compra`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido`,`es`.`titulo` AS `titulo` from (((`entradas` `e` join `usuarios` `u` on((`e`.`id_usuario` = `u`.`id_usuario`))) join `funciones` `f` on((`e`.`id_funcion` = `f`.`id_funcion`))) join `espectaculos` `es` on((`f`.`id_espectaculo` = `es`.`id_espectaculo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `facturas_detalle`
--

/*!50001 DROP VIEW IF EXISTS `facturas_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `facturas_detalle` AS select `f`.`id_factura` AS `id_factura`,`f`.`monto` AS `monto`,`f`.`fecha_factura` AS `fecha_factura`,`e`.`id_entrada` AS `id_entrada`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido` from ((`facturas` `f` join `entradas` `e` on((`f`.`id_entrada` = `e`.`id_entrada`))) join `usuarios` `u` on((`e`.`id_usuario` = `u`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `historial_funciones_view`
--

/*!50001 DROP VIEW IF EXISTS `historial_funciones_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `historial_funciones_view` AS select `h`.`id_historial` AS `id_historial`,`h`.`accion` AS `accion`,`h`.`fecha_accion` AS `fecha_accion`,`f`.`id_funcion` AS `id_funcion`,`es`.`titulo` AS `titulo` from ((`historial_funciones` `h` join `funciones` `f` on((`h`.`id_funcion` = `f`.`id_funcion`))) join `espectaculos` `es` on((`f`.`id_espectaculo` = `es`.`id_espectaculo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pagos_detalle`
--

/*!50001 DROP VIEW IF EXISTS `pagos_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pagos_detalle` AS select `p`.`id_pago` AS `id_pago`,`p`.`monto` AS `monto`,`p`.`fecha_pago` AS `fecha_pago`,`e`.`id_entrada` AS `id_entrada`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido` from ((`pagos` `p` join `entradas` `e` on((`p`.`id_entrada` = `e`.`id_entrada`))) join `usuarios` `u` on((`e`.`id_usuario` = `u`.`id_usuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usuarios_y_roles`
--

/*!50001 DROP VIEW IF EXISTS `usuarios_y_roles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usuarios_y_roles` AS select `u`.`id_usuario` AS `id_usuario`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido`,`r`.`nombre_rol` AS `nombre_rol` from ((`usuarios` `u` join `usuarios_roles` `ur` on((`u`.`id_usuario` = `ur`.`id_usuario`))) join `roles` `r` on((`ur`.`id_rol` = `r`.`id_rol`))) */;
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

-- Dump completed on 2025-01-28 20:46:43

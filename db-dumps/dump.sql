-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: wortspiel
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.24.04.2

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
-- Table structure for table `SPRING_SESSION`
--

DROP TABLE IF EXISTS `SPRING_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SPRING_SESSION` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPRING_SESSION`
--

LOCK TABLES `SPRING_SESSION` WRITE;
/*!40000 ALTER TABLE `SPRING_SESSION` DISABLE KEYS */;
INSERT INTO `SPRING_SESSION` VALUES ('0a608334-932b-4084-a29b-e2c8892e8234','c6e7783f-21ad-4e8e-b7fb-a8a58362c9dd',1722543319548,1722543530614,2592000,1725135530614,'kohanania2510@gmail.com'),('4712dfd9-8810-43cd-8d3b-7fbd65795a37','3ec79063-311f-4dcc-8203-82181e7238a7',1724743494655,1724830974217,2592000,1727422974217,'katyshev.yevhen@gmail.com');
/*!40000 ALTER TABLE `SPRING_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SPRING_SESSION_ATTRIBUTES`
--

DROP TABLE IF EXISTS `SPRING_SESSION_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SPRING_SESSION_ATTRIBUTES` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `SPRING_SESSION` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPRING_SESSION_ATTRIBUTES`
--

LOCK TABLES `SPRING_SESSION_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `SPRING_SESSION_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `SPRING_SESSION_ATTRIBUTES` VALUES ('0a608334-932b-4084-a29b-e2c8892e8234','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$7c29a588-584f-43eb-b6c9-804328d80bd9'),('0a608334-932b-4084-a29b-e2c8892e8234','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^\�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0	ROLE_USERxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\0\r192.168.0.166t\0$fab3d18b-0fc7-49dd-a3f0-6c1e32728ee3psr\0%com.stigg.lernwortspiel.enteties.User\������\0Z\0isAccountNonExpiredZ\0isAccountNonLockedZ\0isCredentialsNonExpiredZ\0	isEnabledL\0birthDayt\0Ljava/time/LocalDate;L\0emailq\0~\0L\0	firstNameq\0~\0L\0idt\0Ljava/util/UUID;L\0lastNameq\0~\0L\0passwordq\0~\0L\0phoneNumberq\0~\0L\0rolest\0Ljava/util/Set;xpsr\0\rjava.time.Ser�]��\"H�\0\0xpw\0\0\�xt\0kohanania2510@gmail.comt\0Аннаsr\0java.util.UUID��\��m�/\0J\0leastSigBitsJ\0mostSigBitsxp���\�P\�ET�F\�\r2Jpt\0Кохан t\0<$2a$10$8huFzBECOgdHTk1.XX/7eObXXHDK2nuoDGxGBxixWuNsbgtbG9ol.t\0	+49365289sr\0*org.hibernate.collection.spi.PersistentSet��Ɨ�\�k\0L\0setq\0~\0xr\09org.hibernate.collection.spi.AbstractPersistentCollection3��J<\�F\0Z\0allowLoadOutsideTransactionI\0\ncachedSizeZ\0dirtyZ\0elementRemovedZ\0initializedZ\0\risTempSessionL\0keyq\0~\0L\0ownerq\0~\0L\0roleq\0~\0L\0sessionFactoryUuidq\0~\0L\0storedSnapshott\0Ljava/io/Serializable;xp\0����\0\0\0q\0~\0 q\0~\0\Zt\0+com.stigg.lernwortspiel.enteties.User.rolespsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0sr\0%com.stigg.lernwortspiel.enteties.Role\�\�\�\�\�\�\0L\0idq\0~\0L\0nameq\0~\0L\0usersq\0~\0xpsq\0~\0��r\�Fiw\�!+�I\�I�q\0~\0sq\0~\0$\0����\0\0\0\0q\0~\0-q\0~\0,t\0+com.stigg.lernwortspiel.enteties.Role.userspppq\0~\0,xsr\0java.util.HashSet�D�����4\0\0xpw\0\0\0?@\0\0\0\0\0q\0~\0,x'),('4712dfd9-8810-43cd-8d3b-7fbd65795a37','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$fa55bac3-633b-4681-96f0-bda426cc83ae'),('4712dfd9-8810-43cd-8d3b-7fbd65795a37','SPRING_SECURITY_CONTEXT',_binary '�\�\0sr\0=org.springframework.security.core.context.SecurityContextImpl\0\0\0\0\0\0l\0L\0authenticationt\02Lorg/springframework/security/core/Authentication;xpsr\0Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\0\0\0\0\0\0l\0L\0credentialst\0Ljava/lang/Object;L\0	principalq\0~\0xr\0Gorg.springframework.security.authentication.AbstractAuthenticationTokenӪ(~nGd\0Z\0\rauthenticatedL\0authoritiest\0Ljava/util/Collection;L\0detailsq\0~\0xpsr\0&java.util.Collections$UnmodifiableList�%1�\�\0L\0listt\0Ljava/util/List;xr\0,java.util.Collections$UnmodifiableCollectionB\0�\�^\�\0L\0cq\0~\0xpsr\0java.util.ArrayListx�\��\�a�\0I\0sizexp\0\0\0w\0\0\0sr\0Borg.springframework.security.core.authority.SimpleGrantedAuthority\0\0\0\0\0\0l\0L\0rolet\0Ljava/lang/String;xpt\0\nROLE_ADMINsq\0~\0t\0	ROLE_USERxq\0~\0\rsr\0Horg.springframework.security.web.authentication.WebAuthenticationDetails\0\0\0\0\0\0l\0L\0\rremoteAddressq\0~\0L\0	sessionIdq\0~\0xpt\00:0:0:0:0:0:0:1t\0$e279d407-1aec-4635-883c-354b4cf0233dpsr\0%com.stigg.lernwortspiel.enteties.User\������\0Z\0isAccountNonExpiredZ\0isAccountNonLockedZ\0isCredentialsNonExpiredZ\0	isEnabledL\0birthDayt\0Ljava/time/LocalDate;L\0emailq\0~\0L\0	firstNameq\0~\0L\0idt\0Ljava/util/UUID;L\0lastNameq\0~\0L\0passwordq\0~\0L\0phoneNumberq\0~\0L\0rolest\0Ljava/util/Set;xpsr\0\rjava.time.Ser�]��\"H�\0\0xpw\0\0\�xt\0katyshev.yevhen@gmail.comt\0Yevhensr\0java.util.UUID��\��m�/\0J\0leastSigBitsJ\0mostSigBitsxp�K�\�\�<[\�\�\�\�]ILt\0Katyshevt\0<$2a$10$NvBirD9TCz3/f.jd5Q9breAOZsiRIfGBHTqdwRs/FFcBZRy0wO1LKt\0\r+380680595514sr\0*org.hibernate.collection.spi.PersistentSet��Ɨ�\�k\0L\0setq\0~\0xr\09org.hibernate.collection.spi.AbstractPersistentCollection3��J<\�F\0Z\0allowLoadOutsideTransactionI\0\ncachedSizeZ\0dirtyZ\0elementRemovedZ\0initializedZ\0\risTempSessionL\0keyq\0~\0L\0ownerq\0~\0L\0roleq\0~\0L\0sessionFactoryUuidq\0~\0L\0storedSnapshott\0Ljava/io/Serializable;xp\0����\0\0\0q\0~\0\"q\0~\0t\0+com.stigg.lernwortspiel.enteties.User.rolespsr\0java.util.HashMap\��\�`\�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0sr\0%com.stigg.lernwortspiel.enteties.Role\�\�\�\�\�\�\0L\0idq\0~\0\ZL\0nameq\0~\0L\0usersq\0~\0xpsq\0~\0!�)��\�]\�c\�\���\�L�q\0~\0sq\0~\0&\0����\0\0\0\0q\0~\0/q\0~\0.t\0+com.stigg.lernwortspiel.enteties.Role.userspppq\0~\0.sq\0~\0-sq\0~\0!�d�+SW�/96\�zA�q\0~\0sq\0~\0&\0����\0\0\0\0q\0~\03q\0~\02q\0~\01pppq\0~\02xsr\0java.util.HashSet�D�����4\0\0xpw\0\0\0?@\0\0\0\0\0q\0~\0.q\0~\02x');
/*!40000 ALTER TABLE `SPRING_SESSION_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `title` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKg0286ag1dlt4473st1ugemd0m` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (_binary '�Ƥ���D��\�\��=T','2024-08-26 09:10:35.112060','FOKUS DEUTSCH B2');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_confirmation_token`
--

DROP TABLE IF EXISTS `email_confirmation_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_confirmation_token` (
  `id` binary(16) NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKs88xsr4dc97qxxs46aafsxnt6` (`user_id`),
  CONSTRAINT `FK1nn2s9fe9dn1ive1wd0y99utv` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_confirmation_token`
--

LOCK TABLES `email_confirmation_token` WRITE;
/*!40000 ALTER TABLE `email_confirmation_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_confirmation_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` binary(16) NOT NULL,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK8sewwnpamngi6b1dwaa88askk` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (_binary '\�\���\�L��)��\�]\�c','ROLE_ADMIN'),(_binary '96\�zA��d�+SW�/','ROLE_USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `name` varchar(40) NOT NULL,
  `topic_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1luo5llot7ehfv52iucchaadr` (`topic_id`),
  CONSTRAINT `FK1luo5llot7ehfv52iucchaadr` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (_binary 'k\�H�oH��\��\�\�\�\�','2024-08-26 09:30:50.077548','A. Materialien beschaffen',_binary '\��f\�Bm��C\�%i�m'),(_binary 'њ�M#nLs�ʱo�\�','2024-08-27 08:32:49.510217','B. Start',_binary '\��f\�Bm��C\�%i�m');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `name` varchar(40) NOT NULL,
  `book_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfdgsdqw0a293dn0fxlbwei2b4` (`book_id`),
  CONSTRAINT `FKfdgsdqw0a293dn0fxlbwei2b4` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (_binary '\��f\�Bm��C\�%i�m','2024-08-26 09:30:11.180494','8. Auftragsabwicklung',_binary '�Ƥ���D��\�\��=T');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` binary(16) NOT NULL,
  `birth_day` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `is_account_non_expired` bit(1) NOT NULL,
  `is_account_non_locked` bit(1) NOT NULL,
  `is_credentials_non_expired` bit(1) NOT NULL,
  `is_enabled` bit(1) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (_binary '�\�\�\�]IL�K�\�\�<[\�','1997-02-28','katyshev.yevhen@gmail.com','Yevhen',_binary '',_binary '',_binary '',_binary '','Katyshev','$2a$10$NvBirD9TCz3/f.jd5Q9breAOZsiRIfGBHTqdwRs/FFcBZRy0wO1LK','+380680595514'),(_binary '�~\�D��r�cT\�\�\�','2009-02-11','tonkit@ukr.net','Anna',_binary '',_binary '',_binary '',_binary '','Kohan','$2a$10$4fWFv2cuRRlfFpyKwzaDLO5z3lKZLsY9IAHsI2/gyYkNdWHtwlEVe','+4912343241324');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_roles` (
  `user_id` binary(16) NOT NULL,
  `role_id` binary(16) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  CONSTRAINT `FK2o0jvgh89lemvvo17cbqvdxaa` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (_binary '�\�\�\�]IL�K�\�\�<[\�',_binary '96\�zA��d�+SW�/'),(_binary '�~\�D��r�cT\�\�\�',_binary '96\�zA��d�+SW�/'),(_binary '�\�\�\�]IL�K�\�\�<[\�',_binary '\�\���\�L��)��\�]\�c');
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `type` enum('ADJECTIVE','NOUN','TRENNBARES_VERB','VERB') NOT NULL,
  `word` varchar(40) NOT NULL,
  `word_translate` varchar(80) NOT NULL,
  `section_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpbikpx7tdaiwhih5aky879axd` (`section_id`),
  CONSTRAINT `FKpbikpx7tdaiwhih5aky879axd` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (_binary '`�i\�\"M}�H*�֓B','2024-08-26 19:49:51.288588','NOUN','Konkurrenzdruck','давление конкуренции',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '̟�� NE�]�ϓI�g','2024-08-26 18:15:35.689226','NOUN','Beschaffungsmarkt','рынок закупки сырья и материалов',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '� ��BAq�)\n�\�nL,','2024-08-26 19:38:07.259248','NOUN','Gartengerät','садо́вый инструме́нт',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�97�#Lb�\�\�`\0BvP','2024-08-26 20:04:08.524057','NOUN','Rohmaterial','сырьё',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\Z\�=K@\Z�z\�H�\Z�\�','2024-08-26 18:37:40.321084','TRENNBARES_VERB','einkalkulieren','предусматривать, брать в расчёт',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\Z�kc��A���$ط','2024-08-26 17:38:54.716164','TRENNBARES_VERB','abwägen','взвешивать (обдумывать)',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\"l	xڱK��P�I�Y','2024-08-26 19:55:28.042692','NOUN','Material','материал',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '&\�\�\Z�%O\�0\�9D�\�','2024-08-26 17:49:41.830150','ADJECTIVE','Beachtung schenken','обращать внимание',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '5����Iw�$\�\�.�\�U','2024-08-26 09:32:15.875950','NOUN','Ablauf','Ход, течение (событий, поцесса)',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '5ł�ݍ@\�\�H\�6\�P\�','2024-08-26 20:06:10.170728','VERB','sorgen für','заботиться, беспокоиться о',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '6{�\�\0�M����hB�','2024-08-26 20:40:06.035750','ADJECTIVE','vertraut sein mit','быть знакомым с ',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary ';���?-@K������\�','2024-08-26 18:28:12.114862','NOUN','Einfluss','влия́ние, возде́йствие',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '>�\�\�GE�\�絔�I','2024-08-26 18:30:15.690880','ADJECTIVE','Einfluss haben auf','иметь влияние на',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'G\\n6�H��dY�\��U�','2024-08-26 18:45:16.545488','ADJECTIVE','erforderlich','необходимый, требуемый',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'Q�N/�sL��\�\�$�\��','2024-08-26 18:48:52.804473','NOUN','Fertighaus','сборный дом(из готовых частей)',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'R\�?&EH�d�\�C�','2024-08-26 17:46:53.589867','NOUN','Baustoff','строительный материал',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'V��@\�NK��{\�\�gbG','2024-08-26 20:08:51.085774','NOUN','Steuerbüro','налоговое бюро',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\\~lm�aF�\��2\Z��M','2024-08-26 19:57:01.047830','NOUN','Menge','большо́е коли́чество, мно́жество, толпа́',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary ']=��Kʫ\n\�\�	','2024-08-26 18:13:34.992906','NOUN','Beschaffung',' приобретение, загото́вка',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'c�_e\0Df�\�\0)�$','2024-08-26 19:54:44.195496','ADJECTIVE','massiv','массивный',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'f9\�\�\�\�C���Qi07','2024-08-27 11:58:24.271203','NOUN','Ablauf','ход, течение событий',_binary 'њ�M#nLs�ʱo�\�'),(_binary 'o+W.�uLא��8#��\�','2024-08-26 17:53:54.406180','VERB','benötigen','нуждаться',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'w;=\��C��\�fj�\�V','2024-08-26 19:41:14.070392','NOUN','Globalisierung','глобализация',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary 'w�� ��E@���\�\\E}9','2024-08-26 17:44:49.428955','NOUN','Auftragsabwicklung','обработка заказа',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '}΍Y\�Nu�[5�ˉ !','2024-08-26 18:27:02.630874','NOUN','CAD-Programm','программа проэктирования',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '~G���UDO�mM�6��-','2024-08-26 19:38:56.659137','ADJECTIVE','geeignet','пригодный, подходящий',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '�scA[A��3\�\��\�	�','2024-08-26 19:52:10.045665','NOUN','Lagerkapazität','вместимость склада',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '�~~�=�I}�L;y�\�\�','2024-08-26 19:40:29.259719','ADJECTIVE','global','всеобщий, глобальный',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '��Yߋ\�D���I\�\�sx','2024-08-26 19:46:05.919743','NOUN','Gut','благо, благополучие',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '��\�3�FU��\�9I)�z','2024-08-26 18:47:03.464260','NOUN','Fachmesse','специализированая ярмарка',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '�`\�\�TF\�\��I�g�','2024-08-26 20:10:06.114622','NOUN','Umweltpolitik','политика охраны окружающей среды',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '��@B��I�6�r��','2024-08-26 18:25:24.695636','NOUN','Bestandsaufnahme','инвентаризация',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '�a���B��ԛ=��','2024-08-26 18:51:44.416884','NOUN','Fertighausfirma','фирма по производству сборных домов',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '�0?SG\�Hʩ�!>�','2024-08-26 20:40:37.531184','NOUN','Zeichentisch','чертёжный стол',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�\"*,\�C��\0��\�\"','2024-08-26 18:11:36.907368','VERB','beschaffen','заготавливать, раздобывать',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�!�4�-F\�1��\��','2024-08-26 17:56:00.177678','VERB','berücksichtigen','принять во внимание',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�\�\�\�eB@��k@2G','2024-08-26 20:42:12.396595','NOUN','Zollbestimmung','таможенное регулирование',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�[��Y�N>��\�7�l�','2024-08-26 17:41:52.648485','NOUN','Aspekt','аспект',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\��ن\�@B�S�7uw4K','2024-08-26 19:54:14.638255','NOUN','Liefersicherheit','безопастность доставки',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '\�~\�@=F:���\Z�[W','2024-08-26 17:40:32.520935','NOUN','Arbeitsbedingung','условие работы',_binary 'k\�H�oH��\��\�\�\�\�'),(_binary '������J��~&z���','2024-08-26 20:00:18.185348','NOUN','Produktionsunterbrechung','временное прекращение производственного процесса',_binary 'k\�H�oH��\��\�\�\�\�');
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_adjective`
--

DROP TABLE IF EXISTS `word_adjective`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_adjective` (
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKlmmfxq5dfxa042lmu5ftndm26` FOREIGN KEY (`id`) REFERENCES `word` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_adjective`
--

LOCK TABLES `word_adjective` WRITE;
/*!40000 ALTER TABLE `word_adjective` DISABLE KEYS */;
INSERT INTO `word_adjective` VALUES (_binary '&\�\�\Z�%O\�0\�9D�\�'),(_binary '6{�\�\0�M����hB�'),(_binary '>�\�\�GE�\�絔�I'),(_binary 'G\\n6�H��dY�\��U�'),(_binary 'c�_e\0Df�\�\0)�$'),(_binary '~G���UDO�mM�6��-'),(_binary '�~~�=�I}�L;y�\�\�');
/*!40000 ALTER TABLE `word_adjective` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_noun`
--

DROP TABLE IF EXISTS `word_noun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_noun` (
  `article` varchar(255) DEFAULT NULL,
  `plural_form` varchar(255) DEFAULT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK5tuxu8pds71eeya77dfmyt9kn` FOREIGN KEY (`id`) REFERENCES `word` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_noun`
--

LOCK TABLES `word_noun` WRITE;
/*!40000 ALTER TABLE `word_noun` DISABLE KEYS */;
INSERT INTO `word_noun` VALUES ('der','Konkurrenzdruckes',_binary '`�i\�\"M}�H*�֓B'),('der','Beschaffungsmärkte',_binary '̟�� NE�]�ϓI�g'),('das','Gartengeräte',_binary '� ��BAq�)\n�\�nL,'),('das','Rohmaterialien',_binary '\�97�#Lb�\�\�`\0BvP'),('das','Materialien',_binary '\"l	xڱK��P�I�Y'),('der','Abläufe',_binary '5����Iw�$\�\�.�\�U'),('der','Einflüsse',_binary ';���?-@K������\�'),('das','Fertighäuser',_binary 'Q�N/�sL��\�\�$�\��'),('der','Baustoffe',_binary 'R\�?&EH�d�\�C�'),('das','Steuerbüros',_binary 'V��@\�NK��{\�\�gbG'),('die','Mengen',_binary '\\~lm�aF�\��2\Z��M'),('die','Beschaffungen',_binary ']=��Kʫ\n\�\�	'),('der','Abläufe',_binary 'f9\�\�\�\�C���Qi07'),('die','Globalisierungen',_binary 'w;=\��C��\�fj�\�V'),('die','Auftragsabwicklungen',_binary 'w�� ��E@���\�\\E}9'),('das','CAD-Programme',_binary '}΍Y\�Nu�[5�ˉ !'),('die','Lagerkapazitäten',_binary '�scA[A��3\�\��\�	�'),('das','Güter',_binary '��Yߋ\�D���I\�\�sx'),('die','Fachmessen',_binary '��\�3�FU��\�9I)�z'),('die','-',_binary '�`\�\�TF\�\��I�g�'),('die','Bestandsaufnahmen',_binary '��@B��I�6�r��'),('die','Fertighausfirmen',_binary '�a���B��ԛ=��'),('der','Zeichentische',_binary '�0?SG\�Hʩ�!>�'),('die','Zollbestimmungen',_binary '\�\�\�\�eB@��k@2G'),('der','Aspekte',_binary '\�[��Y�N>��\�7�l�'),('die','-',_binary '\��ن\�@B�S�7uw4K'),('die','Arbeitsbedingungen',_binary '\�~\�@=F:���\Z�[W'),('die','Produktionsunterbrechungen',_binary '������J��~&z���');
/*!40000 ALTER TABLE `word_noun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_trennbares_verb`
--

DROP TABLE IF EXISTS `word_trennbares_verb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_trennbares_verb` (
  `prefix` varchar(10) NOT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKcuynphwdb33vn59yg7l8ibrjc` FOREIGN KEY (`id`) REFERENCES `word_verb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_trennbares_verb`
--

LOCK TABLES `word_trennbares_verb` WRITE;
/*!40000 ALTER TABLE `word_trennbares_verb` DISABLE KEYS */;
INSERT INTO `word_trennbares_verb` VALUES ('ein',_binary '\Z\�=K@\Z�z\�H�\Z�\�'),('ab',_binary '\Z�kc��A���$ط');
/*!40000 ALTER TABLE `word_trennbares_verb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_verb`
--

DROP TABLE IF EXISTS `word_verb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_verb` (
  `hilf_verb_vergangenheit` varchar(255) DEFAULT NULL,
  `perfect_form` varchar(255) DEFAULT NULL,
  `prataritum_form` varchar(255) DEFAULT NULL,
  `third_person_form` varchar(255) DEFAULT NULL,
  `verb_type` enum('REGELMASIG','UNREGELMASIG') NOT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKby50xo0y5xhbyaqkwisqmgi2x` FOREIGN KEY (`id`) REFERENCES `word` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_verb`
--

LOCK TABLES `word_verb` WRITE;
/*!40000 ALTER TABLE `word_verb` DISABLE KEYS */;
INSERT INTO `word_verb` VALUES ('hat','einkalkuliert','kalkulierte ein','kalkuliert ein','REGELMASIG',_binary '\Z\�=K@\Z�z\�H�\Z�\�'),('hat','abgewogen','wägte ab','wägt ab','UNREGELMASIG',_binary '\Z�kc��A���$ط'),('hat','gesorgt','sorgte','sorgt','REGELMASIG',_binary '5ł�ݍ@\�\�H\�6\�P\�'),('hat','benötigt','benötigte','benötigt','REGELMASIG',_binary 'o+W.�uLא��8#��\�'),('hat','beschafft','beschaffte','beschafft','REGELMASIG',_binary '\�\"*,\�C��\0��\�\"'),('hat','berücksichtigt','berücksichtigte','berücksichtigt','REGELMASIG',_binary '\�!�4�-F\�1��\��');
/*!40000 ALTER TABLE `word_verb` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-28 18:37:57

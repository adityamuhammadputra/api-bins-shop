-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: bins
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.2-MariaDB

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
-- Table structure for table `asset_statuses`
--

DROP TABLE IF EXISTS `asset_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `desc_email` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_statuses`
--

LOCK TABLES `asset_statuses` WRITE;
/*!40000 ALTER TABLE `asset_statuses` DISABLE KEYS */;
INSERT INTO `asset_statuses` VALUES (1,'Menunggu Pembayaran','Pemesanan kamu berhasil, menunggu pembayaran','Pemesanan kamu berhasil, menunggu pembayaran'),(2,'Pembayaran Berhasil','Pesanan kamu sedang diproses, dan akan dihubungi oleh admin','Pesanan kamu sedang diproses, dan akan dihubungi oleh admin'),(3,'Pesanan Dikirim','Pesanan sudah dikirim oleh admin, estimasi 6 jam otomatis berhasil','Pesanan sudah dikirim oleh admin, estimasi 6 jam otomatis berhasil'),(4,'Pesanan Selesai','Pesanan berhasil dan sudah diterima oleh pembeli','Pesanan berhasil dan sudah diterima oleh pembeli'),(9,'Pengajuan Refund','Pembeli membatalkan transaksi dan mengajukan pengembalian dana','Kamu membatalkan transaksi dan mengajukan pengembalian dana'),(10,'Refund Selesai','Pengembalian dana berhasil diverifikasi, silahkan hubungi admin untuk lebih lanjut','Pengembalian dana berhasil diverifikasi, silahkan hubungi admin untuk lebih lanjut'),(11,'Batal Pembayaran','Pembayaran gagal, pembeli tidak melakukan pembayaran 1 x 24 jam','Pesanan kamu batal, kamu tidak melakukan pembayaran 1 x 24 jam'),(12,'Pesanan Batal','Pembeli membatalkan transaksi','Kamu membatalkan transaksi');
/*!40000 ALTER TABLE `asset_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_tutorials`
--

DROP TABLE IF EXISTS `asset_tutorials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_tutorials` (
  `id` varchar(36) NOT NULL,
  `name` longtext DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `pdf` varchar(199) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_tutorials`
--

LOCK TABLES `asset_tutorials` WRITE;
/*!40000 ALTER TABLE `asset_tutorials` DISABLE KEYS */;
INSERT INTO `asset_tutorials` VALUES ('5cf5006a-f62b-11ed-9d9e-00090faa0021','Windows OS',NULL,NULL,1,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0022','key-19','Key Office 2016, 2019, 2021','key-2016-2019-2021.pdf',2,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0023','kms','Hapus Key KMS /crack','hapus-kms.pdf',6,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0024','365-win','Office 365','akun-365.pdf',3,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0025','key-win','key Windows 10/11',NULL,4,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0026','visio-project','Visio & Project',NULL,5,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0027','MAC OS',NULL,NULL,7,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0028','365-mac','Office 365',NULL,8,NULL,NULL),('5cf5006a-f62b-11ed-9d9e-00090faa0029','16-19-21-mac','Office 2016, 2019, 2021',NULL,9,NULL,NULL);
/*!40000 ALTER TABLE `asset_tutorials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `tax` varchar(10) DEFAULT NULL COMMENT 'persen',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Office','3',NULL,NULL,NULL),(2,'Sistem Operasi','3',NULL,NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charts`
--

DROP TABLE IF EXISTS `charts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charts` (
  `id` varchar(60) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` varchar(60) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charts`
--

LOCK TABLES `charts` WRITE;
/*!40000 ALTER TABLE `charts` DISABLE KEYS */;
INSERT INTO `charts` VALUES ('1231afd0-00b5-11ee-9d7a-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',4,'zxdsassadas',NULL,'2023-06-14 09:44:23','2023-06-11 20:44:23'),('2744d1e4-09a3-11ee-b1d2-00090faa0001',5,'15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',1,NULL,NULL,'2023-06-14 11:31:23','2023-06-13 11:31:23'),('354a4bf4-09a1-11ee-b927-00090faa0001',5,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',1,NULL,NULL,'2023-06-14 11:17:28','2023-06-13 11:17:28'),('8ce87bdc-d293-11ed-85b1-2cf05d5d41d9',6,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',1,NULL,NULL,'2023-06-14 12:44:23','2023-06-11 20:44:23'),('8fe59de2-d293-11ed-b4ab-2cf05d5d41d9',6,'8dbe0722-c4e5-11ed-a2b7-2cf05d5d41d9',1,NULL,NULL,'2023-06-14 10:44:23','2023-06-11 20:44:23'),('a18f2618-1653-11ee-8fae-2cf05d5d41d9',22,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',1,NULL,NULL,'2023-06-29 15:04:54','2023-06-29 15:04:54'),('eee031ba-d291-11ed-a9f2-2cf05d5d41d9',6,'2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9',1,NULL,NULL,'2023-06-14 19:44:23','2023-06-10 20:44:23');
/*!40000 ALTER TABLE `charts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_discussions`
--

DROP TABLE IF EXISTS `product_discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_discussions` (
  `id` varchar(36) NOT NULL,
  `parent` varchar(36) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_discussions`
--

LOCK TABLES `product_discussions` WRITE;
/*!40000 ALTER TABLE `product_discussions` DISABLE KEYS */;
INSERT INTO `product_discussions` VALUES ('09713402-f745-11ed-80b5-2cf05d5d41d9',NULL,5,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','ini ada gk yaa ?','2023-05-21 02:32:20','2023-05-21 02:32:20',NULL),('10923f9a-00ca-11ee-bff2-2cf05d5d41d9','cdbe35fc-00c9-11ee-b94a-2cf05d5d41d9',5,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','yaa oke','2023-06-02 05:17:15','2023-06-02 05:17:15',NULL),('1187d962-f7c1-11ed-9904-2cf05d5d41d9','dfaff6b6-f7b3-11ed-9268-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','bls yg ketiga','2023-05-21 17:20:11','2023-05-21 17:20:11',NULL),('1a76f9fe-f7c1-11ed-9f69-2cf05d5d41d9','dfaff6b6-f7b3-11ed-9268-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','bls lg yg ke 44','2023-05-21 17:20:26','2023-05-21 17:20:26',NULL),('2cc39e2a-0075-11ee-841a-2cf05d5d41d9',NULL,5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','oke bos saya siap','2023-06-01 19:09:35','2023-06-01 19:09:35',NULL),('3884b92a-f7b4-11ed-b06c-2cf05d5d41d9',NULL,5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','oke bos saya akan coba bagian bls','2023-05-21 15:48:13','2023-05-21 15:48:13',NULL),('661445e0-07ae-11ee-9721-2cf05d5d41d9','2cc39e2a-0075-11ee-841a-2cf05d5d41d9',1,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','bisa lanjut dichat yaa kak :)','2023-06-10 23:46:51','2023-06-10 23:46:51',NULL),('6d1db3aa-07bb-11ee-994f-2cf05d5d41d9','f0db35e2-f7ed-11ed-b874-2cf05d5d41d9',1,'11348806-c4e6-11ed-b802-2cf05d5d41d9','silahkan kak monggo dah','2023-06-11 01:20:06','2023-06-11 01:20:06',NULL),('77b32786-07ad-11ee-8a47-2cf05d5d41d9','cdbe35fc-00c9-11ee-b94a-2cf05d5d41d9',1,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','silahkan kak masuk mangga :)','2023-06-10 23:40:11','2023-06-10 23:40:11',NULL),('795f63e0-09a3-11ee-8a7e-00090faa0001','d8901c6c-f7d6-11ed-bfb0-2cf05d5d41d9',5,'15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','tolong di baca yaa kak chatnya :)','2023-06-13 11:33:41','2023-06-13 11:33:41',NULL),('825f0cbe-07bb-11ee-b17a-2cf05d5d41d9','2cc39e2a-0075-11ee-841a-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','oke kak :)','2023-06-11 01:20:42','2023-06-11 01:20:42',NULL),('83b16b88-07ad-11ee-829d-2cf05d5d41d9','ce0579cc-f7ef-11ed-b71d-2cf05d5d41d9',1,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','monggo kak silahkan yaa','2023-06-10 23:40:31','2023-06-10 23:40:31',NULL),('a435d7d2-f7c1-11ed-86e2-2cf05d5d41d9','c12442ec-f7b3-11ed-b046-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','siap kak','2023-05-21 17:24:17','2023-05-21 17:24:17',NULL),('ab11b5d4-f7ef-11ed-ba7e-2cf05d5d41d9','f0db35e2-f7ed-11ed-b874-2cf05d5d41d9',19,'11348806-c4e6-11ed-b802-2cf05d5d41d9','iyaa sama saya juga loh','2023-05-21 22:53:45','2023-05-21 22:53:45',NULL),('b294d1c4-f7ef-11ed-9a62-2cf05d5d41d9',NULL,19,'11348806-c4e6-11ed-b802-2cf05d5d41d9','ini juga ada yaa ?','2023-05-21 22:53:58','2023-05-21 22:53:58',NULL),('b5aa8752-166a-11ee-89fe-2cf05d5d41d9','b294d1c4-f7ef-11ed-9a62-2cf05d5d41d9',1,'11348806-c4e6-11ed-b802-2cf05d5d41d9','ready dong :)','2023-06-29 17:50:06','2023-06-29 17:50:06',NULL),('bf856c04-f7ef-11ed-adf0-2cf05d5d41d9','3884b92a-f7b4-11ed-b06c-2cf05d5d41d9',19,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','dah kita bls ya kak :)','2023-05-21 22:54:20','2023-05-21 22:54:20',NULL),('c12442ec-f7b3-11ed-b046-2cf05d5d41d9',NULL,5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','yaa tolong dikirim secepatnya','2023-05-21 15:44:52','2023-05-21 15:44:52',NULL),('cdbe35fc-00c9-11ee-b94a-2cf05d5d41d9',NULL,20,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','aku masuk sini ah','2023-06-02 05:15:23','2023-06-02 05:15:23',NULL),('ce0579cc-f7ef-11ed-b71d-2cf05d5d41d9',NULL,19,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','ok','2023-05-21 22:54:44','2023-05-21 22:54:44',NULL),('d8901c6c-f7d6-11ed-bfb0-2cf05d5d41d9',NULL,5,'15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','hallo','2023-05-21 19:56:04','2023-05-21 19:56:04',NULL),('dfaff6b6-f7b3-11ed-9268-2cf05d5d41d9',NULL,5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','jika produk ready, tolong kirim segera yaa','2023-05-21 15:45:44','2023-05-21 15:45:44',NULL),('e33243ca-07b2-11ee-86e8-2cf05d5d41d9','d8901c6c-f7d6-11ed-bfb0-2cf05d5d41d9',1,'15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','hallo kak :)','2023-06-11 00:18:59','2023-06-11 00:18:59',NULL),('e8ea51a2-02cd-11ee-b71b-2cf05d5d41d9','2cc39e2a-0075-11ee-841a-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','ok coy','2023-06-04 18:49:49','2023-06-04 18:49:49',NULL),('ecbc4d5c-f743-11ed-a2b8-2cf05d5d41d9',NULL,5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','aah kosong lg yey','2023-05-21 02:24:22','2023-05-21 02:24:22',NULL),('f0db35e2-f7ed-11ed-b874-2cf05d5d41d9',NULL,5,'11348806-c4e6-11ed-b802-2cf05d5d41d9','yaa saya kepo dengan produk ini','2023-05-21 22:41:23','2023-05-21 22:41:23',NULL);
/*!40000 ALTER TABLE `product_discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ratings`
--

DROP TABLE IF EXISTS `product_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_ratings` (
  `id` varchar(36) NOT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `rating` int(5) DEFAULT NULL,
  `desc` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ratings`
--

LOCK TABLES `product_ratings` WRITE;
/*!40000 ALTER TABLE `product_ratings` DISABLE KEYS */;
INSERT INTO `product_ratings` VALUES ('5cf5006a-f62b-11ed-9d9e-00090faa0001','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,'e437e664-e6b8-11ed-b436-2cf05d5d41d9',5,'mayan lah yaa :)','2023-05-19 16:56:02','2023-05-19 16:56:02'),('a1ec5802-fa2d-11ed-a355-00090faa0001','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',5,'oke bos baik sekali mayan lah','2023-05-24 19:22:21','2023-05-24 19:22:21'),('a1ee9b9e-fa2d-11ed-a61a-00090faa0001','89e3010c-c4e5-11ed-a4bf-2cf05d5d41d9',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',5,'oke bos baik sekali mayan lah','2023-05-24 19:22:21','2023-05-24 19:22:21'),('e971907c-f62a-11ed-95aa-00090faa0001','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,'44961200-f4de-11ed-98c6-2cf05d5d41d9',5,'test 123456','2023-05-19 16:52:48','2023-05-19 16:52:48'),('e9724918-f62a-11ed-ae33-00090faa0001','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',5,'44961200-f4de-11ed-98c6-2cf05d5d41d9',5,'test 123456','2023-05-19 16:52:48','2023-05-19 16:52:48'),('e9728824-f62a-11ed-945b-00090faa0001','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,'44961200-f4de-11ed-98c6-2cf05d5d41d9',5,'test 123456','2023-05-19 16:52:48','2023-05-19 16:52:48'),('fb8c8b6e-fe44-11ed-92e9-2cf05d5d41d9','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,'7978795c-fa21-11ed-98b9-00090faa0001',5,'oke deh produk ini','2023-05-30 00:19:34','2023-05-30 00:19:34');
/*!40000 ALTER TABLE `product_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_seens`
--

DROP TABLE IF EXISTS `product_seens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_seens` (
  `id` varchar(36) NOT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_seens`
--

LOCK TABLES `product_seens` WRITE;
/*!40000 ALTER TABLE `product_seens` DISABLE KEYS */;
INSERT INTO `product_seens` VALUES ('03ae94cc-18b2-11ee-b7f7-2cf05d5d41d9','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,'127.0.0.1','2023-07-02 15:25:34','2023-07-02 15:25:34'),('3372e96c-09a1-11ee-9b6b-00090faa0001','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,'127.0.0.1','2023-06-14 00:17:25','2023-06-13 11:17:25'),('3981efdc-094d-11ee-9964-2cf05d5d41d9','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,NULL,'2023-06-14 01:16:17','2023-06-13 01:16:17'),('426c4a80-0901-11ee-b476-00090faa0001','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,NULL,'2023-06-14 16:12:30','2023-06-12 16:12:30'),('5d495d9c-164f-11ee-a544-2cf05d5d41d9','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',NULL,'127.0.0.1','2023-06-29 14:34:21','2023-06-29 14:34:21'),('637de7b6-1652-11ee-9305-2cf05d5d41d9','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',22,'127.0.0.1','2023-06-29 14:56:00','2023-06-29 14:56:00'),('7654676a-158b-11ee-91e5-2cf05d5d41d9','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',NULL,'127.0.0.1','2023-06-28 15:12:02','2023-06-28 15:12:02'),('8d979a7c-1956-11ee-84dc-00090faa0001','8dbe0722-c4e5-11ed-a2b7-2cf05d5d41d9',5,'127.0.0.1','2023-07-03 11:03:22','2023-07-03 11:03:22'),('90c68f84-10f8-11ee-8cbf-00090faa0001','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',22,'127.0.0.1','2023-06-22 19:30:26','2023-06-22 19:30:26'),('a0fce382-1669-11ee-8c1c-2cf05d5d41d9','11348806-c4e6-11ed-b802-2cf05d5d41d9',NULL,'127.0.0.1','2023-06-29 17:42:22','2023-06-29 17:42:22'),('a68f8d4e-098b-11ee-b39d-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',NULL,'127.0.0.1','2023-06-14 19:43:09','2023-06-13 08:43:09'),('b265a6c6-098b-11ee-9a6b-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',5,'127.0.0.1','2023-06-14 08:43:29','2023-06-13 08:43:29'),('ba9f04c4-1654-11ee-a630-2cf05d5d41d9','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,'127.0.0.1','2023-06-29 15:12:45','2023-06-29 15:12:45'),('bcbc2f6c-0915-11ee-b617-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',5,NULL,'2023-06-14 18:39:06','2023-06-12 18:39:06'),('c87febc8-0a86-11ee-b394-00090faa0001','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',5,'127.0.0.1','2023-06-14 14:40:50','2023-06-14 14:40:50'),('d6f5adfa-09a0-11ee-b67f-00090faa0001','b87bbfc0-c41f-11ed-a075-2cf05d5d41d9',5,'127.0.0.1','2023-06-14 11:14:50','2023-06-13 11:14:50'),('dc82efe8-0915-11ee-b4c8-2cf05d5d41c9','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,NULL,'2023-06-14 18:39:59','2023-06-11 18:39:59'),('dc82efe8-0915-11ee-b4c8-2cf05d5d41d9','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',5,NULL,'2023-06-14 18:39:59','2023-06-12 18:39:59'),('e9267a3e-1654-11ee-9385-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9',NULL,'127.0.0.1','2023-06-29 15:14:03','2023-06-29 15:14:03'),('fa57ec1c-111c-11ee-9a00-2cf05d5d41d9','b87bbfc0-c41f-11ed-a075-2cf05d5d41d9',22,'127.0.0.1','2023-06-22 23:51:05','2023-06-22 23:51:05'),('fe516f0e-18b1-11ee-ba0f-2cf05d5d41d9','b87bbfc0-c41f-11ed-a075-2cf05d5d41d9',5,'127.0.0.1','2023-07-02 15:25:25','2023-07-02 15:25:25');
/*!40000 ALTER TABLE `product_seens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` varchar(80) NOT NULL,
  `category_id` varchar(80) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `discount` varchar(3) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `warranty` varchar(2) DEFAULT NULL COMMENT 'bulan',
  `img1` varchar(200) DEFAULT NULL,
  `img2` varchar(200) DEFAULT NULL,
  `img3` varchar(200) DEFAULT NULL,
  `img4` varchar(200) DEFAULT NULL,
  `img5` varchar(200) DEFAULT NULL,
  `sold` int(11) DEFAULT NULL,
  `seen` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `minorder` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(80) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('11348806-c4e6-11ed-b802-2cf05d5d41d9','1','Lisensi Visio 2016 untuk windows','lisensi-visio-2016-untuk-windows',99000,'11',192,'<p><strong>Office Visio 2016 Key Aktivasi Online</strong></p><p>?&nbsp;Pengiriman langsung by email setelah pembayaran berhasil</p><p><br></p><p><strong>Kelebihan</strong></p><p>✔️&nbsp;Aktivasi langsung online tanpa by phone (bukan key bekas)</p><p>Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya</p><p>Support windows 7 s/d windows 11 32/64 bit (pilih salah satu aja saat aktivasi)</p><p>License key bisa re-install atau aman digunakan untuk install ulang tanpa batas (device yang sama)</p><p><br></p><p><strong>Notes</strong></p><p>?&nbsp;1 license Key Hanya untuk 1 device / perangkat / laptop / PC</p><p>Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi</p><p>License original berupa 25 digit (Alpha Numeric)</p><p><br></p>','1',NULL,'884decaa-1669-11ee-b369-2cf05d5d41d9_Microsoft-Visio-Logo-1.png','884faad6-1669-11ee-a898-2cf05d5d41d9__temp2.jpg','',NULL,NULL,3,1,NULL,1,NULL,NULL,'2023-07-01 23:42:43',NULL,NULL),('15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','1','Lisensi Visio 2019','lisensi-visio-2019',99000,'10',100,'<p>berupa Licese k(e)y retail Original retail</p><p><br></p><p>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)</p><p>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC</p><p>- Aktvasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi</p><p>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya</p><p>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)</p><p>- Liense key bisa re-install atau aman digunakan untuk install ulang tanpa batas</p><p><br></p><p><br></p>','1',NULL,'a8d4706e-06f8-11ee-8e23-2cf05d5d41d9__temp1_mail.jpg.png','','',NULL,NULL,3,22,0,1,NULL,NULL,'2023-07-01 23:42:10',NULL,NULL),('26eacaf2-c4e6-11ed-9011-2cf05d5d41d9','1','Lisensi Project 2019','lisensi-project-2019',89000,NULL,199,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2023-05-24 00:42:49',NULL,NULL),('2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9','1','Lisensi Project 2016','lisensi-project-2016',99000,NULL,198,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,'2023-05-28 02:23:22',NULL,NULL),('366b57c8-06f2-11ee-b3ff-2cf05d5d41d9','2','Coba lagi ah edit','coba-lagi-ah-edit',250000,'10',10,'<p>- Produk ini berfisik LISENSI CARD (spt difoto produk) atau LISENSI CARD + DVD</p><p>- barang asli spt difoto, bukan gambar palsu</p><p>- JANGAN GUNAKAN ALAMAT PALSU</p><p>- Gunakan kopun gratis ongkir</p><p>- 1 PRODUK KEY HANYA UNTUK 1 USER W1N10 / W1N 11</p>','0',NULL,'36695a0e-06f2-11ee-a999-2cf05d5d41d9_x.PNG','366b0994-06f2-11ee-878b-2cf05d5d41d9_xx.PNG',NULL,NULL,NULL,NULL,1,100,1,'2023-06-10 01:19:45',NULL,'2023-06-10 15:34:01',NULL,NULL),('67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','1','Lisensi Office 2016 Pro Plus Original','lisensi-office-2016-pro-plus-original',99000,'2',198,'<p>PRODUK FISIK BERUPA DVD INSTALLER SERTA PANDUAN INSTALASI AKAN DIKIRIM KE ALAMAT YANG ANDA CANTUMKAN DAN AKAN DIKIRIM PADA HARI YANG SAMA!!</p><p><br></p><p><br></p><p>MOHON DIBACA DESKRIPSI PRODUK SAMPAI SELESAI !!!</p><p><br></p>','1',NULL,'2016_1.png','2016_2.png','Garansi.jpg',NULL,NULL,5,14,100,1,NULL,NULL,'2023-06-11 21:19:17',NULL,NULL),('81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','1','Lisensi Office 2021 Pro Plus Original','lisensi-office-2021-pro-plus-original',115000,'3',191,'<p>berupa Licese k(e)y retail Original retail</p><p><br></p><p>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)</p><p><br></p><p>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC</p><p><br></p><p>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi</p><p><br></p><p>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya</p><p><br></p><p>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)</p><p><br></p><p>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas</p><p><br></p><p><br></p>','1',NULL,'2021_1.jpg','2021_2.jpg','Garansi.jpg',NULL,NULL,14,25,100,1,NULL,NULL,'2023-06-10 21:01:55',NULL,NULL),('89e3010c-c4e5-11ed-a4bf-2cf05d5d41d9','2','Lisensi Windows 11 Professional Plus','lisensi-windows-11-professional-plus',99000,NULL,198,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,'2023-05-24 01:01:57',NULL,NULL),('8dbe0722-c4e5-11ed-a2b7-2cf05d5d41d9','1','Office 365 Professinal Plus','office-365-professinal-plus',99000,'9.1',198,'<p><strong>berupa Licese k(e)y retail Original retail</strong></p><p>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)</p><p>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC</p><p>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi</p><p>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya</p><p>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)</p><p>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas</p><p><br></p><p><strong>Cara order</strong></p><p><span class=\"ql-cursor\">﻿</span>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas</p><p><br></p><p><br></p>','1',NULL,'365_1.png','365_2.png','Garansi.jpg',NULL,NULL,3,44,1000,1,NULL,NULL,'2023-07-03 10:58:31',NULL,NULL),('b3d7ccc4-0561-11ee-b965-00090faa0001','1','Offices ProPlus 2021 edited','offices-proplus-2021-edited',100000,'',10,'<p><strong>edited by adit ah</strong></p>','0',NULL,'b3d8077a-0561-11ee-9aa6-00090faa0001_banner-backdrop-tv-minimalis.jpg','fd73a18e-06e0-11ee-8a7a-00090faa0001_validation.PNG','fd754ac0-06e0-11ee-8a6a-00090faa0001_4.PNG',NULL,NULL,NULL,36,100,2,'2023-06-08 01:32:48',NULL,'2023-06-10 15:48:55',NULL,NULL),('b87bbfc0-c41f-11ed-a075-2cf05d5d41d9','1','Lisensi Office 2019 Pro Plus Original','lisensi-office-2019-pro-plus-original',109000,'3',200,'PRODUK FISIK BERUPA DVD INSTALLER SERTA PANDUAN INSTALASI AKAN DIKIRIM KE ALAMAT YANG ANDA CANTUMKAN DAN AKAN DIKIRIM PADA HARI YANG SAMA!!<br><br>MOHON DIBACA DESKRIPSI PRODUK SAMPAI SELESAI !!!<br>','1',NULL,'2019_1.png','2019_2.png','Garansi.jpg',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2023-07-01 23:42:00',NULL,NULL),('bb7fa64c-076c-11ee-b437-2cf05d5d41d9','1','Coba product Terakhir Ah','coba-product-terakhir-ah',1000000,'',10,'<p>jadi product Project NIH BOS</p><p><strong>Senggol dong</strong></p>','0',NULL,'bb771130-076c-11ee-a42f-2cf05d5d41d9__temp2.jpg','bb7f78d4-076c-11ee-aef8-2cf05d5d41d9_562eacb6-ad57-4708-ae97-1fc0933fbbcd.png',NULL,NULL,NULL,NULL,31,1000,1,'2023-06-10 15:56:47',NULL,'2023-06-11 00:47:39',NULL,NULL),('e5193598-06f1-11ee-ab93-2cf05d5d41d9','1','Offices ProPlus 2021','offices-proplus-2021',115000,'20',50,'<p>✅ Jangan terkecoh harga murah, tapi validasi masih by phone atau via installation ID. Coba googling sendiri :D</p><p>✅ key premium, aktivasi tanpa by telephone atau via installation ID, bisa langsung by internet (SECARA ONLINE) yang sebenarnya!</p><p>✅ proses sangat cepat dan bisa garansi langsung bisa digunakan</p><p><br></p><p><br></p><p>✅ Product 100% berfisik percis seperti di foto product 1 &amp; 2, dipacking dan dikirim dengan kurir pilihan agan spt gambar 3 !!!!</p><p><br></p><p>CARA ORDER:</p><p>1. PILIH VARIAN</p><p>2. CHECKOUT dan SELESAI</p><p><br></p><p>Jika bingung kami akan bantu instalkan sampai berhasil</p><p><br></p><p>- Produk ini berfisik LISENSI CARD (spt difoto produk) atau LISENSI CARD + DVD</p><p>- barang asli spt difoto, bukan gambar palsu</p><p>- JANGAN GUNAKAN ALAMAT PALSU</p><p>- Gunakan kopun gratis ongkir</p><p>- 1 PRODUK KEY HANYA UNTUK 1 USER W1N10 / W1N 11</p><p><br></p><p><br></p><p>KELEBIHAN PRODUK KAMI:</p><p>1. PROSES SANGAT CEPAT, SETELAH CHECKOUT AKAN LANGSUNG PROSES</p><p>2. SEKALI BAYAR, TIDAK ADA BIAYA BULANAN ALIAS LIFETIME</p><p>3. DIJAMIN LISENSI ORIGINAL BERUPA 25 DIGIT (ALPHA NUMERIC) UNTUK AKTIVASI</p><p>4. AKTIVASI SECARA ONLINE TANPA RIBET HARUS VALIDASI</p><p>5. SUPPORT 32bit dan 64bit</p><p>6. SUPPORT INSTAL ULANG</p><p>7. INSTALLER LANGSUNG DARI SITUS RESMI 0FFICE</p><p>8. RETAIL BUKAN O E M</p><p>9. PERMEN MANIS KAYA KAMU, UNTUK NEMENIN SAMBIL INSTALL :)</p><p><br></p><p>sudah komplit sudah ada semua aplikasi aplikasi 0ffice</p><p><br></p><p>* order banyak bisa nego</p>','1',NULL,'e5175bba-06f1-11ee-a948-2cf05d5d41d9_kitchen_set_minimalis_murah_berkualitas.jpeg','e5190154-06f1-11ee-a8b5-2cf05d5d41d9_4.PNG',NULL,NULL,NULL,NULL,2,100,1,'2023-06-10 01:17:29',NULL,'2023-06-10 15:48:17','2023-06-10 15:48:17','1'),('e6d27e2e-c4e5-11ed-80a7-2cf05d5d41d9','1','Lisensi Office 2019 Home Student','lisensi-office-2019-home-student',99000,NULL,199,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,1,8,NULL,NULL,NULL,NULL,'2023-06-10 15:14:52',NULL,NULL),('e7661e6e-c4e4-11ed-afd6-2cf05d5d41d9','2','Lisensi Windows 10 Professional Plus','lisensi-windows-10-professional-plus',99000,NULL,199,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,NULL,NULL,NULL,'2023-06-10 21:02:12',NULL,NULL),('ffed19a0-c4e5-11ed-8681-2cf05d5d41d9','1','Lisensi Office 2016 Home Student','lisensi-office-2016-home-student',99000,NULL,199,'berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2023-05-29 20:46:58',NULL,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_details`
--

DROP TABLE IF EXISTS `transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_details` (
  `id` varchar(36) DEFAULT NULL,
  `invoice` varchar(150) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `product_id` varchar(36) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `price` varchar(11) DEFAULT NULL,
  `discount` varchar(2) DEFAULT NULL,
  `price_discount` varchar(11) DEFAULT NULL,
  `qty` varchar(7) DEFAULT NULL,
  `total` varchar(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_details`
--

LOCK TABLES `transaction_details` WRITE;
/*!40000 ALTER TABLE `transaction_details` DISABLE KEYS */;
INSERT INTO `transaction_details` VALUES ('e8606124-f993-11ed-9908-2cf05d5d41d9','INV20230524005934',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','Lisensi Office 2021 Pro Plus Original','test','115000','3','111550','2','223100','2023-05-24 01:01:57','2023-05-24 01:01:57',NULL,NULL),('e861459e-f993-11ed-a88f-2cf05d5d41d9','INV20230524005934',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9','89e3010c-c4e5-11ed-a4bf-2cf05d5d41d9','Lisensi Windows 11 Professional Plus',NULL,'99000','0','99000','1','99000','2023-05-24 01:01:57','2023-05-24 01:01:57',NULL,NULL),('797b27e2-fa21-11ed-8b27-00090faa0001','INV20230524175505',5,'7978795c-fa21-11ed-98b9-00090faa0001','81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','Lisensi Office 2021 Pro Plus Original',NULL,'115000','3','111550','2','223100','2023-05-24 17:55:19','2023-05-24 17:55:19',NULL,NULL),('f212a97e-fcc3-11ed-b648-00090faa0001','INV20230528022309',5,'f211829c-fcc3-11ed-8bc5-00090faa0001','67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','Lisensi Office 2016 Pro Plus Original','email : saya@gmail.com','99000','0','99000','1','99000','2023-05-28 02:23:22','2023-05-28 02:23:22',NULL,NULL),('f213a6b2-fcc3-11ed-85bd-00090faa0001','INV20230528022309',5,'f211829c-fcc3-11ed-8bc5-00090faa0001','2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9','Lisensi Project 2016','email : saya@gmail.com','99000','0','99000','2','198000','2023-05-28 02:23:22','2023-05-28 02:23:22',NULL,NULL),('ab44ff2e-fe26-11ed-a7d0-2cf05d5d41d9','INV20230529204153',5,'ab424806-fe26-11ed-9f17-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','Lisensi Visio 2019',NULL,'99000','0','99000','1','99000','2023-05-29 20:42:35','2023-05-29 20:42:35',NULL,NULL),('e51f71b6-fe26-11ed-96a8-2cf05d5d41d9','INV20230529204402',5,'e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9','e6d27e2e-c4e5-11ed-80a7-2cf05d5d41d9','Lisensi Office 2019 Home Student',NULL,'99000','0','99000','1','99000','2023-05-29 20:44:12','2023-05-29 20:44:12',NULL,NULL),('24d57d64-fe27-11ed-aa7b-2cf05d5d41d9','INV20230529204548',5,'24d47f68-fe27-11ed-885c-2cf05d5d41d9','e7661e6e-c4e4-11ed-afd6-2cf05d5d41d9','Lisensi Windows 10 Professional Plus',NULL,'99000','0','99000','1','99000','2023-05-29 20:45:59','2023-05-29 20:45:59',NULL,NULL),('483df380-fe27-11ed-af18-2cf05d5d41d9','INV20230529204650',5,'483cebde-fe27-11ed-b55f-2cf05d5d41d9','ffed19a0-c4e5-11ed-8681-2cf05d5d41d9','Lisensi Office 2016 Home Student',NULL,'99000','0','99000','1','99000','2023-05-29 20:46:58','2023-05-29 20:46:58',NULL,NULL),('53a4183e-fe55-11ed-bae0-2cf05d5d41d9','INV20230530003357',5,'53a0fba4-fe55-11ed-9181-2cf05d5d41d9','15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','Lisensi Visio 2019',NULL,'99000','0','99000','1','99000','2023-05-30 02:16:34','2023-05-30 02:16:34',NULL,NULL);
/*!40000 ALTER TABLE `transaction_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_statuses`
--

DROP TABLE IF EXISTS `transaction_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_statuses` (
  `id` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_statuses`
--

LOCK TABLES `transaction_statuses` WRITE;
/*!40000 ALTER TABLE `transaction_statuses` DISABLE KEYS */;
INSERT INTO `transaction_statuses` VALUES ('05e8d080-fee1-11ed-9057-2cf05d5d41d9',5,'ab424806-fe26-11ed-9f17-2cf05d5d41d9',2,'2023-05-30 18:56:33','2023-05-30 18:56:33'),('0e7ac072-f997-11ed-927c-2cf05d5d41d9',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',2,'2023-05-24 01:24:29','2023-05-24 01:24:29'),('0eec01aa-fcc7-11ed-9495-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',2,'2023-05-28 02:45:39','2023-05-28 02:45:39'),('1f675724-0045-11ee-aeae-2cf05d5d41d9',5,'24d47f68-fe27-11ed-885c-2cf05d5d41d9',11,'2023-06-01 13:25:37','2023-06-01 13:25:37'),('1f675940-0045-11ee-892d-2cf05d5d41d9',5,'24d47f68-fe27-11ed-885c-2cf05d5d41d9',11,'2023-06-01 13:25:37','2023-06-01 13:25:37'),('22326a8e-0045-11ee-a42d-2cf05d5d41d9',5,'483cebde-fe27-11ed-b55f-2cf05d5d41d9',11,'2023-06-01 13:25:42','2023-06-01 13:25:42'),('22326aac-0045-11ee-b9d5-2cf05d5d41d9',5,'483cebde-fe27-11ed-b55f-2cf05d5d41d9',11,'2023-06-01 13:25:42','2023-06-01 13:25:42'),('2237afa8-0045-11ee-a904-2cf05d5d41d9',5,'53a0fba4-fe55-11ed-9181-2cf05d5d41d9',11,'2023-06-01 13:25:42','2023-06-01 13:25:42'),('223aaf78-0045-11ee-b1b1-2cf05d5d41d9',5,'53a0fba4-fe55-11ed-9181-2cf05d5d41d9',11,'2023-06-01 13:25:42','2023-06-01 13:25:42'),('24d539e4-fe27-11ed-81d6-2cf05d5d41d9',5,'24d47f68-fe27-11ed-885c-2cf05d5d41d9',1,'2023-05-29 20:45:59','2023-05-29 20:45:59'),('30978a9a-fccc-11ed-a529-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:22:23','2023-05-28 03:22:23'),('483dac22-fe27-11ed-b5e7-2cf05d5d41d9',5,'483cebde-fe27-11ed-b55f-2cf05d5d41d9',1,'2023-05-29 20:46:58','2023-05-29 20:46:58'),('513dcc00-fa29-11ed-9d46-00090faa0001',5,'7978795c-fa21-11ed-98b9-00090faa0001',2,'2023-05-24 18:51:28','2023-05-24 18:51:28'),('513dcc00-fa29-11ed-9d46-00090faa0002',5,'7978795c-fa21-11ed-98b9-00090faa0001',3,'2023-05-24 18:52:28','2023-05-24 18:52:28'),('53a38a22-fe55-11ed-9718-2cf05d5d41d9',5,'53a0fba4-fe55-11ed-9181-2cf05d5d41d9',1,'2023-05-30 02:16:34','2023-05-30 02:16:34'),('53cc29f8-fcc7-11ed-8845-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',4,'2023-05-28 02:47:35','2023-05-28 02:47:35'),('56d0f8b4-fa2d-11ed-806e-00090faa0001',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',4,'2023-05-24 19:20:15','2023-05-24 19:20:15'),('6f08d9ea-fa20-11ed-b076-00090faa0001',5,'ffcfe120-fa0d-11ed-af1f-00090faa0001',2,'2023-05-24 17:47:52','2023-05-24 17:47:52'),('6f41668a-fcc7-11ed-9010-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',9,'2023-05-28 02:48:21','2023-05-28 02:48:21'),('7205b424-0254-11ee-9369-2cf05d5d41d9',5,'e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9',3,'2023-06-04 04:20:20','2023-06-04 04:20:20'),('7340ec98-0261-11ee-9ed1-2cf05d5d41d9',5,'ab424806-fe26-11ed-9f17-2cf05d5d41d9',3,'2023-06-04 05:53:26','2023-06-04 05:53:26'),('745983ea-fa43-11ed-99d4-2cf05d5d41d9',5,'7978795c-fa21-11ed-98b9-00090faa0001',4,'2023-05-24 21:58:34','2023-05-24 21:58:34'),('75295de2-fccb-11ed-aac4-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:17:09','2023-05-28 03:17:09'),('797ad9d6-fa21-11ed-b186-00090faa0001',5,'7978795c-fa21-11ed-98b9-00090faa0001',1,'2023-05-24 17:55:19','2023-05-24 17:55:19'),('7a44d0ae-fccb-11ed-aa81-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:17:17','2023-05-28 03:17:17'),('9763081e-076a-11ee-92ab-2cf05d5d41d9',5,'ab424806-fe26-11ed-9f17-2cf05d5d41d9',4,'2023-06-10 15:41:28','2023-06-10 15:41:28'),('a339ebb6-fccb-11ed-97cd-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:18:26','2023-05-28 03:18:26'),('ab4498ae-fe26-11ed-bd3d-2cf05d5d41d9',5,'ab424806-fe26-11ed-9f17-2cf05d5d41d9',1,'2023-05-29 20:42:35','2023-05-29 20:42:35'),('adaac700-fccb-11ed-a64c-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:18:44','2023-05-28 03:18:44'),('b84d454e-fcc5-11ed-97bf-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',12,'2023-05-28 02:36:04','2023-05-28 02:36:04'),('bfac7676-fcc4-11ed-98cb-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',12,'2023-05-28 02:29:07','2023-05-28 02:29:07'),('d1a2db8a-fee1-11ed-90b0-2cf05d5d41d9',5,'e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9',2,'2023-05-30 19:02:15','2023-05-30 19:02:15'),('d2e77c3e-fcc6-11ed-a8c5-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',2,'2023-05-28 02:43:59','2023-05-28 02:43:59'),('e354d17a-fcc6-11ed-9868-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',2,'2023-05-28 02:44:26','2023-05-28 02:44:26'),('e51f292c-fe26-11ed-84d3-2cf05d5d41d9',5,'e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9',1,'2023-05-29 20:44:12','2023-05-29 20:44:12'),('e8601ac0-f993-11ed-826e-2cf05d5d41d9',5,'e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',1,'2023-05-24 01:01:57','2023-05-24 01:01:57'),('f2124da8-fcc3-11ed-bee2-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',1,'2023-05-28 02:23:22','2023-05-28 02:23:22'),('f3af2aa0-0254-11ee-a32a-2cf05d5d41d9',5,'e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9',4,'2023-06-04 04:23:58','2023-06-04 04:23:58'),('f42798ee-fcc5-11ed-aaca-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',12,'2023-05-28 02:37:45','2023-05-28 02:37:45'),('f5f3674e-fcc4-11ed-a4b8-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',12,'2023-05-28 02:30:38','2023-05-28 02:30:38'),('f61dedbe-fcc6-11ed-aac7-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',2,'2023-05-28 02:44:58','2023-05-28 02:44:58'),('f967015e-fccb-11ed-849e-00090faa0001',5,'f211829c-fcc3-11ed-8bc5-00090faa0001',11,'2023-05-28 03:20:51','2023-05-28 03:20:51'),('ffd2393e-fa0d-11ed-855a-00090faa0001',5,'ffcfe120-fa0d-11ed-af1f-00090faa0001',1,'2023-05-24 15:35:55','2023-05-24 15:35:55');
/*!40000 ALTER TABLE `transaction_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_id` int(2) DEFAULT NULL,
  `invoice` varchar(100) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` varchar(12) DEFAULT NULL,
  `discount` varchar(2) DEFAULT NULL,
  `total` varchar(12) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `gross_amount` varchar(12) DEFAULT NULL,
  `status_code` varchar(4) DEFAULT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `transaction_status` varchar(100) DEFAULT NULL,
  `transaction_time` datetime DEFAULT NULL,
  `payment_type` varchar(199) DEFAULT NULL,
  `payment_timeout` datetime DEFAULT NULL,
  `payment_token` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('24d47f68-fe27-11ed-885c-2cf05d5d41d9',5,11,'INV20230529204548',1,'99000','0','99000','2023-06-14 12:55:19','2023-06-01 13:25:42',NULL,NULL,'INV20230529204548','99000.00','201','838fc0ad-48ed-4545-8abb-e0030f237ce8','pending','2023-05-29 20:45:56','bank_transfer','2023-05-30 20:44:56','79015c22-ebc4-49cd-b07d-5c813003459b'),('483cebde-fe27-11ed-b55f-2cf05d5d41d9',5,11,'INV20230529204650',1,'99000','0','99000','2023-06-14 05:55:19','2023-06-01 13:25:42',NULL,NULL,'INV20230529204650','99000.00','201','fb8af06d-95ec-4617-89c7-9c603bf86197','pending','2023-05-29 20:46:56','bank_transfer','2023-05-30 20:45:56','1321c4e1-921c-4323-9c3d-3b9c9854c56b'),('53a0fba4-fe55-11ed-9181-2cf05d5d41d9',5,11,'INV20230530003357',1,'99000','0','99000','2023-06-14 05:55:19','2023-06-01 13:25:42',NULL,NULL,'INV20230530003357','99000.00','201','d376a414-d654-43da-b118-f072092c9fe8','pending','2023-05-30 00:34:47','bank_transfer','2023-05-31 00:33:47','9c9f8534-af18-4793-914d-ec2c6b1c8a42'),('7978795c-fa21-11ed-98b9-00090faa0001',5,4,'INV20230524175505',2,'223100','0','223100','2023-06-14 05:55:19','2023-06-12 17:55:19',NULL,NULL,'INV20230524175505','223100.00','201','ec82efd6-9426-42e8-8507-d2996938b96d','paid','2023-05-24 17:55:16','bank_transfer','2023-05-25 17:54:16','b92150a1-652a-41cf-90f1-d6ddc47e9fca'),('ab424806-fe26-11ed-9f17-2cf05d5d41d9',5,4,'INV20230529204153',1,'99000','0','99000','2023-06-14 11:55:19','2023-06-12 17:55:19',NULL,NULL,'INV20230529204153','99000.00','201','39ec873d-4b9c-4647-a8d2-80c2954b7143','paid','2023-05-29 20:41:58','bank_transfer','2023-05-30 20:40:58','7fbbf61f-6dad-41d1-8aae-1ab004bc250a'),('e51cc9ca-fe26-11ed-ba03-2cf05d5d41d9',5,4,'INV20230529204402',1,'99000','0','99000','2023-06-14 10:55:19','2023-06-11 17:55:19',NULL,NULL,'INV20230529204402','99000.00','201','57be953e-7314-48e6-b4e4-8ce3c3dcb5b5','paid','2023-05-29 20:44:07','bank_transfer','2023-05-30 20:43:07','5a13d0fb-015a-48c2-9680-89a67a02a138'),('e85dcd2e-f993-11ed-88b0-2cf05d5d41d9',5,4,'INV20230524005934',3,'322100','0','322100','2023-06-14 01:01:57','2023-05-24 19:20:15',NULL,NULL,'INV20230524005934','322100.00','201','97e1d598-0412-411d-9167-62d2cea5232f','paid','2023-05-24 00:59:40','bank_transfer','2023-05-25 00:58:40','a810fac5-a5ec-4267-b0d8-e5024c61b147'),('f211829c-fcc3-11ed-8bc5-00090faa0001',5,11,'INV20230528022309',3,'297000','0','297000','2023-06-14 02:23:22','2023-05-28 03:22:23',NULL,NULL,'INV20230528022309','297000.00','201','05a9c26f-9018-4baa-b467-c3505ae4043d','paid','2023-05-28 02:23:17','qris','2023-05-28 02:52:17','9cee8a85-fcfc-45c0-8a8c-7e053e6daede');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_logs`
--

DROP TABLE IF EXISTS `user_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_logs` (
  `id` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `ip_address` varchar(25) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_logs`
--

LOCK TABLES `user_logs` WRITE;
/*!40000 ALTER TABLE `user_logs` DISABLE KEYS */;
INSERT INTO `user_logs` VALUES ('014a62d4-0a15-11ee-b171-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 01:06:22','2023-06-14 01:06:22'),('024ea342-1650-11ee-a7e3-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:38:58','2023-06-29 14:38:58'),('03af1384-18b2-11ee-aa32-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2021-pro-plus-original','GET','Visit Product lisensi-office-2021-pro-plus-original','127.0.0.1','2023-07-02 15:25:34','2023-07-02 15:25:34'),('0526da28-1653-11ee-9e79-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:00:31','2023-06-29 15:00:31'),('08372628-1653-11ee-8e5e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:00:37','2023-06-29 15:00:37'),('0b40b10e-1653-11ee-b10d-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:00:42','2023-06-29 15:00:42'),('0b7a2376-1653-11ee-a19e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:00:42','2023-06-29 15:00:42'),('0bcc5674-0950-11ee-b8c0-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-13 01:36:29','2023-06-13 01:36:29'),('0c40d2b6-166a-11ee-8e57-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:45:22','2023-06-29 17:45:22'),('0cd3b454-0950-11ee-bbba-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Has Visit Product 67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','127.0.0.1','2023-06-13 01:36:31','2023-06-13 01:36:31'),('1769d31a-10aa-11ee-80de-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:08:41','2023-06-22 10:08:41'),('19d74d86-1653-11ee-aaad-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:06','2023-06-29 15:01:06'),('1af4ac2c-1653-11ee-a088-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:08','2023-06-29 15:01:08'),('1b0f4764-0f17-11ee-80fe-00090faa0001',20,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-20 10:04:00','2023-06-20 10:04:00'),('1e3e431a-10aa-11ee-ace2-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:08:53','2023-06-22 10:08:53'),('1ee3a8ce-1653-11ee-b51a-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:01:15','2023-06-29 15:01:15'),('1f17ed28-1653-11ee-a7eb-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:15','2023-06-29 15:01:15'),('1f9ee290-1650-11ee-963f-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:39:47','2023-06-29 14:39:47'),('2139b23a-1653-11ee-8971-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:19','2023-06-29 15:01:19'),('229d4114-1653-11ee-9372-2cf05d5d41d9',22,'http://bins.local/api/v1/checkout','POST','Order INV20230629150121','127.0.0.1','2023-06-29 15:01:21','2023-06-29 15:01:21'),('22d67bb4-09a1-11ee-80e1-00090faa0001',5,'http://bins.local/api/v1/chart/e7e1561e-09a0-11ee-a4f4-00090faa0001','DELETE','Has Remove Cart lisensi-office-2019-pro-plus-original','127.0.0.1','2023-06-13 11:16:57','2023-06-13 11:16:57'),('242b3f8a-10aa-11ee-b586-00090faa0001',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 10:09:03','2023-06-22 10:09:03'),('24bbe356-111c-11ee-ae8d-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:45:06','2023-06-22 23:45:06'),('24d8922a-10aa-11ee-8ffa-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:09:04','2023-06-22 10:09:04'),('25a77b7e-1651-11ee-a4e1-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:47:07','2023-06-29 14:47:07'),('26a1f8c4-1651-11ee-bb5f-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:47:09','2023-06-29 14:47:09'),('27459836-09a3-11ee-ab70-00090faa0001',5,'http://bins.local/api/v1/chart','POST','Add Cart lisensi-visio-2019','127.0.0.1','2023-06-13 11:31:23','2023-06-13 11:31:23'),('2811479e-1653-11ee-b8fd-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:01:30','2023-06-29 15:01:30'),('291a2206-1652-11ee-ab6a-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:54:22','2023-06-29 14:54:22'),('293a61b2-1655-11ee-811e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:15:51','2023-06-29 15:15:51'),('2a8fb7ee-1653-11ee-9bf0-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:34','2023-06-29 15:01:34'),('2c46943c-0950-11ee-bcd1-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Has Visit Profile','127.0.0.1','2023-06-13 01:37:23','2023-06-13 01:37:23'),('2c4c8198-09a1-11ee-b79e-00090faa0001',5,'http://bins.local/api/v1/chart/9b2ca202-0927-11ee-96c0-2cf05d5d41d9','DELETE','Has Remove Cart office-365-professinal-plus','127.0.0.1','2023-06-13 11:17:13','2023-06-13 11:17:13'),('2c9150c4-094d-11ee-8129-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Has Visit Profile','127.0.0.1','2023-06-13 01:15:55','2023-06-13 01:15:55'),('2d16cb0c-0a13-11ee-b13a-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:53:17','2023-06-14 00:53:17'),('2dd678c0-09a1-11ee-a092-00090faa0001',5,'http://bins.local/api/v1/chart/3ec1b0de-0927-11ee-8968-2cf05d5d41d9','DELETE','Has Remove Cart lisensi-office-2021-pro-plus-original','127.0.0.1','2023-06-13 11:17:15','2023-06-13 11:17:15'),('2ec1df86-1653-11ee-bcbb-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:01:41','2023-06-29 15:01:41'),('2ef4c284-1653-11ee-944c-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:01:42','2023-06-29 15:01:42'),('2f21f3a8-09a1-11ee-a0c1-00090faa0001',5,'http://bins.local/api/v1/chart/3d47029a-0927-11ee-9f0e-2cf05d5d41d9','DELETE','Has Remove Cart lisensi-visio-2019','127.0.0.1','2023-06-13 11:17:18','2023-06-13 11:17:18'),('2ff6ad2a-167e-11ee-a9a5-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 20:09:32','2023-06-29 20:09:32'),('3373936c-09a1-11ee-81af-00090faa0001',5,'http://bins.local/api/v1/product/lisensi-office-2021-pro-plus-original','GET','Has Visit Product lisensi-office-2021-pro-plus-original','127.0.0.1','2023-06-13 11:17:25','2023-06-13 11:17:25'),('354c8dba-09a1-11ee-b5c0-00090faa0001',5,'http://bins.local/api/v1/chart','POST','Has Add Cart lisensi-office-2021-pro-plus-original','127.0.0.1','2023-06-13 11:17:28','2023-06-13 11:17:28'),('393722d2-10a9-11ee-80e0-00090faa0001',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 10:02:29','2023-06-22 10:02:29'),('3983fe44-094d-11ee-8098-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Has Visit Product 67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','127.0.0.1','2023-06-13 01:16:17','2023-06-13 01:16:17'),('39e5c1ac-10a9-11ee-93d8-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:02:30','2023-06-22 10:02:30'),('3a078464-1652-11ee-8872-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:54:51','2023-06-29 14:54:51'),('3da89230-166a-11ee-9220-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:46:45','2023-06-29 17:46:45'),('3f3a9afa-1654-11ee-a39a-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:09:18','2023-06-29 15:09:18'),('3f876b76-1651-11ee-b062-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:47:50','2023-06-29 14:47:50'),('405bdb14-1655-11ee-99ad-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:16:30','2023-06-29 15:16:30'),('40ab864a-1651-11ee-b8a7-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:47:52','2023-06-29 14:47:52'),('40d0c23a-1655-11ee-acd8-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:16:31','2023-06-29 15:16:31'),('42a60b8c-167e-11ee-a214-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 20:10:03','2023-06-29 20:10:03'),('433b6a88-167e-11ee-9ca1-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 20:10:04','2023-06-29 20:10:04'),('45784f80-111c-11ee-964a-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:01','2023-06-22 23:46:01'),('47728906-167e-11ee-b5dc-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 20:10:11','2023-06-29 20:10:11'),('48131be2-1655-11ee-bf2d-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:16:43','2023-06-29 15:16:43'),('48a22f5a-111c-11ee-a7ca-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:07','2023-06-22 23:46:07'),('48f1456a-166a-11ee-8503-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:47:04','2023-06-29 17:47:04'),('497616d8-1655-11ee-be73-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:16:45','2023-06-29 15:16:45'),('4adc6e40-167e-11ee-b043-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 20:10:17','2023-06-29 20:10:17'),('4b51ca64-167e-11ee-bd2a-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 20:10:18','2023-06-29 20:10:18'),('4d510a58-111c-11ee-b7b5-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:14','2023-06-22 23:46:14'),('5182d9c0-094d-11ee-8aab-2cf05d5d41d9',5,'http://bins.local/api/v1/chart/a8e1f3f2-0927-11ee-87a1-2cf05d5d41d9','DELETE','Has Remove Cart','127.0.0.1','2023-06-13 01:16:57','2023-06-13 01:16:57'),('531f5de2-167e-11ee-8729-2cf05d5d41d9',5,'http://bins.local/api/v1/checkout','POST','Order INV20230629201031','127.0.0.1','2023-06-29 20:10:31','2023-06-29 20:10:31'),('56c724a4-10be-11ee-9db2-00090faa0001',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 12:33:38','2023-06-22 12:33:38'),('577ad864-10be-11ee-9504-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 12:33:39','2023-06-22 12:33:39'),('580f14a8-111c-11ee-af67-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:32','2023-06-22 23:46:32'),('58f7f384-094d-11ee-90af-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Has Visit Profile','127.0.0.1','2023-06-13 01:17:10','2023-06-13 01:17:10'),('5bae980e-111c-11ee-b4c1-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:39','2023-06-22 23:46:39'),('5c5e64a0-111c-11ee-9d35-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:40','2023-06-22 23:46:40'),('5d4fab98-164f-11ee-a87d-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:34:21','2023-06-29 14:34:21'),('5e54be78-1651-11ee-aae3-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:48:42','2023-06-29 14:48:42'),('5f6c0730-1651-11ee-882a-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:48:44','2023-06-29 14:48:44'),('62bc2c16-1652-11ee-9fc9-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 14:55:59','2023-06-29 14:55:59'),('631a56ee-1650-11ee-bfb3-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:41:41','2023-06-29 14:41:41'),('637e98c8-1652-11ee-ad01-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:56:00','2023-06-29 14:56:00'),('64d93206-166a-11ee-94c2-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:47:50','2023-06-29 17:47:50'),('6503a908-111c-11ee-8501-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:46:54','2023-06-22 23:46:54'),('670c55d6-10f1-11ee-a0c2-00090faa0001',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 18:39:09','2023-06-22 18:39:09'),('6965cc9a-1650-11ee-ab77-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:41:51','2023-06-29 14:41:51'),('6a38306a-111c-11ee-a231-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:47:03','2023-06-22 23:47:03'),('6b407376-09a3-11ee-8148-00090faa0001',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-13 11:33:17','2023-06-13 11:33:17'),('6bd9d0b2-0a10-11ee-b333-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:33:34','2023-06-14 00:33:34'),('6d7f453c-094d-11ee-8b48-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Has Visit Product 67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','127.0.0.1','2023-06-13 01:17:44','2023-06-13 01:17:44'),('6f4ece64-094d-11ee-a70e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Has Visit Product 67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','127.0.0.1','2023-06-13 01:17:47','2023-06-13 01:17:47'),('6fc26258-111c-11ee-92fa-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:47:12','2023-06-22 23:47:12'),('70fac76e-111c-11ee-ada1-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:47:14','2023-06-22 23:47:14'),('71f5d60e-111c-11ee-935f-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:47:16','2023-06-22 23:47:16'),('73d0d804-1651-11ee-a72e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:49:18','2023-06-29 14:49:18'),('74e495c8-1651-11ee-a49d-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:49:20','2023-06-29 14:49:20'),('76551a84-158b-11ee-910a-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-28 15:12:02','2023-06-28 15:12:02'),('7960032c-09a3-11ee-8522-00090faa0001',5,'http://bins.local/api/v1/discuss','POST','Add Discussion Product lisensi-visio-2019','127.0.0.1','2023-06-13 11:33:41','2023-06-13 11:33:41'),('79a5957c-09a3-11ee-9002-00090faa0001',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-13 11:33:42','2023-06-13 11:33:42'),('7b64c4e6-0a11-11ee-86e6-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:41:09','2023-06-14 00:41:09'),('7c2d850c-1650-11ee-b30b-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:42:23','2023-06-29 14:42:23'),('7c9a6212-1650-11ee-b009-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:42:23','2023-06-29 14:42:23'),('7f4b3b22-1654-11ee-a8a8-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:11:06','2023-06-29 15:11:06'),('805ba520-0a14-11ee-abdf-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 01:02:46','2023-06-14 01:02:46'),('8317536c-1956-11ee-a7c9-00090faa0001',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-07-03 11:03:05','2023-07-03 11:03:05'),('8429e1c8-166a-11ee-a335-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:48:43','2023-06-29 17:48:43'),('870ca282-0a11-11ee-bece-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:41:29','2023-06-14 00:41:29'),('87d8789e-1650-11ee-ac3d-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:42:42','2023-06-29 14:42:42'),('881b9e2c-1654-11ee-8b11-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:11:21','2023-06-29 15:11:21'),('8accb488-166a-11ee-88cc-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:48:54','2023-06-29 17:48:54'),('8c275b82-1654-11ee-a2cc-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:11:27','2023-06-29 15:11:27'),('8cf03d80-1650-11ee-abbf-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:42:51','2023-06-29 14:42:51'),('8d981f7e-1956-11ee-a450-00090faa0001',5,'http://bins.local/api/v1/product/office-365-professinal-plus','GET','Visit Product office-365-professinal-plus','127.0.0.1','2023-07-03 11:03:22','2023-07-03 11:03:22'),('90c71e0e-10f8-11ee-8e51-00090faa0001',22,'http://bins.local/api/v1/product/lisensi-office-2021-pro-plus-original','GET','Visit Product lisensi-office-2021-pro-plus-original','127.0.0.1','2023-06-22 19:30:26','2023-06-22 19:30:26'),('9144e3ec-1653-11ee-b18b-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:04:27','2023-06-29 15:04:27'),('9190fa8c-0dfe-11ee-970b-00090faa0001',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-19 00:35:51','2023-06-19 00:35:51'),('91d86cec-0a15-11ee-8878-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-14 01:10:25','2023-06-14 01:10:25'),('96cc4d1e-1653-11ee-ba1c-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:04:36','2023-06-29 15:04:36'),('973aa614-1654-11ee-adb4-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:11:46','2023-06-29 15:11:46'),('97abd9f2-1653-11ee-8572-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:04:37','2023-06-29 15:04:37'),('97b71354-10a8-11ee-8992-00090faa0001',21,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 09:57:58','2023-06-22 09:57:58'),('97fc592e-166a-11ee-866d-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:49:16','2023-06-29 17:49:16'),('99a6d000-10a8-11ee-a962-00090faa0001',21,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 09:58:01','2023-06-22 09:58:01'),('9a5f70ba-10a8-11ee-9aa3-00090faa0001',21,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 09:58:02','2023-06-22 09:58:02'),('9c80884a-1650-11ee-a203-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:43:17','2023-06-29 14:43:17'),('9d6f5a58-1653-11ee-b84f-2cf05d5d41d9',22,'http://bins.local/api/v1/checkout','POST','Order INV20230629150447','127.0.0.1','2023-06-29 15:04:47','2023-06-29 15:04:47'),('9e14698e-164f-11ee-8dad-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:36:10','2023-06-29 14:36:10'),('a0fd7edc-1669-11ee-a25e-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:42:22','2023-06-29 17:42:22'),('a18fdc98-1653-11ee-8ebf-2cf05d5d41d9',22,'http://bins.local/api/v1/chart','POST','Add Cart lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:04:54','2023-06-29 15:04:54'),('a57d2d6a-111c-11ee-801b-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:48:42','2023-06-22 23:48:42'),('a5ffc404-0a10-11ee-9021-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:35:11','2023-06-14 00:35:11'),('a6903a50-098b-11ee-b85a-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Has Visit Product 15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','127.0.0.1','2023-06-13 08:43:09','2023-06-13 08:43:09'),('a95d0abe-0a13-11ee-a412-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:56:45','2023-06-14 00:56:45'),('aa7b1e12-111c-11ee-ac69-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:48:51','2023-06-22 23:48:51'),('ad188170-166a-11ee-8c5c-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:49:52','2023-06-29 17:49:52'),('ad8631e6-111c-11ee-a835-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:48:56','2023-06-22 23:48:56'),('b0f5c78c-1654-11ee-b885-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:12:29','2023-06-29 15:12:29'),('b193c8fe-098b-11ee-9245-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-13 08:43:27','2023-06-13 08:43:27'),('b266535a-098b-11ee-b52a-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Has Visit Product 15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','127.0.0.1','2023-06-13 08:43:29','2023-06-13 08:43:29'),('b3c82676-1654-11ee-96c5-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:12:34','2023-06-29 15:12:34'),('b48bad94-164f-11ee-b3f7-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:36:48','2023-06-29 14:36:48'),('b9c049fa-1654-11ee-aa5f-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:12:44','2023-06-29 15:12:44'),('ba9fe33a-1654-11ee-8a91-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:12:45','2023-06-29 15:12:45'),('bb923016-166a-11ee-9847-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:50:16','2023-06-29 17:50:16'),('bcc068e4-158a-11ee-b4dc-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-28 15:06:51','2023-06-28 15:06:51'),('be49915a-10f7-11ee-995d-00090faa0001',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-22 19:24:33','2023-06-22 19:24:33'),('bf525e7c-1653-11ee-8182-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:05:44','2023-06-29 15:05:44'),('bf94d670-1654-11ee-9ac0-2cf05d5d41d9',5,'http://bins.local/api/v1/checkout','POST','Order INV20230629151254','127.0.0.1','2023-06-29 15:12:54','2023-06-29 15:12:54'),('c10c90ac-1653-11ee-9ca0-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:05:47','2023-06-29 15:05:47'),('c25bf8fa-0a12-11ee-809c-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:50:18','2023-06-14 00:50:18'),('c2d7dd60-1653-11ee-82c8-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:05:50','2023-06-29 15:05:50'),('c4311e02-10a8-11ee-84a6-00090faa0001',21,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 09:59:12','2023-06-22 09:59:12'),('c88093f2-0a86-11ee-a02d-00090faa0001',5,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-14 14:40:50','2023-06-14 14:40:50'),('c95d2db6-10a9-11ee-b5fd-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:06:30','2023-06-22 10:06:30'),('ca3f0ebc-1652-11ee-a28d-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 14:58:53','2023-06-29 14:58:53'),('cac0e878-111c-11ee-bd98-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:49:45','2023-06-22 23:49:45'),('cd2d87c0-1652-11ee-acb2-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:58:58','2023-06-29 14:58:58'),('cf804e44-10a9-11ee-998b-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:06:41','2023-06-22 10:06:41'),('d09bd23a-111c-11ee-98e0-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:49:55','2023-06-22 23:49:55'),('d413a420-1652-11ee-b61d-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 14:59:09','2023-06-29 14:59:09'),('d41cfcda-1654-11ee-b86d-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:13:28','2023-06-29 15:13:28'),('d41d02de-1654-11ee-bd41-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 15:13:28','2023-06-29 15:13:28'),('d4d2c350-1652-11ee-93d9-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:59:10','2023-06-29 14:59:10'),('d6037e36-10a8-11ee-a754-00090faa0001',21,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 09:59:42','2023-06-22 09:59:42'),('d616e3c8-10f7-11ee-9456-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 19:25:12','2023-06-22 19:25:12'),('d6ff600c-09a0-11ee-86f7-00090faa0001',5,'http://bins.local/api/v1/product/lisensi-office-2019-pro-plus-original','GET','Has Visit Product lisensi-office-2019-pro-plus-original','127.0.0.1','2023-06-13 11:14:50','2023-06-13 11:14:50'),('d7be07f4-10a9-11ee-8755-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:06:55','2023-06-22 10:06:55'),('d85b3910-164f-11ee-9680-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-office-2016-pro-plus-original','GET','Visit Product lisensi-office-2016-pro-plus-original','127.0.0.1','2023-06-29 14:37:48','2023-06-29 14:37:48'),('d9687bfc-111c-11ee-8950-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 23:50:09','2023-06-22 23:50:09'),('da9b7c8a-0989-11ee-8e74-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Has Visit Product 15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','127.0.0.1','2023-06-13 08:30:17','2023-06-13 08:30:17'),('dcfdf6c2-10f7-11ee-8ba5-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 19:25:24','2023-06-22 19:25:24'),('dd2010ac-10a9-11ee-98d7-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:07:04','2023-06-22 10:07:04'),('dd40ceb0-10a8-11ee-aa89-00090faa0001',21,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 09:59:54','2023-06-22 09:59:54'),('df23cccc-158b-11ee-a124-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-28 15:14:58','2023-06-28 15:14:58'),('df625bee-1654-11ee-ba7c-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:13:47','2023-06-29 15:13:47'),('e00b58a8-158b-11ee-91b3-2cf05d5d41d9',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-28 15:14:59','2023-06-28 15:14:59'),('e2da8e04-1654-11ee-87d7-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/login','POST','Has Login','127.0.0.1','2023-06-29 15:13:53','2023-06-29 15:13:53'),('e3406ede-0a12-11ee-aa19-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:51:13','2023-06-14 00:51:13'),('e38c61ce-1654-11ee-a667-2cf05d5d41d9',5,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-29 15:13:54','2023-06-29 15:13:54'),('e5e5c57a-10a8-11ee-a13b-00090faa0001',21,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:00:09','2023-06-22 10:00:09'),('e7e22332-09a0-11ee-a012-00090faa0001',5,'http://bins.local/api/v1/chart','POST','Has Add Cart','127.0.0.1','2023-06-13 11:15:18','2023-06-13 11:15:18'),('e928b6e6-1654-11ee-9263-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-29 15:14:03','2023-06-29 15:14:03'),('ec20001c-10a9-11ee-a865-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:07:29','2023-06-22 10:07:29'),('ecdf090a-10f7-11ee-b474-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 19:25:51','2023-06-22 19:25:51'),('efed219a-166a-11ee-a0ea-2cf05d5d41d9',NULL,'http://bins.local/api/v1/product/lisensi-visio-2016-untuk-windows','GET','Visit Product lisensi-visio-2016-untuk-windows','127.0.0.1','2023-06-29 17:51:44','2023-06-29 17:51:44'),('f3677da0-10a9-11ee-ba94-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:07:41','2023-06-22 10:07:41'),('f8198988-10a9-11ee-9af1-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:07:49','2023-06-22 10:07:49'),('fa5882d0-111c-11ee-8b3c-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2019-pro-plus-original','GET','Visit Product lisensi-office-2019-pro-plus-original','127.0.0.1','2023-06-22 23:51:05','2023-06-22 23:51:05'),('fd33d19e-111c-11ee-916f-2cf05d5d41d9',22,'http://bins.local/api/v1/product/lisensi-office-2021-pro-plus-original','GET','Visit Product lisensi-office-2021-pro-plus-original','127.0.0.1','2023-06-22 23:51:09','2023-06-22 23:51:09'),('fe5faa38-18b1-11ee-9997-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-office-2019-pro-plus-original','GET','Visit Product lisensi-office-2019-pro-plus-original','127.0.0.1','2023-07-02 15:25:25','2023-07-02 15:25:25'),('fee2682c-0a12-11ee-9d66-2cf05d5d41d9',5,'http://bins.local/api/v1/product/lisensi-visio-2019','GET','Visit Product lisensi-visio-2019','127.0.0.1','2023-06-14 00:51:59','2023-06-14 00:51:59'),('ff399168-10a9-11ee-9476-00090faa0001',22,'http://bins.local/api/v1/auth/user','GET','Visit Profile','127.0.0.1','2023-06-22 10:08:01','2023-06-22 10:08:01');
/*!40000 ALTER TABLE `user_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(100) DEFAULT NULL,
  `provider_id` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `last_ip` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'admin nya ini','admin112233@gmail.com','$2y$10$XyoKX08NV3w9d2.Tku99zejNeInxviunghpcYqVdVR.UK1NNMykCq','0816262439',1,NULL,NULL,'http://bins.local/cs.png',NULL,NULL,1,'2023-07-03 10:58:31','2023-03-25 17:59:27','2023-07-03 10:58:31'),(5,'google','101704179394836258470','muhammad aditya','adityamuhammadputra@gmail.com','$2y$10$4RRszGrIP.Bw92mopq7dEuSgOVg.MhGbsogdegPDEvQTqZdZoCJ0G','+62123',1,'2023-05-01',NULL,'https://lh3.googleusercontent.com/a/AAcHTtczriwJd-v0IwUXXXjCywj0jY5X9omRiknsBNT4MuYvxzA=s96-c',NULL,NULL,NULL,'2023-07-03 15:04:16','2023-03-25 17:59:27','2023-07-03 15:04:16'),(19,NULL,NULL,'Weekly Movie Recaps','recappedcinema@gmail.com','$2y$10$.UBnVO9zgflA1wDFuTcQNegARZpRW0dp9rkaJSC29jGf4W8D9jNI6',NULL,NULL,NULL,NULL,'https://lh3.googleusercontent.com/a/AGNmyxa0OwDqIK2pEUG230PVBYucB1u3qXnL0PTVCyXf=s96-c',NULL,NULL,NULL,NULL,'2023-05-21 22:50:26','2023-05-21 22:50:26'),(20,NULL,NULL,'bins movie room','binsmovieroom@gmail.com','$2y$10$KmJ9h94/WX68WsRifb/v/eqUSL454hO6czmF.EzcQfwJnVDVxBnRu','08121212',1,'2023-06-01',NULL,'https://lh3.googleusercontent.com/a/AAcHTtdzdSL5SajAxxXrubaWcAgxjOMQw2Gs1_U09FcA=s96-c',NULL,NULL,NULL,'2023-06-20 10:03:59','2023-06-02 05:14:56','2023-06-20 10:03:59'),(22,'facebook','3851449218259911','Muhammad Aditya Ptr','adityamuhammadputra@yahoo.com','$2y$10$5vaPtNXgxr.WI7SmlVhwfeEeOzXbT0ArQ4liPHt8YfPFHMxhD7Nme','081231312',1,NULL,NULL,'https://graph.facebook.com/3851449218259911/picture?type=normal',NULL,NULL,NULL,'2023-06-29 20:10:11','2023-06-22 10:02:28','2023-06-29 20:10:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bins'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-04 12:55:19

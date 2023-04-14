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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_statuses`
--

LOCK TABLES `asset_statuses` WRITE;
/*!40000 ALTER TABLE `asset_statuses` DISABLE KEYS */;
INSERT INTO `asset_statuses` VALUES (1,'Menunggu Pembayaran','Pemesanan berhasil, menunggu verifikasi pembayaran'),(2,'Pembayaran Berhasil','Pembayaran diverifikasi, pemesanan sedang di proses Admin Bins'),(3,'Pesanan Diproses','Pesanan sudah diproses, dan akan dikirim oleh Admin Bins'),(4,'Pesanan Dikirim','Pesanan sudah dikirim, estimasi 6 jam otomatis berhasil'),(5,'Pesanan Berhasil','Pesanan sudah diterima oleh pembeli'),(9,'Pengajual Refund','Pembeli mengajukan Pengembalian dana'),(10,'Batal Transaksi ','Transaksi gagal, pengembalian dana berhasil diverifikasi'),(11,'Batal Pembayaran','Pembayaran gagal, pembeli tidak melakukan pembayaran 1 x 24 jam');
/*!40000 ALTER TABLE `asset_statuses` ENABLE KEYS */;
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
INSERT INTO `charts` VALUES ('8ce87bdc-d293-11ed-85b1-2cf05d5d41d9',6,'81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9',1,NULL,NULL,'2023-04-04 02:51:08','2023-04-04 02:51:08'),('8fe59de2-d293-11ed-b4ab-2cf05d5d41d9',6,'8dbe0722-c4e5-11ed-a2b7-2cf05d5d41d9',1,NULL,NULL,'2023-04-04 02:51:13','2023-04-04 02:51:13'),('ccf65b2c-cee2-11ed-9f68-c206c33d2564',5,'2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9',1,'secepatnya yaa kak',NULL,'2023-03-30 10:08:21','2023-04-10 06:38:52'),('d849bcd2-cbc0-11ed-abca-2cf05d5d41d9',5,'67ca553e-c4e5-11ed-b25a-2cf05d5d41d9',2,'tolong kirim email secepatnya',NULL,'2023-03-26 10:27:44','2023-04-10 06:38:53'),('ee215830-cbf7-11ed-b482-c006c33d2564',5,'b87bbfc0-c41f-11ed-a075-2cf05d5d41d9',1,'test',NULL,'2023-03-26 17:02:03','2023-04-11 13:09:59'),('eee031ba-d291-11ed-a9f2-2cf05d5d41d9',6,'2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9',1,NULL,NULL,'2023-04-04 02:39:33','2023-04-04 02:39:33');
/*!40000 ALTER TABLE `charts` ENABLE KEYS */;
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
  `price` varchar(12) DEFAULT NULL,
  `discount` varchar(3) DEFAULT NULL,
  `stock` varchar(7) DEFAULT NULL,
  `desc` longtext DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `warranty` varchar(2) DEFAULT NULL COMMENT 'bulan',
  `img1` varchar(200) DEFAULT NULL,
  `img2` varchar(200) DEFAULT NULL,
  `img3` varchar(200) DEFAULT NULL,
  `img4` varchar(200) DEFAULT NULL,
  `img5` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(80) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('11348806-c4e6-11ed-b802-2cf05d5d41d9','1','Lisensi Visio 2016','lisensi-visio-2016','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('15e50a2e-c4e6-11ed-9559-2cf05d5d41d9','1','Lisensi Visio 2019','lisensi-visio-2019','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('26eacaf2-c4e6-11ed-9011-2cf05d5d41d9','1','Lisensi Project 2019','lisensi-project-2019','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('2bbe0ff8-c4e6-11ed-8f59-2cf05d5d41d9','1','Lisensi Project 2016','lisensi-project-2016','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('67ca553e-c4e5-11ed-b25a-2cf05d5d41d9','1','Lisensi Office 2016 Pro Plus Original','lisensi-office-2016-pro-plus-original','99000',NULL,'200','PRODUK FISIK BERUPA DVD INSTALLER SERTA PANDUAN INSTALASI AKAN DIKIRIM KE ALAMAT YANG ANDA CANTUMKAN DAN AKAN DIKIRIM PADA HARI YANG SAMA!!<br><br>MOHON DIBACA DESKRIPSI PRODUK SAMPAI SELESAI !!!<br>','1',NULL,'2016_1.png','2016_2.png','Garansi.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('81c8bf7a-c4e5-11ed-b084-2cf05d5d41d9','1','Lisensi Office 2021 Pro Plus Original','lisensi-office-2021-pro-plus-original','115000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,'2021_1.jpg','2021_2.jpg','Garansi.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('89e3010c-c4e5-11ed-a4bf-2cf05d5d41d9','2','Lisensi Windows 11 Professional Plus','lisensi-windows-11-professional-plus','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8dbe0722-c4e5-11ed-a2b7-2cf05d5d41d9','1','Office 365 Professinal Plus','office-365-professinal-plus','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,'365_1.png','365_2.png','Garansi.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b87bbfc0-c41f-11ed-a075-2cf05d5d41d9','1','Lisensi Office 2019 Pro Plus Original','lisensi-office-2019-pro-plus-original','109000',NULL,'200','PRODUK FISIK BERUPA DVD INSTALLER SERTA PANDUAN INSTALASI AKAN DIKIRIM KE ALAMAT YANG ANDA CANTUMKAN DAN AKAN DIKIRIM PADA HARI YANG SAMA!!<br><br>MOHON DIBACA DESKRIPSI PRODUK SAMPAI SELESAI !!!<br>','1',NULL,'2019_1.png','2019_2.png','Garansi.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6d27e2e-c4e5-11ed-80a7-2cf05d5d41d9','1','Lisensi Office 2019 Home Student','lisensi-office-2019-home-student','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e7661e6e-c4e4-11ed-afd6-2cf05d5d41d9','2','Lisensi Windows 10 Professional Plus','lisensi-windows-10-professional-plus','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ffed19a0-c4e5-11ed-8681-2cf05d5d41d9','1','Lisensi Office 2016 Home Student','lisensi-office-2016-home-student','99000',NULL,'200','berupa Licese k(e)y retail Original retail<br>- License original berupa 25 digit (Alpha Numeric) untuk Aktivasi (aktivasi online)<br>- 1 license Key Hanya untuk 1 device / perangkat / laptop / PC<br>- Aktivasi wajib online, pastikan internet terkoneksi dengan baik baru aktivasi<br>- Aktivasi Permanen tanpa batas waktu / cukup 1 kali beli dan siap pakai selamanya<br>- license key kami support untuk 32 atau 64 bit (pilih salah satu aja saat aktivasi)<br>- License key bisa re-install atau aman digunakan untuk install ulang tanpa batas<br><br>','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
  `qty` varchar(7) DEFAULT NULL,
  `discount` varchar(2) DEFAULT NULL,
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
/*!40000 ALTER TABLE `transaction_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_order`
--

DROP TABLE IF EXISTS `transaction_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_order` (
  `id` varchar(36) NOT NULL,
  `fraud_status` varchar(255) DEFAULT NULL,
  `gross_amount` int(12) DEFAULT NULL,
  `order_id` varchar(30) DEFAULT NULL,
  `payment_type` varchar(100) DEFAULT NULL,
  `status_message` varchar(255) DEFAULT NULL,
  `status_code` varchar(10) DEFAULT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `transaction_status` varchar(30) DEFAULT NULL,
  `transaction_time` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_order`
--

LOCK TABLES `transaction_order` WRITE;
/*!40000 ALTER TABLE `transaction_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_order` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `last_ip` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'Nani Nurasiah','nanninini@gmail.com',NULL,'0812314551',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'101704179394836258470','muhammad aditya','adityamuhammadputra@gmail.com','$2y$10$4RRszGrIP.Bw92mopq7dEuSgOVg.MhGbsogdegPDEvQTqZdZoCJ0G',NULL,NULL,NULL,NULL,NULL,'https://lh3.googleusercontent.com/a/AGNmyxYR7n047Q91uSQ0sYjSExMz64-29uRlRQvTfIpBmg=s96-c','2023-03-25 17:59:27','2023-04-09 15:47:38'),(6,'104673921214175573873','bins mitra lestari','binsmitralestari@gmail.com','$2y$10$4RRszGrIP.Bw92mopq7dEuSgOVg.MhGbsogdegPDEvQTqZdZoCJ0G',NULL,NULL,NULL,NULL,NULL,'https://lh3.googleusercontent.com/a/AGNmyxaCoNitiUTwIvkPPoY8A7qRs0cc_X0fvU3N0v1I=s96-c','2023-03-25 18:15:35','2023-03-25 18:15:35');
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

-- Dump completed on 2023-04-14 19:48:18

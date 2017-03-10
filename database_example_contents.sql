CREATE DATABASE  IF NOT EXISTS `test4ig` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test4ig`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: test4ig
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `cat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `cat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat`
--

LOCK TABLES `cat` WRITE;
/*!40000 ALTER TABLE `cat` DISABLE KEYS */;
INSERT INTO `cat` VALUES
(5,'Мониторы'),
(1,'Оргтехника'),
(2,'Расходные материалы'),
(4,'Сетевое оборудование'),
(3,'Системные блоки');
/*!40000 ALTER TABLE `cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `prod` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_cat_id_idx` (`cat_id`),
  CONSTRAINT `fk_cat_id` FOREIGN KEY (`cat_id`) REFERENCES `cat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod`
--

LOCK TABLES `prod` WRITE;
/*!40000 ALTER TABLE `prod` DISABLE KEYS */;
INSERT INTO `prod` VALUES
(3,1,'Принтер \"Фабрика Печати\" EPSON M105, Wi-Fi, монохромный',9990.00),
(5,1,'Принтер CR768A HP OfficeJet 7110, A3, Wi-Fi',7320.00),
(6,1,'Фотопринтер \"Фабрика Печати\" EPSON L120',9290.00),
(7,1,'Фотопринтер \"Фабрика Печати\" EPSON L800',16490.00),
(8,1,'Принтер HP CE651A LaserJet P1102',4690.00),
(9,1,'Принтер HP CE658A LaserJet P1102W, WiFi',6990.00),
(10,1,'Принтер Canon LBP-6020B',4590.00),
(11,1,'Фотопринтер Canon Pixma iP7240',4990.00),
(12,1,'Принтер/копир/сканер Kyocera FS-1025MFP, лазерный',7990.00),
(13,1,'Принтер/копир/сканер Kyocera M2035DN, лазерный',15990.00),
(14,1,'Принтер/копир/сканер Kyocera M2530DN, лазерный',12779.00),
(15,2,'Картридж HP 51645A-E №45 (чёрный, повышенной ёмкости; 1000 стр.)',2999.00),
(16,2,'Картридж HP C9351B-E №21b (чёрный)',899.00),
(17,2,'Картридж HP C9351C-E №21XL (чёрный, повышенной емкости)',1999.00),
(18,2,'Картридж HP C9352A-E №22 (цветной)',1699.00),
(19,2,'Картридж Epson T03814A (чёрный)',495.00),
(20,2,'Картридж Epson T03904A (цветной)',309.00),
(21,2,'Картридж Epson T041040 (цветной; 300 стр.)',489.00),
(22,2,'Набор картриджей Epson T048740 (чёрный, голубой, пурпурный, жёлтый, св.голубой, св.пурпурный)',4299.00),
(23,2,'Тонер-картридж Kyocera TK-1120 (3000 стр.)',2999.00),
(24,2,'Тонер-картридж Kyocera TK-895K (чёрный)',3995.00),
(25,2,'Тонер-картридж Kyocera ТК-20H оригинальный (20000 стр.)',219.00),
(26,2,'Картридж Canon BCI-24-Bk (2шт, чёрный)',595.00),
(27,2,'Картридж Canon BCI-3-e-C (голубой)',129.00),
(28,2,'Картридж Canon BCI-3-e-M (пурпурный)',129.00),
(29,2,'Картридж Canon BCI-3-e-Y (жёлтый)',129.00),
(30,2,'Набор картриджей Canon BCI-3e (голубой, пурпурный, жёлтый)',219.00),
(31,3,'Компьютер Apple Mac Pro MD878RU/A (Intel Xeon E5 3.5 ГГц (6 ядер) / 16 / 256 SSD / 2 x AMD FirePro D500)',249990.00),
(32,3,'Компьютер HP ProDesk 600 mini i5-4570T/4/500/W8.1Pro+W7Pro/kbd+mouse [F6X25EA]',38999.00),
(33,3,'Компьютер HP 110-301NR i3-3240T/4GB/500/Multi/Linux/kbd+mouse (J2F73EA)',20999.00),
(34,3,'Компьютер Intel STICK Atom-Z3735F, 2Gb, Win 8.1 [BOXSTCK1A32WFC], HDMI-Stick',12999.00),
(35,3,'Неттоп Lenovo IdeaCentre Q190 P2127U/2/ 500/WiFi/W8.1 [57328438]',19999.00),
(36,3,'Неттоп Lenovo IdeaCentre Q190 i3-3217U/2/500/WiFi/ DOS [57319618]',21999.00),
(37,3,'Неттоп Acer Veriton N2120G E1-2650/4/500/WiFi/kb/m/DOS',15999.00),
(38,3,'Неттоп Acer Veriton N4630G G1840T/2/320/WiFi/ DOS',16999.00),
(39,4,'Повторитель TP-link TL-WA850RE универсальный',2199.00),
(40,4,'Tочка доступа/Маршрутизатор IEEE802.11n Asus RT-N66U',8299.00),
(41,4,'Tочка доступа IEEE802.11n D-Link DAP-2310',2999.00),
(42,4,'Адаптер USB - IEEE802.11n TP-LINK TL-WN822N',999.00),
(43,4,'Точка доступа/Маршрутизатор IEEE802.11n TP-Link TL-WR842ND',1999.00),
(44,4,'Tочка доступа/Маршрутизатор IEEE802.11n TP-link TL-WR841N 300Мбит/сек',1399.00),
(45,5,'Монитор Apple Thunderbolt Display 27\" [MC914ZE/B]',63990.00),
(46,5,'Монитор 27\" Dell Professional P2714H IPS черный',20999.00),
(47,5,'Монитор 22\" ACER V226HQLAbd VA LED DVI',7999.00),
(48,5,'Монитор 19\" Philips 196V4LAB2 DVI LED',5999.00),
(49,5,'Монитор 19\" Philips 193V5LSB2/10/62 LED Black',6199.00),
(50,5,'Монитор 20\" ViewSonic VA2046a-LED',6999.00),
(51,5,'Монитор 22\" Samsung SyncMaster S22D390Q IPS',8999.00),
(52,5,'Монитор 24\" LG 24MP57D-P IPS LED DVI',10999.00),
(53,1,'Сканер Canon CanoScan LIDE 220',4190.00),
(54,1,'Сканер Epson Perfection V37',7990.00),
(55,1,'Сканер HP L1956A ScanJet G4010',8799.00);
/*!40000 ALTER TABLE `prod` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-10 13:32:19

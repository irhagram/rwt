-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.0.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rwt
CREATE DATABASE IF NOT EXISTS `rwt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `rwt`;

-- Dumping structure for table rwt.kendaraan
CREATE TABLE IF NOT EXISTS `kendaraan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spawn` longtext NOT NULL,
  `modifan` longtext NOT NULL DEFAULT '{}',
  `meta` longtext NOT NULL DEFAULT '{}',
  `owner` longtext DEFAULT NULL,
  `plate` varchar(8) DEFAULT NULL,
  `state` int(11) DEFAULT 1,
  `garage` varchar(50) DEFAULT 'balkot',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rwt.kendaraan: ~1 rows (approximately)
INSERT INTO `kendaraan` (`id`, `spawn`, `modifan`, `meta`, `owner`, `plate`, `state`, `garage`) VALUES
	(1, 'sultan2', '{}', '{"fuel":65.0,"engine":974.5650634765625,"body":966.0867309570313}', 'steam:11000010afbb060', '20PLI677', 1, 'balkot');

-- Dumping structure for table rwt.warga
CREATE TABLE IF NOT EXISTS `warga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` longtext NOT NULL,
  `identifier` longtext NOT NULL,
  `groups` longtext NOT NULL DEFAULT '{}',
  `playerdata` longtext NOT NULL DEFAULT '{}',
  `metadata` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table rwt.warga: ~1 rows (approximately)
INSERT INTO `warga` (`id`, `nama`, `identifier`, `groups`, `playerdata`, `metadata`) VALUES
	(9, 'TheIrham', 'steam:11000010afbb060', '[{"tipe":"job","label":"Kaum Deadwood","pangkat":[{"gaji":200,"label":"Nganggur"}]}]', '{"namadepan":"The","tinggi":144,"kelamin":"cewek","namabelakang":"Irham","model":"mp_f_freemode_01","identifier":"steam:11000010afbb060","groups":[{"pangkat":[{"label":"Nganggur","gaji":200}],"label":"Kaum Deadwood","tipe":"job"}],"duit":{"bank":500,"tunai":500},"lokasi":{"x":-417.9296569824219,"y":1230.6329345703126,"z":325.75244140625,"w":331.6535339355469},"lahir":"2023-09-08 00:00:00"}', '{}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

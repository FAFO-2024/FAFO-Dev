-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table qbcoreframework_d57f82.snipe_apartments
CREATE TABLE IF NOT EXISTS `snipe_apartments` (
  `identifier` varchar(100) NOT NULL,
  `expires_on` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

CREATE TABLE IF NOT EXISTS `snipe_apartments_furniture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `offsetPos` longtext DEFAULT NULL,
  `rotation` longtext DEFAULT NULL,
  `roomHeading` double DEFAULT NULL,
  `isDoor` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_snipe_apartments_furniture_snipe_apartments` (`identifier`),
  CONSTRAINT `FK_snipe_apartments_furniture_snipe_apartments` FOREIGN KEY (`identifier`) REFERENCES `snipe_apartments` (`identifier`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

CREATE TABLE IF NOT EXISTS `snipe_apartments_stashoutfit` (
  `identifier` varchar(80) DEFAULT NULL,
  `stash_pos` longtext DEFAULT NULL,
  `outfit_pos` longtext DEFAULT NULL,
  `stash_heading` double DEFAULT NULL,
  `outfit_heading` double DEFAULT NULL,
  `stash_id` varchar(50) DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`),
  CONSTRAINT `FK_snipe_apartments_stashoutfit_snipe_apartments` FOREIGN KEY (`identifier`) REFERENCES `snipe_apartments` (`identifier`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
CREATE TABLE IF NOT EXISTS `snipe_apartments_state` (
  `identifier` varchar(100) DEFAULT NULL,
  `inRoom` enum('1','0') DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `snipe_apartments_keys` (
  `owner_id` varchar(100) DEFAULT NULL,
  `key_id` varchar(100) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `FK_snipe_apartments_keys_snipe_apartments` FOREIGN KEY (`owner_id`) REFERENCES `snipe_apartments` (`identifier`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

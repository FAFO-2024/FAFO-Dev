
CREATE TABLE IF NOT EXISTS `mboss_employees` (
  `identifier` longtext DEFAULT NULL,
  `company` longtext DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `profilepicture` longtext DEFAULT NULL,
  `rankLabel` longtext DEFAULT NULL,
  `jobLabel` longtext DEFAULT NULL,
  `joindate` longtext DEFAULT NULL,
  `badgenumber` longtext DEFAULT NULL,
  `certifications` longtext DEFAULT NULL,
  `online` int(11) DEFAULT NULL,
  `rankLevel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_employees`;

CREATE TABLE IF NOT EXISTS `mboss_general` (
  `company` longtext NOT NULL,
  `vault` longtext NOT NULL,
  `logo` longtext DEFAULT NULL,
  `bossrank` longtext DEFAULT NULL,
  `pageaccess` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `companylabel` longtext DEFAULT NULL,
  `creationdate` longtext DEFAULT NULL,
  `theme` longtext DEFAULT NULL,
  `inventoryDisabled` longtext DEFAULT NULL,
  `vaultDisabled` longtext DEFAULT NULL,
  `vault_income` int(11) DEFAULT NULL,
  `vault_expense` int(11) DEFAULT NULL,
  UNIQUE KEY `name` (`company`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_general`;

CREATE TABLE IF NOT EXISTS `mboss_general_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `identifier` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_general_logs`;

CREATE TABLE IF NOT EXISTS `mboss_inventory` (
  `jobname` varchar(50) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_inventory`;

CREATE TABLE IF NOT EXISTS `mboss_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `preset_code` longtext DEFAULT NULL,
  `preset_name` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_outfits`;

CREATE TABLE IF NOT EXISTS `mboss_permissions` (
  `company` varchar(50) NOT NULL DEFAULT '',
  `ranklevel` varchar(50) NOT NULL DEFAULT '',
  `permissions` longtext DEFAULT NULL,
  PRIMARY KEY (`company`,`ranklevel`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_permissions`;

CREATE TABLE IF NOT EXISTS `mboss_vault_logs` (
  `company` longtext DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

DELETE FROM `mboss_vault_logs`;


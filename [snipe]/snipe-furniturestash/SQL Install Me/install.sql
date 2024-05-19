CREATE TABLE IF NOT EXISTS `snipe_furniture_stash` (
  `identifier` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `offsetPos` longtext DEFAULT NULL,
  `heading` double DEFAULT NULL,
  `roomHeading` double DEFAULT NULL,
  `stash_id` varchar(50) DEFAULT NULL,
  `itemName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
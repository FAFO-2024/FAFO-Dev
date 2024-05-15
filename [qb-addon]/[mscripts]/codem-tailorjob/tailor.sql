
CREATE TABLE IF NOT EXISTS `tailor_players` (
  `identifier` longtext DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `xp` int(11) DEFAULT NULL,
  `logo` longtext DEFAULT NULL,
  `machines` longtext DEFAULT NULL,
  `vault` int(11) DEFAULT NULL,
  `logs` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `workers` longtext DEFAULT NULL,
  `orders` longtext DEFAULT NULL,
  `playerName` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

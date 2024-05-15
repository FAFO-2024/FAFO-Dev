
-- tablo yapısı dökülüyor esxlegacy_e488fc.codem_minerjob
CREATE TABLE IF NOT EXISTS `codem_minerjob` (
  `identifier` longtext DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `xp` int(11) DEFAULT NULL,
  `gatheredOres` int(11) DEFAULT NULL,
  `createdAt` int(11) DEFAULT NULL,
  `totalEarnings` int(11) DEFAULT NULL,
  `avatar` longtext DEFAULT NULL,
  `dailyMissions` longtext DEFAULT NULL,
  `latestWorks` longtext DEFAULT NULL,
  `completedShipments` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

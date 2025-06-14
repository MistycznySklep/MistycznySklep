CREATE TABLE `cash_codes` (
  `idCash_codes` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `code` varchar(30) NOT NULL,
  `isUsed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


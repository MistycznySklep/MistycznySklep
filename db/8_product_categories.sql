CREATE TABLE `product_categories` (
  `idProduct_categories` int(11) NOT NULL PRIMARY KEY,
  `category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `product_categories` (`idProduct_categories`, `category`) VALUES
(1, 'Wyposażenie'),
(2, 'Kwiaty'),
(3, 'Grzyby'),
(4, 'Narośl'),
(5, 'Nasiona'),
(6, 'Owoce'),
(7, 'Warzywa'),
(8, 'Eliksiry');

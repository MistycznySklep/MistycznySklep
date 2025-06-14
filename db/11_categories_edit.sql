ALTER TABLE products CHANGE idProduct_categories
idProduct_subcategories INT(11) NOT NULL;

CREATE TABLE `categories` (
  `idCategories` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `category` varchar(50) NOT NULL
) 

INSERT INTO `categories` (`idCategories`, `category`) VALUES
(1, 'Rośliny'),
(2, 'Eliksiry'),
(3, 'Wyposażenie');
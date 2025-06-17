CREATE DATABASE lumoflor_database;

CREATE TABLE `accounts` (
  `idAccounts` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `login` varchar(50) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(50),
  `type` enum('user','admin','employee') NOT NULL,
  `balance` double(10,2) NOT NULL
);

CREATE TABLE `inventory` (
  `idInventory` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
);

CREATE TABLE `employees` (
  `idEmployees` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `idAccounts` int(11) NOT NULL
);

CREATE TABLE `products` (
  `idProducts` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('Sprzęt','Kwiaty','Grzyby','Narośl','Pielęgnacja','Nasiona','Owoce','Warzywa') NOT NULL,
  `price` double(10,2) NOT NULL,
  `description` text NOT NULL,
  `description2` text NOT NULL,
  `quantity` int(5) NOT NULL,
  `hexColor` varchar(10) NOT NULL,
  `status` enum('Dostępny','Wyprzedany') NOT NULL,
  `product_img` longblob NOT NULL
);

CREATE TABLE `order_details` (
  `idOrder_Details` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `idOrders` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(10,2) NOT NULL
);

CREATE TABLE `orders` (
  `idOrders` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `idEmployees` int(11) NOT NULL,
  `price` double(10,2) NOT NULL,
  `status` enum('Oczekujący na zatwierdzenie','Zatwierdzony','Odrzucony') NOT NULL
);

CREATE TABLE `returns` (
  `idReturns` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  `idOrders` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL
);

ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_accounts_inventory` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_products_inventory` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`);


ALTER TABLE `employees`
  ADD CONSTRAINT `fk_accounts_employees` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);


ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_products_order_details` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`),
  ADD CONSTRAINT `fk_orders_order_details` FOREIGN KEY (`idOrders`) REFERENCES `orders` (`idOrders`);


ALTER TABLE `orders`
  ADD CONSTRAINT `fk_accounts_orders` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_employees_orders` FOREIGN KEY (`idEmployees`) REFERENCES `employees` (`idEmployees`);


ALTER TABLE `returns`
  ADD CONSTRAINT `fk_orders_returns` FOREIGN KEY (`idOrders`) REFERENCES `orders` (`idOrders`);
COMMIT;

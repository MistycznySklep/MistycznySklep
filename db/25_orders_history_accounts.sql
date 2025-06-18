CREATE TABLE `orders_history` (
  `idOrdersHistory` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `idAccounts` int(11) NOT NULL,
  `final_cost` int(11) NOT NULL
);


CREATE TABLE `orders_history_products` (
  `idOrdersHistoryProducts` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `idOrdersHistory` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL
);

ALTER TABLE `orders_history_products`
  ADD CONSTRAINT `fk_products_orders_history_products` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`),
  ADD CONSTRAINT `fk_orders_history_products_orders_history` FOREIGN KEY (`idOrdersHistory`) REFERENCES `orders_history` (`idOrdersHistory`);

ALTER TABLE `orders_history`
    ADD CONSTRAINT `fk_orders_history_products_accounts` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);
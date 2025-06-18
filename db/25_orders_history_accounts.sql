CREATE TABLE `orders_history` (
  `idOrdersHistory` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `idAccounts` int(11) NOT NULL,
  `final_cost` int(11) NOT NULL
);


CREATE TABLE `orders_history_accounts` (
  `idOrdersHistoryAccounts` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `idOrdersHistory` int(11) NOT NULL,
  `idAccounts` int(11) NOT NULL
);

ALTER TABLE `orders_history_accounts`
  ADD CONSTRAINT `fk_accounts_accounts_orders_history` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_orders_history_accounts_orders_history` FOREIGN KEY (`idOrdersHistory`) REFERENCES `orders_history` (`idOrdersHistory`);

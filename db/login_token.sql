CREATE TABLE `login_token` (
    `idLogin_token` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `value` varchar(255) NOT NULL,
    `user_agent` varchar(255) NOT NULL,
    `idAccounts` int(11) NOT NULL,
);

ALTER TABLE `login_token`
    ADD CONSTRAINT `fk_accounts_login_token` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);        
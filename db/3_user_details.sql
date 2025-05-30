CREATE TABLE `user_details` (
    `idUser_details` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `description` varchar(255) NOT NULL,
    `phone_number` int(11) NOT NULL,
    `profile_picture` longblob NOT NULL,
    `idAccounts` int(11) NOT NULL,
);

ALTER TABLE `user_details`
    ADD CONSTRAINT `fk_accounts_user_details` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);  
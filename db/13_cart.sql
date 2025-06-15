CREATE TABLE `carts` (
  `idCarts` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `idAccounts` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
)








ALTER TABLE carts ADD CONSTRAINT fk_accounts_carts FOREIGN KEY(idAccounts) REFERENCES accounts(idAccounts); 

ALTER TABLE carts ADD CONSTRAINT fk_products_carts FOREIGN KEY(idProducts) REFERENCES products(idProducts); 
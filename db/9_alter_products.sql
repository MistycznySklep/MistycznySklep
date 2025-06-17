ALTER TABLE `products` CHANGE `type` `idProduct_categories` INT(11) NOT NULL;

UPDATE products SET idProduct_categories = '5' WHERE products.idProducts = 6;
UPDATE products SET idProduct_categories = '5' WHERE products.idProducts = 7;
UPDATE products SET idProduct_categories = '5' WHERE products.idProducts = 8;
UPDATE products SET idProduct_categories = '5' WHERE products.idProducts = 9;
UPDATE products SET idProduct_categories = '5' WHERE products.idProducts = 10;


ALTER TABLE products ADD CONSTRAINT fk_product_categories_products FOREIGN KEY (idProduct_categories) REFERENCES product_categories(idProduct_categories);


INSERT INTO 
products 
(idProducts, name, idProduct_categories, price, description, description2, quantity, hexColor, idImgs) 
VALUES 
('11', 'Eliksir wzrostu', '8', '33.15', 'Eliksir przyśpieszający wzrost roślin. Podlewać do 200ml dziennie (przekroczenie grozi mutacją rośliny)', NULL, '15', '#ED52C6', '11'), 
('12', 'Eliksir uspokajający', '8', '42.70', 'Eliksir, który uspokaja agresywne rośliny. Działa do 7 dni roboczych. NIE STOSOWAĆ NA LUDZIACH!!!', NULL, '46', '#43AF15', '12'), 
('13', 'Eliksir Ocieplenia', '8', '22.50', 'Podgrzewa rośliny wymagające ciepłych warunków do wyrośnięcia. Przydatne podczas zimy.', NULL, '115', '#FE8B00', '13'), 
('14', 'Eliksir Ochronny', '8', '71.89', 'Po podlaniu ochrania rośliny przed wszelkim rodzajem uszkodzeń, czy to przez szkodniki lub inne rośliny! Trwa 24h na 100ml', NULL, '71', '#92CDFF', '14'), 
('15', 'Diamentowe nożyce', '1', '62.18', 'Nożyce ogrodnicze stworzone z diamentu. Przetną nawet najtwardze rośliny.', NULL, '117', '#70A8A8', '15'), 
('16', 'Rękawice Termiczne', '1', '207.00', 'Rękawice stworzone z chłonnego materiału. Blokują wszelkiego rodzaju ciepło i chronią przed poparzeniem.', NULL, '11', '#B25655', '16'), 
('17', 'Zmiennokształna Doniczka', '1', '20.90', 'Doniczka ze specjalną właściwością, potrafi się na bieżąco dostosować do rośliny.', NULL, '225', '#BC3B34', '17'), 
('18', 'Szmaragdowa Łopata', '1', '91.25', 'Łopata jest praktycznie niezniszczalna. Pobiera siłę przez co kopanie jest łatwiejsze w jakiś sposób.', NULL, '13', '#409E50', '18');

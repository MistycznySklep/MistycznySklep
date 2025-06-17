ALTER TABLE products DROP FOREIGN KEY fk_product_categories_products;

ALTER TABLE product_categories CHANGE idProduct_categories idProduct_subcategories INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE products ADD CONSTRAINT fk_product_subcategories_products FOREIGN KEY (idProduct_subcategories) REFERENCES product_categories(idProduct_subcategories);

ALTER TABLE product_categories CHANGE category
subcategory VARCHAR(100) NOT NULL;

ALTER TABLE product_categories RENAME TO product_subcategories;


ALTER TABLE `product_subcategories` ADD `idCategories` INT NOT NULL AFTER `idProduct_subcategories`;

UPDATE `product_subcategories` SET `idCategories` = '3' WHERE `product_subcategories`.`idProduct_subcategories` = 1; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 2; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 3; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 4; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 5; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 6; 
UPDATE `product_subcategories` SET `idCategories` = '1' WHERE `product_subcategories`.`idProduct_subcategories` = 7; 
UPDATE `product_subcategories` SET `idCategories` = '3' WHERE `product_subcategories`.`idProduct_subcategories` = 8; 

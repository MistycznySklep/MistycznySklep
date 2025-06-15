UPDATE categories SET category = 'Nasiona' WHERE categories.idCategories = 2;
UPDATE categories SET category = 'Eliksiry' WHERE categories.idCategories = 3;
INSERT INTO categories (idCategories, category) VALUES ('4', 'Wyposażenie');

UPDATE product_subcategories SET idCategories = '4' WHERE product_subcategories.idProduct_subcategories = 1;
UPDATE product_subcategories SET idCategories = '2' WHERE product_subcategories.idProduct_subcategories = 5;
ALTER TABLE `products` CHANGE `product_img` `idImgs` INT NOT NULL;
ALTER TABLE `products` CHANGE `description2` `description2` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL;


INSERT INTO products VALUES(1, 'Świecący Grzyb', 'Grzyby', 90.00, 'Świecący Grzyb. Zaczyna świecić dopiero po pełnym wyrosnięciu. Emituje światło niebieskie więc chyba złe dla twoich oczu.', NULL, 115, '#4db8b4', 1),

(2, 'Odbijogódki', 'Owoce', 12.00, 'Odbijające się jagody. Mają skorupę zrobioną z kauczuku i betaniny. Jadalne. Zawierają beton.', NULL, 43, '#FF0037', 2),

(3, 'Płomienny Tulipan', 'Kwiaty', 100.00, 'Wiecznie palący się kwiat, sprowadzony prosto z odchłani wulkanicznych jaskiń.', NULL, 23, '#e68116', 3),

(4, 'Woskogrzyby', 'Grzyby', 54.00, 'Grzyby, których pień jest zbudowany z wosku. Różowy kapelusz jest bardzo słodki (1kg cukru na sztukę!).', NULL, 55, '#C493AA', 4),

(5, 'Kiełek', 'Kwiaty', 78.00, 'Mięsożerna roślina. Lubi zjadać różnego rodzaju owady. Nie zostawiaj jej sam na sam z człowiekiem!', NULL, 211, '#DA916F', 5),

(6, 'Świecący Grzyb', 'Nasiona', 0.00, 'Zarodniki świecących grzybów. Przechowywać na słońcu - pobiera promienie UV.', NULL, 0, '#4db8b4', 6),

(7, 'Odbijogódki', 'Nasiona', 20.00, 'Nasiona Odbijogódek. Pokryte odbijającą kauczukową skorupą nachłoniętą betaniną. UWAGA! Produkt może zawierać beton.', NULL, 155, '#FF0037', 7),

(8, 'Płomienny Tulipan', 'Nasiona', 52.00, 'Obsydianowe nasiona płomiennego Tulipana. Zasadzić w spalonej lub wulkanicznej ziemii.', '', 45, '#e68116', 8),

(9, 'Woskogrzyby', 'Nasiona', 20.00, 'Grzybnia wewnątrz wosku. Po włożeniu do piekarnika nasiona są niezdatne do zakiełkowania', '', 81, '#C493AA', 9),

(10, 'Kiełek', 'Nasiona', 40.00, 'Nasiona kiełka. Kwiat otworzy się dopiero po piętnastu dniach roboczych i dwóch urlopach.', '', 32, '#DA916F', 10);

CREATE TABLE `imgs` (
  `idImgs` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `imgs` (`idImgs`, `name`) VALUES ('1', 'Swiecacy_grzyb'), ('2', 'Odbijogodki'), ('3', 'Plomienny_tulipan'), ('4', 'Woskogrzyby'), ('5', 'Kielek'), ('6', 'Swiecacy_grzyb_seeds'), ('7', 'Odbijogodki_seeds'), ('8', 'Plomienny_tulipan_seeds'), ('9', 'Woskogrzyby_seeds'), ('10', 'Kielek_seeds');


ALTER TABLE products ADD CONSTRAINT fk_imgs_products FOREIGN KEY(idImgs) REFERENCES imgs(idImgs);



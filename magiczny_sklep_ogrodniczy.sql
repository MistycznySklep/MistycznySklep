-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Maj 24, 2025 at 06:18 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `magiczny_sklep_ogrodniczy`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `konta`
--

CREATE TABLE `konta` (
  `idKonta` int(11) NOT NULL,
  `login` int(11) NOT NULL,
  `hasło` text NOT NULL,
  `typ` enum('user','admin','employee') NOT NULL,
  `stan_konta` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `magazyn_klienta`
--

CREATE TABLE `magazyn_klienta` (
  `idMagazyn_klienta` int(11) NOT NULL,
  `idKonta` int(11) NOT NULL,
  `idProdukty` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `idPracownicy` int(11) NOT NULL,
  `imie` varchar(50) NOT NULL,
  `nazwisko` varchar(50) NOT NULL,
  `idKonta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `idProdukty` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `typ` enum('roslina','pielegnacja roslin') NOT NULL,
  `cena` double(10,2) NOT NULL,
  `ilosc` int(5) NOT NULL,
  `status` enum('dostepny','wyprzedany') NOT NULL,
  `zdjecie_produktu` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `szczegoly_zamowienia`
--

CREATE TABLE `szczegoly_zamowienia` (
  `idSzczegoly_Zamowienia` int(11) NOT NULL,
  `idZamowienia` int(11) NOT NULL,
  `idProdukty` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL,
  `cena` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienia`
--

CREATE TABLE `zamowienia` (
  `idZamowienia` int(11) NOT NULL,
  `idKonta` int(11) NOT NULL,
  `idPracownicy` int(11) NOT NULL,
  `cena` double(10,2) NOT NULL,
  `status` enum('oczekujacy na zatwierdzenie','zatwierdzony','odrzucony') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zwroty`
--

CREATE TABLE `zwroty` (
  `idZwroty` int(11) NOT NULL,
  `idZamowienia` int(11) NOT NULL,
  `idProdukty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `konta`
--
ALTER TABLE `konta`
  ADD PRIMARY KEY (`idKonta`);

--
-- Indeksy dla tabeli `magazyn_klienta`
--
ALTER TABLE `magazyn_klienta`
  ADD PRIMARY KEY (`idMagazyn_klienta`),
  ADD KEY `fk_konta_magazyn_klienta` (`idKonta`),
  ADD KEY `fk_produkty_magazyn_klienta` (`idProdukty`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`idPracownicy`),
  ADD KEY `fk_konta_pracownicy` (`idKonta`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`idProdukty`);

--
-- Indeksy dla tabeli `szczegoly_zamowienia`
--
ALTER TABLE `szczegoly_zamowienia`
  ADD PRIMARY KEY (`idSzczegoly_Zamowienia`),
  ADD KEY `fk_zamowienia_szczegoly_zamowienia` (`idZamowienia`),
  ADD KEY `fk_produkty_szczegoly_zamowienia` (`idProdukty`);

--
-- Indeksy dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD PRIMARY KEY (`idZamowienia`),
  ADD KEY `fk_konta_zamowienia` (`idKonta`),
  ADD KEY `fk_pracownicy_zamowienia` (`idPracownicy`);

--
-- Indeksy dla tabeli `zwroty`
--
ALTER TABLE `zwroty`
  ADD PRIMARY KEY (`idZwroty`),
  ADD KEY `fk_zamowienia_zwroty` (`idZamowienia`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `konta`
--
ALTER TABLE `konta`
  MODIFY `idKonta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `magazyn_klienta`
--
ALTER TABLE `magazyn_klienta`
  MODIFY `idMagazyn_klienta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `idPracownicy` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produkty`
--
ALTER TABLE `produkty`
  MODIFY `idProdukty` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `szczegoly_zamowienia`
--
ALTER TABLE `szczegoly_zamowienia`
  MODIFY `idSzczegoly_Zamowienia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zamowienia`
--
ALTER TABLE `zamowienia`
  MODIFY `idZamowienia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zwroty`
--
ALTER TABLE `zwroty`
  MODIFY `idZwroty` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `magazyn_klienta`
--
ALTER TABLE `magazyn_klienta`
  ADD CONSTRAINT `fk_konta_magazyn_klienta` FOREIGN KEY (`idKonta`) REFERENCES `konta` (`idKonta`),
  ADD CONSTRAINT `fk_produkty_magazyn_klienta` FOREIGN KEY (`idProdukty`) REFERENCES `produkty` (`idProdukty`);

--
-- Constraints for table `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD CONSTRAINT `fk_konta_pracownicy` FOREIGN KEY (`idKonta`) REFERENCES `konta` (`idKonta`);

--
-- Constraints for table `szczegoly_zamowienia`
--
ALTER TABLE `szczegoly_zamowienia`
  ADD CONSTRAINT `fk_produkty_szczegoly_zamowienia` FOREIGN KEY (`idProdukty`) REFERENCES `produkty` (`idProdukty`),
  ADD CONSTRAINT `fk_zamowienia_szczegoly_zamowienia` FOREIGN KEY (`idZamowienia`) REFERENCES `zamowienia` (`idZamowienia`);

--
-- Constraints for table `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD CONSTRAINT `fk_konta_zamowienia` FOREIGN KEY (`idKonta`) REFERENCES `konta` (`idKonta`),
  ADD CONSTRAINT `fk_pracownicy_zamowienia` FOREIGN KEY (`idPracownicy`) REFERENCES `pracownicy` (`idPracownicy`);

--
-- Constraints for table `zwroty`
--
ALTER TABLE `zwroty`
  ADD CONSTRAINT `fk_zamowienia_zwroty` FOREIGN KEY (`idZamowienia`) REFERENCES `zamowienia` (`idZamowienia`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

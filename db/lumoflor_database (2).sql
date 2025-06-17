-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Cze 17, 2025 at 11:56 PM
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
-- Database: `lumoflor_database`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `accounts`
--

CREATE TABLE `accounts` (
  `idAccounts` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` char(60) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `type` enum('user','admin','employee') NOT NULL,
  `balance` double(10,2) NOT NULL,
  `MFA_token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `idDetails` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin_log_details`
--

CREATE TABLE `admin_log_details` (
  `id` int(11) NOT NULL,
  `idAccount` int(11) DEFAULT NULL,
  `idToken` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin_log_type`
--

CREATE TABLE `admin_log_type` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_log_type`
--

INSERT INTO `admin_log_type` (`id`, `name`) VALUES
(1, 'Nowe konto'),
(2, 'Nieudane logowanie'),
(3, 'Ok logowanie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `awaiting_mfas`
--

CREATE TABLE `awaiting_mfas` (
  `id` int(11) NOT NULL,
  `token` text NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `generated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `awaiting_mfa_logins`
--

CREATE TABLE `awaiting_mfa_logins` (
  `id` int(11) NOT NULL,
  `token` text NOT NULL,
  `expires_at` datetime NOT NULL,
  `idAccounts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `carts`
--

CREATE TABLE `carts` (
  `idCarts` int(11) NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cash_codes`
--

CREATE TABLE `cash_codes` (
  `idCash_codes` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `isUsed` tinyint(1) NOT NULL,
  `value` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `categories`
--

CREATE TABLE `categories` (
  `idCategories` int(11) NOT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`idCategories`, `category`) VALUES
(1, 'Rośliny'),
(2, 'Nasiona'),
(3, 'Eliksiry'),
(4, 'Wyposażenie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employees`
--

CREATE TABLE `employees` (
  `idEmployees` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `idAccounts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `imgs`
--

CREATE TABLE `imgs` (
  `idImgs` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imgs`
--

INSERT INTO `imgs` (`idImgs`, `name`) VALUES
(1, 'Swiecacy_grzyb'),
(2, 'Odbijogodki'),
(3, 'Plomienny_tulipan'),
(4, 'Woskogrzyby'),
(5, 'Kielek'),
(6, 'Swiecacy_grzyb_seeds'),
(7, 'Odbijogodki_seeds'),
(8, 'Plomienny_tulipan_seeds'),
(9, 'Woskogrzyby_seeds'),
(10, 'Kielek_seeds'),
(11, 'Eliskir_wzrostu'),
(12, 'Eliksir_uspokajajacy'),
(13, 'Eliksir_ocieplenia'),
(14, 'Eliksir_ochronny'),
(15, 'Diamentowe_nozyca'),
(16, 'Rekawice_termiczna'),
(17, 'Zmiennoksztaltna_doniczka'),
(18, 'Szmaragdowa_lopata');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `inventory`
--

CREATE TABLE `inventory` (
  `idInventory` int(11) NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `login_token`
--

CREATE TABLE `login_token` (
  `idLogin_token` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `expires_at` date NOT NULL,
  `last_ip` varbinary(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `idOrders` int(11) NOT NULL,
  `idAccounts` int(11) NOT NULL,
  `idEmployees` int(11) NOT NULL,
  `price` double(10,2) NOT NULL,
  `status` enum('Oczekujący na zatwierdzenie','Zatwierdzony','Odrzucony') NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_details`
--

CREATE TABLE `order_details` (
  `idOrder_Details` int(11) NOT NULL,
  `idOrders` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `idProducts` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `idProduct_subcategories` int(11) NOT NULL,
  `price` double(10,2) NOT NULL,
  `description` text NOT NULL,
  `description2` text DEFAULT NULL,
  `quantity` int(5) NOT NULL,
  `hexColor` varchar(10) NOT NULL,
  `idImgs` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`idProducts`, `name`, `idProduct_subcategories`, `price`, `description`, `description2`, `quantity`, `hexColor`, `idImgs`) VALUES
(1, 'Świecący Grzyb', 3, 90.00, 'Świecący Grzyb. Zaczyna świecić dopiero po pełnym wyrosnięciu. Emituje światło niebieskie więc chyba złe dla twoich oczu.', 'Świecący Grzyb to niewielki, ale niezwykle charakterystyczny organizm występujący w jaskiniach, również w tych wewnątrz pokoi informatyków. Osiąga do 30 cm wysokości, z kapeluszem szerokim na około 8 cm. W młodym stadium jest ciemny i matowy, ale po pełnym dojrzeniu zaczyna emitować intensywne, chłodne niebieskie światło. Świecący Grzyb ujawnia to, co ukryte – pod jego światłem niewidzialne staje się widzialne, a iluzje tracą moc. Dlatego bywa wykorzystywany przez magów do wykrywania zaklęć iluzji, ukrytych przejść lub duchów.', 115, '#4db8b4', 1),
(2, 'Odbijogódki', 6, 12.00, 'Odbijające się jagody. Mają skorupę zrobioną z kauczuku i betaniny. Jadalne. Zawierają beton.', 'Odbijogódki to niewielkie jagody rosnące głównie na porzuconych placach budowy i skażonych e-paiperosami terenach miejskich. Ich owoce – intensywnie czerwone jagody o błyszczącej, elastycznej skorupie – wyglądają apetycznie, lecz zachowują się zupełnie nieprzewidywalnie. Pokryte kauczukowatą warstwą zabarwioną naturalną betaniną, potrafią odbijać się od twardych powierzchni jak piłeczki, nierzadko zagrażając oczom lub nosom nieostrożnych zbieraczy. Co gorsza, niektóre egzemplarze zawierają w środku drobiny… betonu – nikt nie wie, jak się tam znalazły, ale ich spożycie nie kończy się tragicznie dla zębów, co najwyżej dla twojego żołądka.', 43, '#FF0037', 2),
(3, 'Płomienny Tulipan', 2, 100.00, 'Wiecznie palący się kwiat, sprowadzony prosto z otchłani wulkanicznych jaskiń.', 'Płomienny Tulipan to niezwykle rzadka i legendarna roślina, której płatki zdają się płonąć wiecznym, cichym ogniem. W przeciwieństwie do iluzji czy naturalnych bioluminescencyjnych zjawisk, jego płomień jest prawdziwy – emituje ciepło, nie niszcząc jednak samej rośliny. Z każdym powiewem wiatru płomienie tańczą na krawędziach płatków niczym żywe istoty, nie tracąc przy tym intensywności ani formy. Płomienny Tulipan pochodzi z głębokich trzewi świata – z Wulkanicznych Jaskiń Al’Zharra, ukrytych pod zgasłym, lecz wciąż aktywnym duchowo kraterem Góry Kresh-Tahar.', 23, '#e68116', 3),
(4, 'Woskogrzyby', 3, 54.00, 'Grzyby, których pień jest zbudowany z wosku. Różowy kapelusz jest bardzo słodki (1kg cukru na sztukę!).', 'Woskogrzyby to niezwykłe, półroślinne, półmineralne istoty grzybopodobne, które wyrastają pojedynczo lub w skupiskach przypominających różowe świece ułożone w kręgi. oskogrzyby występują naturalnie w Lesie Cukrowych Mgieł, położonym na obrzeżach magicznej krainy Słodkiej Otchłani – eterycznego rezerwatu między wymiarem snu a światem materialnym.', 55, '#C493AA', 4),
(5, 'Kiełek', 2, 78.00, 'Mięsożerna roślina. Lubi zjadać różnego rodzaju owady. Nie zostawiaj jej sam na sam z człowiekiem!', '„Zielona istota o zbyt ostrym apetycie.” Kiełek to pozornie niewinna, mała mięsożerna roślina, która w młodości przypomina zwykły pęd o jaskrawozielonych listkach i łodydze pokrytej meszkiem. Jednak już od wczesnych dni wykazuje wyraźny głód – z początku zadowala się owadami, potem małymi gryzoniami... aż w końcu zaczyna interesować się większymi formami życia. Co ważne – nie jest rośliną bezmyślną. Kiełek wykazuje instynkt łowiecki, a nawet zalążki inteligencji. Kiełek pochodzi z Topieli Zgniłego Poranka – mglistych, wiecznie wilgotnych bagien znajdujących się na granicy Królestwa Dziczy i Pustki Snów.', 211, '#DA916F', 5),
(6, 'Świecący Grzyb', 5, 0.00, 'Zarodniki świecących grzybów. Przechowywać na słońcu - pobiera promienie UV.', 'Zarodniki Świecącego Grzyba to mikroskopijne, srebrzysto-niebieski kuleczki, które delikatnie pulsują światłem, ledwie widocznym gołym okiem. Choć z pozoru niewielkie i kruche, zawierają w sobie olbrzymi potencjał energetyczny – są żywym magazynem światła UV, które wykorzystują do kiełkowania i wzrostu. W warunkach naturalnych zarodniki unoszą się w powietrzu nocą, osiadając tylko tam, gdzie panuje harmonia między ciepłem, światłem i spokojem. Zarodniki należy przechowywać na słońcu, najlepiej w przezroczystej fiolce z kryształowego szkła. Szkło powinno być odkażone eliksirem ochronnym, by nie dopuścić do ich zanieczyszczenia. Codzienna ekspozycja na światło UV (min. 3 godziny dziennie) jest kluczowa – bez niej zarodniki zapadają w stan uśpienia i mogą zginąć.', 0, '#4db8b4', 6),
(7, 'Odbijogódki', 5, 20.00, 'Nasiona Odbijogódek. Pokryte odbijającą kauczukową skorupą nachłoniętą betaniną. UWAGA! Produkt może zawierać beton.', 'Nasiona Odbijogódek są niewielkimi, eliptycznymi obiektami wielkości orzecha laskowego, pokrytymi połyskującą, elastyczną kauczukową skorupą, intensywnie zabarwioną betaniną – naturalnym barwnikiem o kolorze głębokiej buraczkowej czerwieni. Z wyglądu przypominają jaskrawe kulki do gry... i zachowują się podobnie. Każde nasiono ma naturalną zdolność odbicia się od niemal każdej powierzchni z nienaturalną siłą, co czyni ich wysiew aktem zarówno rolnictwa, jak i sportu ekstremalnego.', 155, '#FF0037', 7),
(8, 'Płomienny Tulipan', 5, 52.00, 'Obsydianowe nasiona płomiennego Tulipana. Zasadzić w spalonej lub wulkanicznej ziemii.', 'Nasiona tej ognistej rośliny mają postać twardych, czarnych bryłek przypominających miniaturowe kawałki obsydianu – ostre, lśniące, ciężkie jak na swój rozmiar. W ich wnętrzu tli się mikroskopijny płomyk, widoczny tylko przy całkowitym zaciemnieniu i w odpowiedniej temperaturze (powyżej 60°C).  Przy dotknięciu rozgrzewają się lekko – to znak, że „czuwają”. Nasiona są aktywne energetycznie, ale w stanie uśpienia, dopóki nie poczują prawdziwego ognia w ziemi. Nasiona muszą być zasadzone wyłącznie w glebie spalonej, wulkanicznej lub przepalonej przez magiczny ogień. Zwykła ziemia sprawi, że nasiono się zapiecze i nie wykiełkuje. ', 45, '#e68116', 8),
(9, 'Woskogrzyby', 5, 20.00, 'Grzybnia wewnątrz wosku. Po włożeniu do piekarnika nasiona są niezdatne do zakiełkowania', 'Nasiona Woskogrzybów to niewielkie, różowe kulki lub pręciki zatopione w lekko pachnącym, naturalnym wosku. Struktura zewnętrzna przypomina topniejącą świecę, ale wewnątrz znajduje się aktywna grzybnia – żywa, delikatna sieć magicznych włókien. W przeciwieństwie do wielu magicznych grzybów, Woskogrzyby są skrajnie wrażliwe na temperaturę. Włożenie nasion do piekarnika, pozostawienie ich w pobliżu źródła ciepła powyżej 40°C lub wystawienie na silne promienie słoneczne trwale niszczy grzybnię.', 81, '#C493AA', 9),
(10, 'Kiełek', 5, 40.00, 'Nasiona kiełka. Kwiat otworzy się dopiero po piętnastu dniach roboczych i dwóch urlopach.', 'Nasiona Kiełka to ziarnka o brązowej barwie, przypominające z wyglądu żołędzie, lecz znacznie twardsze. Wewnątrz znajduje się zaczątek rośliny mięsożernej – niezwykle cierpliwej, ale niepokojąco inteligentnej. Jej wzrost uzależniony jest od bardzo specyficznych warunków… w tym harmonogramu pracy. Nasiono może z czasem wykształcić minikły przedwczesnego wzrostu – ostre mięsaczki, które „testują teren”. Nie krwawią, ale szczypią złośliwie. ', 32, '#DA916F', 10),
(11, 'Eliksir wzrostu', 8, 33.15, 'Eliksir przyśpieszający wzrost roślin. Podlewać do 200ml dziennie (przekroczenie grozi mutacją rośliny)', 'Eliksir Wzrostu to błyszczący, jasnoróżowy płyn, delikatnie gęsty, o zapachu świeżo skoszonej trawy i nutą cytrynowego porostu. Jego mikroskopijne składniki magiczne działają bezpośrednio na strukturę tkanek roślinnych, stymulując błyskawiczne namnażanie komórek, asymilację magicznych minerałów i przyspieszoną fotosyntezę. Produkt wyjątkowo skuteczny – ale potężny. Nieodpowiednie użycie może prowadzić do mutacji, nieprzewidywalnych reakcji lub przejęcia inicjatywy przez samą roślinę...', 15, '#ED52C6', 11),
(12, 'Eliksir uspokajający', 8, 42.70, 'Eliksir, który uspokaja agresywne rośliny. Działa do 7 dni roboczych. NIE STOSOWAĆ NA LUDZIACH!!!', 'Eliksir Uspokajający to chłodny, zielony płyn, pachnący nieco jak deszcz po burzy i stary papier. Stworzony został przez dawnych alchemików do kontroli nastrojów szczególnie złośliwych okazów roślinnych, które przejawiają zbyt dużo emocji… lub zębów. Eliksir nie leczy, nie tresuje, tylko wycisza. Tworzy wokół rośliny aurę tłumienia reakcji agresywnych i skłonności do dramatyzmu botanicznego.', 46, '#43AF15', 12),
(13, 'Eliksir Ocieplenia', 8, 22.50, 'Podgrzewa rośliny wymagające ciepłych warunków do wyrośnięcia. Przydatne podczas zimy.', 'Eliksir Ocieplenia to gęsty, bursztynowo-pomarańczowy płyn, który wydziela ciepło niemal natychmiast po otwarciu. Jego aromat przypomina skondensowane słońce z dodatkiem lekko pikantnego imbiru i słodkich, dojrzałych owoców. Stworzony został z esencji magicznych płomieni oraz ekstraktów termalnych roślin pustynnych i tropikalnych. Podnosi temperaturę w otoczeniu korzeni i łodyg rośliny, tworząc wokół niej magiczną „otulinę cieplną”. ', 115, '#FE8B00', 13),
(14, 'Eliksir Ochronny', 8, 71.89, 'Po podlaniu ochrania rośliny przed wszelkim rodzajem uszkodzeń, czy to przez szkodniki lub inne rośliny! Trwa 24h na 100ml', 'Eliksir Ochronny to przezroczysty, lekko niebieski, gwieździsty płyn, który w dotyku przypomina jedwabisty rosę. Jego zapach to mieszanka leśnej żywicy, mięty i odrobiny przypraw korzennych, co sprawia, że działa również odstraszająco na magiczne owady i pasożyty. Po podlaniu tworzy na powierzchni rośliny niewidzialną, magiczną barierę ochronną, która trwa do 24 godzin na każde 100 ml użytego eliksiru. Bariera ta neutralizuje ataki szkodników, takich jak magiczne mszyce, złowrogie pająki czy pasożytnicze liany.', 71, '#92CDFF', 14),
(15, 'Diamentowe nożyce', 1, 62.18, 'Nożyce ogrodnicze stworzone z diamentu. Przetną nawet najtwardze rośliny.', 'Diamentowe Nożyce to mistrzowskie narzędzie ogrodnicze wykute z czystego, magicznego diamentu, połączonego z lekkim, ale niezwykle wytrzymałym stopem mithrilu. Ostrza błyszczą jak gwiazdy w najciemniejszą noc, a ich powierzchnia jest niemal niewrażliwa na zarysowania, korozję czy zużycie. Przecinają nawet najtwardsze i najbardziej odpornie rośliny, w tym te z rozlanym woskiem czy pokryte pyłem wulkanicznym.', 117, '#70A8A8', 15),
(16, 'Rękawice Termiczne', 1, 207.00, 'Rękawice stworzone z chłonnego materiału. Blokują wszelkiego rodzaju ciepło i chronią przed poparzeniem.', 'Rękawice Termiczne są wykonane z unikalnego, chłonnego materiału z lodowych pnącz oraz smoczych łusek, dzięki czemu potrafią całkowicie blokować przenikanie ciepła, niezależnie od jego źródła. Materiał jest lekki, elastyczny i przyjemny w dotyku, a jednocześnie odporny na ogień, lawę oraz magiczne płomienie.', 11, '#B25655', 16),
(17, 'Magiczna Doniczka', 1, 20.90, 'Doniczka ze specjalną właściwością, potrafi się na bieżąco dostosować do rośliny.', 'Dom, który rośnie razem z tobą. Magiczna Doniczka to misternie wykonany pojemnik z lekkiej gliny, przeplatanej delikatnymi włóknami gwieździstymi. Jej powierzchnia lekko pulsuje żywym światłem, dostosowując się do potrzeb rośliny, która w niej rośnie.', 225, '#BC3B34', 17),
(18, 'Szmaragdowa Łopata', 1, 91.25, 'Łopata jest praktycznie niezniszczalna. Pobiera siłę przez co kopanie jest łatwiejsze w jakiś sposób.', 'Szmaragdowa Łopata jest wykuta z jednolitego, głęboko zielonego szmaragdu, który wzmocniono magicznymi żyłkami mithrilu. Łopata nie ulega uszkodzeniom mechanicznym — nie pęka, nie rdzewieje, nie tępi się. Podczas kopania łopata absorbuje energię fizyczną użytkownika i przekierowuje ją wprost do ostrza, co sprawia, że ziemia ustępuje niemal bez oporu. Dzięki magii łopata zmniejsza obciążenie mięśni rąk i pleców, pozwalając pracować dłużej i efektywniej.', 13, '#409E50', 18);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_subcategories`
--

CREATE TABLE `product_subcategories` (
  `idProduct_subcategories` int(11) NOT NULL,
  `idCategories` int(11) NOT NULL,
  `subcategory` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_subcategories`
--

INSERT INTO `product_subcategories` (`idProduct_subcategories`, `idCategories`, `subcategory`) VALUES
(1, 4, 'Wyposażenie'),
(2, 1, 'Kwiaty'),
(3, 1, 'Grzyby'),
(4, 1, 'Narośl'),
(5, 2, 'Nasiona'),
(6, 1, 'Owoce'),
(7, 1, 'Warzywa'),
(8, 3, 'Eliksiry');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `returns`
--

CREATE TABLE `returns` (
  `idReturns` int(11) NOT NULL,
  `idOrders` int(11) NOT NULL,
  `idProducts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_details`
--

CREATE TABLE `user_details` (
  `idUser_details` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `profile_picture` longblob NOT NULL,
  `idAccounts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`idAccounts`);

--
-- Indeksy dla tabeli `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_log_type` (`type`);

--
-- Indeksy dla tabeli `admin_log_details`
--
ALTER TABLE `admin_log_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_log_details_account` (`idAccount`),
  ADD KEY `fk_log_details_tokens` (`idToken`);

--
-- Indeksy dla tabeli `admin_log_type`
--
ALTER TABLE `admin_log_type`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `awaiting_mfas`
--
ALTER TABLE `awaiting_mfas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_mfa_uniqueAccount` (`idAccounts`),
  ADD UNIQUE KEY `uq_mfa_token` (`token`) USING HASH;

--
-- Indeksy dla tabeli `awaiting_mfa_logins`
--
ALTER TABLE `awaiting_mfa_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_awaiting_mfa_login_accounts` (`idAccounts`);

--
-- Indeksy dla tabeli `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`idCarts`),
  ADD KEY `fk_accounts_carts` (`idAccounts`),
  ADD KEY `fk_products_carts` (`idProducts`);

--
-- Indeksy dla tabeli `cash_codes`
--
ALTER TABLE `cash_codes`
  ADD PRIMARY KEY (`idCash_codes`);

--
-- Indeksy dla tabeli `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idCategories`);

--
-- Indeksy dla tabeli `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`idEmployees`),
  ADD KEY `fk_accounts_employees` (`idAccounts`);

--
-- Indeksy dla tabeli `imgs`
--
ALTER TABLE `imgs`
  ADD PRIMARY KEY (`idImgs`);

--
-- Indeksy dla tabeli `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`idInventory`),
  ADD UNIQUE KEY `uq_product_account` (`idProducts`,`idAccounts`),
  ADD KEY `fk_accounts_inventory` (`idAccounts`);

--
-- Indeksy dla tabeli `login_token`
--
ALTER TABLE `login_token`
  ADD PRIMARY KEY (`idLogin_token`),
  ADD KEY `fk_token_account` (`idAccounts`);

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`idOrders`),
  ADD KEY `fk_accounts_orders` (`idAccounts`),
  ADD KEY `fk_employees_orders` (`idEmployees`);

--
-- Indeksy dla tabeli `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`idOrder_Details`),
  ADD KEY `fk_products_order_details` (`idProducts`),
  ADD KEY `fk_orders_order_details` (`idOrders`);

--
-- Indeksy dla tabeli `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`idProducts`),
  ADD KEY `fk_imgs_products` (`idImgs`),
  ADD KEY `fk_product_subcategories_products` (`idProduct_subcategories`);
ALTER TABLE `products` ADD FULLTEXT KEY `name` (`name`,`description`,`description2`);

--
-- Indeksy dla tabeli `product_subcategories`
--
ALTER TABLE `product_subcategories`
  ADD PRIMARY KEY (`idProduct_subcategories`);

--
-- Indeksy dla tabeli `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`idReturns`),
  ADD KEY `fk_orders_returns` (`idOrders`);

--
-- Indeksy dla tabeli `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`idUser_details`),
  ADD KEY `fk_accounts_user_details` (`idAccounts`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `idAccounts` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_log_details`
--
ALTER TABLE `admin_log_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_log_type`
--
ALTER TABLE `admin_log_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `awaiting_mfas`
--
ALTER TABLE `awaiting_mfas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `awaiting_mfa_logins`
--
ALTER TABLE `awaiting_mfa_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `idCarts` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_codes`
--
ALTER TABLE `cash_codes`
  MODIFY `idCash_codes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `idCategories` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `idEmployees` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imgs`
--
ALTER TABLE `imgs`
  MODIFY `idImgs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `idInventory` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_token`
--
ALTER TABLE `login_token`
  MODIFY `idLogin_token` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `idOrders` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `idOrder_Details` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `idProducts` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_subcategories`
--
ALTER TABLE `product_subcategories`
  MODIFY `idProduct_subcategories` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `idReturns` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `idUser_details` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `fk_log_type` FOREIGN KEY (`type`) REFERENCES `admin_log_type` (`id`);

--
-- Constraints for table `admin_log_details`
--
ALTER TABLE `admin_log_details`
  ADD CONSTRAINT `fk_log_details_account` FOREIGN KEY (`idAccount`) REFERENCES `accounts` (`idAccounts`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_log_details_tokens` FOREIGN KEY (`idToken`) REFERENCES `login_token` (`idLogin_token`) ON DELETE CASCADE;

--
-- Constraints for table `awaiting_mfas`
--
ALTER TABLE `awaiting_mfas`
  ADD CONSTRAINT `fk_awaiting_mfas_accounts` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);

--
-- Constraints for table `awaiting_mfa_logins`
--
ALTER TABLE `awaiting_mfa_logins`
  ADD CONSTRAINT `fk_awaiting_mfa_login_accounts` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_accounts_carts` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_products_carts` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_accounts_employees` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_accounts_inventory` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_products_inventory` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`);

--
-- Constraints for table `login_token`
--
ALTER TABLE `login_token`
  ADD CONSTRAINT `fk_token_account` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_accounts_orders` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`),
  ADD CONSTRAINT `fk_employees_orders` FOREIGN KEY (`idEmployees`) REFERENCES `employees` (`idEmployees`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_orders_order_details` FOREIGN KEY (`idOrders`) REFERENCES `orders` (`idOrders`),
  ADD CONSTRAINT `fk_products_order_details` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_imgs_products` FOREIGN KEY (`idImgs`) REFERENCES `imgs` (`idImgs`),
  ADD CONSTRAINT `fk_product_subcategories_products` FOREIGN KEY (`idProduct_subcategories`) REFERENCES `product_subcategories` (`idProduct_subcategories`);

--
-- Constraints for table `returns`
--
ALTER TABLE `returns`
  ADD CONSTRAINT `fk_orders_returns` FOREIGN KEY (`idOrders`) REFERENCES `orders` (`idOrders`);

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `fk_accounts_user_details` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Jan 19. 18:22
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `hasznaltautokereskedes`
--
CREATE DATABASE IF NOT EXISTS `hasznaltautokereskedes2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hasznaltautokereskedes2`;

--
-- A tábla adatainak kiíratása `autok`
--

INSERT INTO `autok` (`id`, `gyartasEve`, `model`, `marka`, `tomeg`, `megtettKm`, `ar`, `felujitasok`, `fogyasztas`, `hengerUrTartalom`, `meghajtas`, `sebessegValtoRendszer`, `serulesek`, `tulajdonosokSzama`, `utolsoMuszakiVizsga`, `uzemAnyagTipus`, `ferohely`, `tipus`) VALUES
(2, 2015, 'Susuki Vitara GLX', 'Susuki', 1.5, 200000, 100000, 'Nem volt.', 30, 150, 'Hátsó kerék', 'Manuális', 'Műszerfalon enyhe karcolások.', 2, '2025-02-20 00:00:00.000', 'Benzin', 4, 'Kombi'),
(3, 2003, 'Susuki Swift MK3', 'Susuki', 1.2, 250000, 100000, 'Motor csere, és alváz többszöri újra hegesztése', 20, 70, 'Hátsó', 'Manuális', 'Megviselt, elöregedett felületek', 5, '2021-01-10 00:00:00.000', 'Benzin', 4, 'Városi autó'),
(4, 2010, 'BMW 2 Series', 'BMW', 2, 30000, 100000, 'Nem volt', 70, 300, 'Hátsó kerék', 'Automata', 'Hátsó lökhárító van lazulva', 5, '2022-03-23 00:00:00.000', 'Dízel', 5, 'Hatchback'),
(5, 2005, 'BMW X3', 'BMW', 2.3, 400000, 200000, 'Motor csere és párszor ujrakarosszériázás', 90, 300, 'Első kerék', 'Manuális', 'Kifogástalan állapotban van', 3, '2024-07-10 00:00:00.000', 'Dízel', 5, 'Hatchback'),
(6, 2008, 'Citroen C4 Picasso', 'Citroen', 2.5, 500000, 1000000, 'Nem volt', 40, 210, 'Hátsó', 'Manuális', 'Itt ott eyyhe karcolások, kormánykerékről le van kopv bőr', 4, '2022-02-23 00:00:00.000', 'Dízel', 6, 'Luxus autó'),
(7, 2015, 'Citroen c3 Air Cross', 'Citroen', 2.6, 200000, 3000000, 'Ülés cserék', 40, 400, 'Első kerék', 'Automata', 'Egy kicsit viharvert.', 3, '2024-01-01 00:00:00.000', 'Dízel', 4, 'Sedan'),
(12, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó kerék', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2022-08-21 00:00:00.000', 'Benzin', 5, 'Sedan'),
(13, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(14, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(15, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(16, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(17, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(18, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(21, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(22, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-23 00:00:00.000', 'Benzin', 5, 'test'),
(23, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2024-08-13 00:00:00.000', 'Benzin', 5, 'test'),
(24, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2022-12-10 23:00:00.000', 'Benzin', 5, 'test'),
(26, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2022-12-10 23:00:00.000', 'Benzin', 5, 'test'),
(27, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2022-12-10 23:00:00.000', 'Benzin', 5, 'test'),
(28, 2015, 'test', 'test', 2.5, 20000, 100000, 'Motor csere gyári hiba miatt.', 10, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 3, '2022-12-10 23:00:00.000', 'Benzin', 5, 'test'),
(29, 2000, 'test', 'bdfgh', 1000, 20000, 20000, 'cgnvhnghnm', 1000, 1000, 'Első kerék', 'Automata', 'cvbfgnf', 4, '2000-01-10 00:00:00.000', 'Dízel', 5, 'Sedan'),
(30, 2000, 'model', 'dfdfgds', 2, 20000, 100000, 'hgjhjf', 100, 100, 'Első kerék', 'Manuális', 'dvvfb', 3, '1999-01-02 00:00:00.000', 'Dízel', 6, 'Sedan'),
(31, 20000, 'model2', 'hmhjk', 3, 10000, 200000, 'jghjg', 100, 1000, 'Első kerék', 'Félautomata', 'fghfd', 5, '2000-04-04 00:00:00.000', 'Benzin', 7, 'Sedan'),
(45, 2342, 'fgrf', 'fdg', 43, 4234, 34534, 'fgfd', 3, 34, 'Hátsó kerék', 'Manuális', '23fd', 3, '2222-02-02 00:00:00.000', 'Elektromos', 2, 'Coupe'),
(48, 546, 'sus', '453', 3, 4, 1, '', 3, 3, 'Hátsó kerék', 'Manuális', '', 3, '1111-11-11 00:00:00.000', 'Dízel', 3, 'Sedan'),
(50, 2, '2', '2', 2, 2, 2, '2', 2, 2, 'Első kerék', 'Manuális', '2', 2, '1111-11-11 00:00:00.000', 'Benzin', 2, 'Sedan'),
(51, 23, '3', '2', 1.1, 3, 3, 'd', 1, 20, 'Első kerék', 'Automata', 'd', 3, '1111-01-01 00:00:00.000', 'Dízel', 1, 'Sedan'),
(52, 34, '34', 'ff', 1.9, 2, 34, 'dfg', 3, 3, 'Hátsó kerék', 'Manuális', 'def', 3, '2222-02-02 00:00:00.000', 'Hibrid', 3, 'SUV'),
(55, 2011, 'MK1', 'Golf', 3, 1000000, 2000000, 'Volt egyszer kétszer', 15, 1000, 'Összkerék', 'Automata', 'Minden rendben', 4, '2022-02-10 00:00:00.000', 'Dízel', 5, 'SUV'),
(56, 2020, 'Golf', 'Golf', 4, 200000, 3000000, 'Motor cser volt pár évvel ezeleöt', 20, 1500, 'Hátsó kerék', 'Manuális', 'Itt ott kopott egy kicsit', 5, '1999-11-11 00:00:00.000', 'Dízel', 6, 'SUV'),
(57, 2005, 'Opel Astra', 'Opel', 1.8, 400000, 600000, 'Nem volt', 16, 800, 'Első kerék', 'Manuális', 'Ülések kicsit szakadtak, megviselt', 7, '2023-03-04 00:00:00.000', 'Benzin', 4, 'Sedan'),
(58, 2020, 'Opel Grandland', 'Opel', 3.3, 100000, 3000000, 'Üllések ujra lettek huzatva', 18, 2000, 'Összkerék', 'Automata', 'Karosszéria kicsit karcos', 3, '2024-09-10 00:00:00.000', 'Hibrid', 5, 'Kombi'),
(59, 2012, 'Toyota Carolla', 'Toyota', 1.9, 100000, 4000000, 'Nem vollt', 20, 1300, 'Hátsó kerék', 'Automata', 'Nincs', 2, '2018-02-03 00:00:00.000', 'Hibrid', 5, 'Hatchback'),
(60, 2023, 'Toyota Crown', 'Toyota', 3.6, 200000, 6000000, 'Nem volt.', 20, 2000, 'Összkerék', 'Automata', 'Kormány kicsit deformálódott', 1, '2025-01-05 00:00:00.000', 'Hibrid', 6, 'SUV');

--
-- A tábla adatainak kiíratása `images`
--

INSERT INTO `images` (`image_id`, `path`, `carId`) VALUES
(1, 'Nuova-C3_focuspointscale_w856_fx0_fy0.webp', 7),
(2, 'blog_2025_Vitara_1.png', 2),
(3, '353072_source-2048x1152.jpg', 4),
(4, 'bmw-3-series-front-720x405px.jpg', 5),
(5, 'Nuova-C3_focuspointscale_w856_fx0_fy0.webp', 6),
(7, '2000_Suzuki_Swift_1.3_GLX_5-door_(9754701452).jpg', 3),
(24, '1764698350143.jpg', 45),
(28, '1764777635262.webp', 2),
(29, '1764777635266.jpg', 2),
(30, '1764777760515.jpg', 2),
(31, '1764777760515.jpg', 2),
(44, '1768841084147.avif', 55),
(45, '1768841084149.avif', 55),
(46, '1768841084156.jpg', 55),
(47, '1768841084167.jpg', 55),
(48, '1768841272873.webp', 56),
(49, '1768841272875.jpg', 56),
(50, '1768841778508.webp', 57),
(51, '1768841778508.jpg', 57),
(52, '1768842038341.jpg', 58),
(53, '1768842038342.webp', 58),
(54, '1768842436578.jpg', 59),
(55, '1768842436578.jpg', 59),
(56, '1768842713201.jpg', 60),
(57, '1768842713205.jpg', 60);

--
-- A tábla adatainak kiíratása `kedvencek`
--

INSERT INTO `users` (`id`, `name`, `accessLevel`, `email`, `telSzam`, `password`) VALUES
(1, 'adam', 1, 'adam@adam.hu', '', '123456'),
(2, 'kate', 0, 'sdfs@fdg.hz', '4352454', 'qwert'),
(3, 'mama', 0, 'dfg@fdfr.hf', '324235324', 'íyxcv'),
(4, 'zozo', 0, 'derfg@hgjgh.huz', '4564575', 'fgnjhgh'),
(5, 'adamon', 0, 'ghkjhgjkmhgj', '43453452', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413'),
(7, 'ad', 0, 'emailem', '43453452', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413'),
(9, 'ed', 0, 'emaiem', '43453452', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413'),
(10, 'e', 0, 'emiem', '43453452', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413'),
(11, 'eemér32', 0, 'emiem@gamail.com', '43453452', 'd9e6762dd1c8eaf6d61b3c6192fc408d4d6d5f1176d0c29169bc24e71c3f274ad27fcd5811b313d681f7e55ec02d73d499c95455b6b5bb503acf574fba8ffe85'),
(12, 'egisztráltMajom', 0, 'asd@fgfg.hu', NULL, '6ef8aee095a3547f830ced5a0119555d8ef84457fff2a3571ed14d6f13b493ead135e0fe5a333b22bded3aac1f9d54a650faa68bf7cd609accc83123f84e153d'),
(13, 'cukorka70', 0, 'gjhzm@xn--pl-9ia.com', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(14, 'adamon94', 1, 'adamon940@gmail.com', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(15, 'léáű', 0, 'nmk@ki.le', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(16, 'njp', 0, 'hfgh@fgf', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(17, 'lép', 0, 'fgdf@hgki.lk', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(18, 'pőú', 0, 'hjkjh@xn--pl-bja.hu', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(19, 'cvb', 0, 'peter@peter.hu', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(20, 'GHJGHUKJ', 0, 'ghkjhujk@fg.com', NULL, '4b187be3c1ccb51706dd1609288305c265f7ff6bbbe00c3e6dd6e80288744da77258d029d31eccec6bd1b98ccbe48da513a205dda993aef134b962cf8569ddca');

INSERT INTO `kedvencek` (`id`, `autoId`, `userId`) VALUES
(105, 2, 14),
(113, 3, 14),
(110, 4, 14);

--
-- A tábla adatainak kiíratása `tesztvezetesek`
--

INSERT INTO `tesztvezetesek` (`id`, `datum`, `userId`, `autoId`) VALUES
(19, '2026-04-07 00:00:00.000', 14, 56),
(20, '2026-05-03 00:00:00.000', 14, 2),
(21, '2026-08-25 00:00:00.000', 14, 3);

--
-- A tábla adatainak kiíratása `users`
--


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

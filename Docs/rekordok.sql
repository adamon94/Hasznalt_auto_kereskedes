-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2025. Nov 18. 20:25
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

--
-- A tábla adatainak kiíratása `autok`
--

INSERT INTO `autok` (`id`, `gyartasEve`, `model`, `marka`, `tomeg`, `megtettKm`, `ar`, `felujitasok`, `fogyasztas`, `hengerUrTartalom`, `meghajtas`, `sebessegValtoRendszer`, `serulesek`, `tulajdonosokSzama`, `utolsoMuszakiVizsga`, `uzemAnyagTipus`, `ferohely`, `tipus`) VALUES
(2, 2015, 'Susuki Vitara GLX', 'Susuki', 1.5, 200000, 100000, 'Nem volt', 30, 150, 'Hátsó', 'Manuális', 'Műszerfalon enyhe karcolások', 2, '2025-02-20 00:00:00.000', 'Benzin', 4, 'Terepjáró'),
(3, 2003, 'Susuki Swift MK3', 'Susuki', 1.2, 250000, 100000, 'Motor csere, és alváz többszöri újra hegesztése', 20, 70, 'Hátsó', 'Manuális', 'Megviselt, elöregedett felületek', 5, '2021-01-10 00:00:00.000', 'Benzin', 4, 'Városi autó'),
(4, 2010, 'BMW 2 Series', 'BMW', 2.1, 30000, 100000, 'Nem volt', 70, 300, 'Hátsó', 'Automata', 'Hátsó lökhárító van lazulva', 5, '2022-03-23 00:00:00.000', 'Dízel', 5, 'Sport autó'),
(5, 2005, 'BMW X3', 'BMW', 2.3, 400000, 200000, 'Motor csere és párszor ujrakarosszériázás', 90, 300, 'Elölső', 'Manuális', 'Kifogástalan állapotban van', 3, '2024-07-10 00:00:00.000', 'Dízel', 5, 'Luxus autó'),
(6, 2008, 'Citroen C4 Picasso', 'Citroen', 2.5, 500000, 1000000, 'Nem volt', 40, 210, 'Hátsó', 'Manuális', 'Itt ott eyyhe karcolások, kormánykerékről le van kopv bőr', 4, '2022-02-23 00:00:00.000', 'Dízel', 6, 'Luxus autó'),
(7, 2015, 'Citroen c3 Air Cross', 'Citroen', 2.6, 200000, 3000000, 'Nem volt', 40, 400, 'Hátsó', 'Automata', 'Nincs', 3, '2024-01-03 00:00:00.000', 'Dízel', 4, 'Városi autó');

--
-- A tábla adatainak kiíratása `images`
--

INSERT INTO `images` (`image_id`, `path`, `carId`) VALUES
(1, 'Nuova-C3_focuspointscale_w856_fx0_fy0.webp', 7),
(2, 'blog_2025_Vitara_1.png', 2),
(3, '353072_source-2048x1152.jpg', 4),
(4, 'bmw-3-series-front-720x405px.jpg', 5),
(5, 'Nuova-C3_focuspointscale_w856_fx0_fy0.webp', 6),
(6, 'images\\c3_3.jpg', 7),
(7, '2000_Suzuki_Swift_1.3_GLX_5-door_(9754701452).jpg', 3);

--
-- A tábla adatainak kiíratása `kedvencek`
--

INSERT INTO `kedvencek` (`id`, `autoId`, `userId`) VALUES
(72, 3, 14),
(74, 4, 14);

--
-- A tábla adatainak kiíratása `tesztvezetesek`
--

INSERT INTO `tesztvezetesek` (`id`, `datum`, `userId`, `autoId`) VALUES
(9, '2222-02-02 00:00:00.000', 14, 6),
(10, '1970-01-01 00:00:00.000', 14, 7),
(11, '1970-01-01 00:00:00.000', 14, 2),
(12, '1970-01-01 00:00:00.000', 14, 3);

--
-- A tábla adatainak kiíratása `users`
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
(14, 'adamon94', 0, 'adamon940@gmail.com', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(15, 'léáű', 0, 'nmk@ki.le', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(16, 'njp', 0, 'hfgh@fgf', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(17, 'lép', 0, 'fgdf@hgki.lk', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(18, 'pőú', 0, 'hjkjh@xn--pl-bja.hu', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe'),
(19, 'cvb', 0, 'peter@peter.hu', NULL, 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe');

--
-- A tábla adatainak kiíratása `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('0bf85e41-5571-410f-95fa-d0858ade459c', 'b946e1f601c0af293eea06911aaad8013d12512b7d843fa5e13d935b57bcd318', '2025-10-11 13:57:32.561', '20251011135627_', NULL, NULL, '2025-10-11 13:57:32.497', 1),
('2bcb3d9d-5020-40b4-977b-b72e2cbb3270', 'd85d445c8218553a17145f0e63c0b8d0fb09d1ba2ccb2176e776a84a357c875c', '2025-10-11 13:57:32.475', '20251004082620_', NULL, NULL, '2025-10-11 13:57:32.447', 1),
('3e07b9e4-84b4-40ed-958e-37f2c065e981', '36b52dd201f84983038353df9e84c95c871ed5c980d1e1876a21f8a81aa22b17', '2025-10-11 13:57:32.227', '20250925181245_database_updated', NULL, NULL, '2025-10-11 13:57:32.198', 1),
('497d5d01-a3fc-4733-b593-1d14a6f012ae', '25cb6b4b7b8c68d8c568d47ee38f32c6c40953d6d2d46cb5106543a178b4b32a', '2025-10-11 13:57:32.303', '20250930184648_', NULL, NULL, '2025-10-11 13:57:32.267', 1),
('4e5b56be-38a7-4fa0-ab43-738440553480', 'aa45f773913ed6347d4a893ea4308d0957623d0e0c54075554ddcf80c625a8a8', '2025-10-31 16:40:06.063', '20251031164006_', NULL, NULL, '2025-10-31 16:40:06.019', 1),
('5e6ed831-fe7f-413b-b1b8-e19d9a19cd5a', '3470de5581293ebae9c292ab0140ebb893384107158f620b3705bb9637287ddf', '2025-10-31 16:40:04.411', '20251015142504_', NULL, NULL, '2025-10-31 16:40:04.406', 1),
('6f4543b6-f641-4181-8543-8c059307e51b', 'f80daf5034d1cc39d84d1ac2944f1f92b24b44655f5350b0aef9b5b423193eb1', '2025-10-11 13:57:32.266', '20250930180137_', NULL, NULL, '2025-10-11 13:57:32.229', 1),
('70e4376c-a0c1-488b-bd5d-dfbf5a1ef552', 'ced180746ee7a654cd3258850104b4029764c017336cefeb8b2800b51e07db65', '2025-10-11 13:57:32.367', '20250930190017_', NULL, NULL, '2025-10-11 13:57:32.306', 1),
('7b07fe03-1a92-4c8a-9023-53a7ecb956ab', '999f3d600ffcb59854e1df2d947e8235162308333640fe533a737c08d6207422', '2025-10-11 13:57:32.196', '20250925160905_', NULL, NULL, '2025-10-11 13:57:31.931', 1),
('87ba0e9b-85b1-496d-a5d4-22725d7f3720', 'ae7953a7436fd27b2c2f4ef0a1744d10afae15989c1c1ea2af2ecb54f28b40c9', '2025-10-11 13:57:32.494', '20251004083354_', NULL, NULL, '2025-10-11 13:57:32.477', 1),
('8a76cb2f-6d02-4908-8e5d-26d0f2767bdd', 'a08e7f10267cdf7a56f8613bf150913743e8895c0a2c627b11ef541bff0f2b06', '2025-10-11 13:57:32.445', '20251003154459_', NULL, NULL, '2025-10-11 13:57:32.368', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2025. Okt 14. 15:28
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
CREATE DATABASE IF NOT EXISTS `hasznaltautokereskedes` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hasznaltautokereskedes`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `autok`
--

CREATE TABLE `autok` (
  `id` int(11) NOT NULL,
  `gyartasEve` int(11) NOT NULL,
  `model` varchar(191) NOT NULL,
  `marka` varchar(191) NOT NULL,
  `tomeg` double NOT NULL,
  `megtettKm` int(11) NOT NULL,
  `ar` int(11) NOT NULL,
  `felujitasok` varchar(191) NOT NULL,
  `fogyasztas` int(11) NOT NULL,
  `hengerUrTartalom` int(11) NOT NULL,
  `meghajtas` varchar(191) NOT NULL,
  `sebessegValtoRendszer` varchar(191) NOT NULL,
  `serulesek` varchar(191) NOT NULL,
  `tulajdonosokSzama` int(11) NOT NULL,
  `utolsoMuszakiVizsga` datetime(3) NOT NULL,
  `uzemAnyagTipus` varchar(191) NOT NULL,
  `ferohely` int(11) NOT NULL,
  `tipus` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `images`
--

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `path` varchar(191) NOT NULL,
  `carId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kedvencek`
--

CREATE TABLE `kedvencek` (
  `id` int(11) NOT NULL,
  `autoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kivansagllista`
--

CREATE TABLE `kivansagllista` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `kivantMarka` varchar(191) DEFAULT NULL,
  `kivantSebValto` varchar(191) DEFAULT NULL,
  `kivantMegtettKm` int(11) DEFAULT NULL,
  `kiantFogyasztas` int(11) DEFAULT NULL,
  `kivantHengerUrTartalom` int(11) DEFAULT NULL,
  `kivantTipus` varchar(191) DEFAULT NULL,
  `kivantModel` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tesztvezetesek`
--

CREATE TABLE `tesztvezetesek` (
  `id` int(11) NOT NULL,
  `datum` datetime(3) NOT NULL,
  `userId` int(11) NOT NULL,
  `autoId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `accessLevel` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `telSzam` varchar(191) DEFAULT NULL,
  `password` varchar(191) NOT NULL DEFAULT 'change_me_123'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `autok`
--
ALTER TABLE `autok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `images_carId_fkey` (`carId`);

--
-- A tábla indexei `kedvencek`
--
ALTER TABLE `kedvencek`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kedvencek_autoId_userId_key` (`autoId`,`userId`),
  ADD KEY `kedvencek_userId_fkey` (`userId`);

--
-- A tábla indexei `kivansagllista`
--
ALTER TABLE `kivansagllista`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kivansagLlista_kivantModel_userId_key` (`kivantModel`,`userId`),
  ADD KEY `kivansagLlista_userId_fkey` (`userId`);

--
-- A tábla indexei `tesztvezetesek`
--
ALTER TABLE `tesztvezetesek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tesztVezetesek_autoId_fkey` (`autoId`),
  ADD KEY `tesztVezetesek_userId_fkey` (`userId`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_name_key` (`name`),
  ADD UNIQUE KEY `users_email_key` (`email`);

--
-- A tábla indexei `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `autok`
--
ALTER TABLE `autok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `images`
--
ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kedvencek`
--
ALTER TABLE `kedvencek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kivansagllista`
--
ALTER TABLE `kivansagllista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `tesztvezetesek`
--
ALTER TABLE `tesztvezetesek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_carId_fkey` FOREIGN KEY (`carId`) REFERENCES `autok` (`id`) ON UPDATE CASCADE;

--
-- Megkötések a táblához `kedvencek`
--
ALTER TABLE `kedvencek`
  ADD CONSTRAINT `kedvencek_autoId_fkey` FOREIGN KEY (`autoId`) REFERENCES `autok` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `kedvencek_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Megkötések a táblához `kivansagllista`
--
ALTER TABLE `kivansagllista`
  ADD CONSTRAINT `kivansagLlista_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Megkötések a táblához `tesztvezetesek`
--
ALTER TABLE `tesztvezetesek`
  ADD CONSTRAINT `tesztVezetesek_autoId_fkey` FOREIGN KEY (`autoId`) REFERENCES `autok` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tesztVezetesek_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

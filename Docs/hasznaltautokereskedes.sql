-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Jan 19. 18:23
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

CREATE TABLE IF NOT EXISTS `autok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `tipus` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(191) NOT NULL,
  `carId` int(11) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `images_carId_fkey` (`carId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kedvencek`
--

CREATE TABLE IF NOT EXISTS `kedvencek` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kedvencek_autoId_userId_key` (`autoId`,`userId`),
  KEY `kedvencek_userId_fkey` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kivansagllista`
--

CREATE TABLE IF NOT EXISTS `kivansagllista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `kivantSebValto` varchar(191) DEFAULT NULL,
  `kivantMegtettKm` int(11) DEFAULT NULL,
  `kiantFogyasztas` int(11) DEFAULT NULL,
  `kivantHengerUrTartalom` int(11) DEFAULT NULL,
  `kivantTipus` varchar(191) DEFAULT NULL,
  `kivantModel` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kivansagLlista_userId_fkey` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tesztvezetesek`
--

CREATE TABLE IF NOT EXISTS `tesztvezetesek` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datum` datetime(3) NOT NULL,
  `userId` int(11) NOT NULL,
  `autoId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tesztVezetesek_autoId_fkey` (`autoId`),
  KEY `tesztVezetesek_userId_fkey` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `accessLevel` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `telSzam` varchar(191) DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_name_key` (`name`),
  UNIQUE KEY `users_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3310
-- Létrehozás ideje: 2025. Sze 19. 16:32
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
-- Tábla szerkezet ehhez a táblához `cars`
--

CREATE TABLE `cars` (
  `id` int(11) NOT NULL,
  `gyartasEve` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `marka` varchar(255) NOT NULL,
  `tipus` varchar(255) NOT NULL,
  `ar` int(11) NOT NULL,
  `megtettKm` int(11) NOT NULL,
  `tulajdonsokSzama` int(11) NOT NULL,
  `serulesek` varchar(255) NOT NULL,
  `utolsoMuszakiVizsga` date NOT NULL,
  `tomeg` int(11) NOT NULL,
  `meghajtas` varchar(255) NOT NULL,
  `fogyasztas` varchar(255) NOT NULL,
  `uzemanyagTipus` varchar(255) NOT NULL,
  `sebessegvaltoRendszer` varchar(255) NOT NULL,
  `hengerUrtartalom(cm³)` int(11) NOT NULL,
  `komolyabbAlkatreszCserek` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kedvencek`
--

CREATE TABLE `kedvencek` (
  `id` int(11) NOT NULL,
  `autoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kivansaglista`
--

CREATE TABLE `kivansaglista` (
  `id` int(11) NOT NULL,
  `kivantMarka` varchar(255) NOT NULL,
  `kivanTipus` varchar(255) NOT NULL,
  `kivantSebesegvalto` varchar(255) NOT NULL,
  `kivantMegtettKm` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `kivantHengerUrtartalom(cm³)` int(11) NOT NULL,
  `kivantFogyasztas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `testdrive`
--

CREATE TABLE `testdrive` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `autoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accessLevel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `kedvencek`
--
ALTER TABLE `kedvencek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autoId` (`autoId`),
  ADD KEY `userId` (`userId`);

--
-- A tábla indexei `kivansaglista`
--
ALTER TABLE `kivansaglista`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- A tábla indexei `testdrive`
--
ALTER TABLE `testdrive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autoId` (`autoId`),
  ADD KEY `userId` (`userId`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kedvencek`
--
ALTER TABLE `kedvencek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kivansaglista`
--
ALTER TABLE `kivansaglista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `testdrive`
--
ALTER TABLE `testdrive`
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
-- Megkötések a táblához `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `testdrive` (`autoId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `kedvencek`
--
ALTER TABLE `kedvencek`
  ADD CONSTRAINT `kedvencek_ibfk_1` FOREIGN KEY (`autoId`) REFERENCES `cars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `kivansaglista`
--
ALTER TABLE `kivansaglista`
  ADD CONSTRAINT `kivansaglista_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `testdrive`
--
ALTER TABLE `testdrive`
  ADD CONSTRAINT `testdrive_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `kedvencek` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id`) REFERENCES `kedvencek` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

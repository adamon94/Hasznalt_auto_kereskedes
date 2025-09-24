-- CreateTable
CREATE TABLE `cars` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gyartasEve` INTEGER NOT NULL,
    `model` VARCHAR(255) NOT NULL,
    `marka` VARCHAR(255) NOT NULL,
    `tipus` VARCHAR(255) NOT NULL,
    `ar` INTEGER NOT NULL,
    `megtettKm` INTEGER NOT NULL,
    `tulajdonsokSzama` INTEGER NOT NULL,
    `serulesek` VARCHAR(255) NOT NULL,
    `utolsoMuszakiVizsga` DATE NOT NULL,
    `tomeg` DOUBLE NOT NULL,
    `meghajtas` VARCHAR(255) NOT NULL,
    `fogyasztas` VARCHAR(255) NOT NULL,
    `uzemanyagTipus` VARCHAR(255) NOT NULL,
    `sebessegvaltoRendszer` VARCHAR(255) NOT NULL,
    `hengerUrtartalom` INTEGER NOT NULL,
    `komolyabbFelujitasok` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kedvencek` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `autoId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `kedvencek_userId_key`(`userId`),
    INDEX `autoId`(`autoId`),
    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kivansaglista` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kivantMarka` VARCHAR(255) NOT NULL,
    `kivantTipus` VARCHAR(255) NOT NULL,
    `kivantSebesegvalto` VARCHAR(255) NOT NULL,
    `kivantMegtettKm` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `kivantHengerUrtartalom` INTEGER NOT NULL,
    `kivantFogyasztas` DOUBLE NOT NULL,

    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testdrive` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `autoId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `testdrive_autoId_key`(`autoId`),
    INDEX `autoId`(`autoId`),
    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userName` VARCHAR(255) NOT NULL,
    `Password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `accessLevel` INTEGER NOT NULL,
    `telSzam` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `cars` ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `testdrive`(`autoId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kedvencek` ADD CONSTRAINT `kedvencek_ibfk_1` FOREIGN KEY (`autoId`) REFERENCES `cars`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kivansaglista` ADD CONSTRAINT `kivansaglista_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `testdrive` ADD CONSTRAINT `testdrive_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `kedvencek`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id`) REFERENCES `kedvencek`(`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

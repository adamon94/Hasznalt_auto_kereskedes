-- CreateTable
CREATE TABLE `autok` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `gyartasEve` INTEGER NOT NULL,
    `model` VARCHAR(191) NOT NULL,
    `marka` VARCHAR(191) NOT NULL,
    `tomeg` DOUBLE NOT NULL,
    `megtettKm` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `passsword` VARCHAR(191) NOT NULL,
    `accessLevel` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kedvencek` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `autoId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tesztVezetesek` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `datum` DATETIME(3) NOT NULL,
    `userId` INTEGER NOT NULL,
    `autoId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kivansagLlista` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `kivantMarka` VARCHAR(191) NOT NULL,
    `kivantSebValto` VARCHAR(191) NOT NULL,
    `kivantMegtettKm` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `kedvencek` ADD CONSTRAINT `kedvencek_autoId_fkey` FOREIGN KEY (`autoId`) REFERENCES `autok`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kedvencek` ADD CONSTRAINT `kedvencek_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tesztVezetesek` ADD CONSTRAINT `tesztVezetesek_autoId_fkey` FOREIGN KEY (`autoId`) REFERENCES `autok`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tesztVezetesek` ADD CONSTRAINT `tesztVezetesek_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `kivansagLlista` ADD CONSTRAINT `kivansagLlista_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

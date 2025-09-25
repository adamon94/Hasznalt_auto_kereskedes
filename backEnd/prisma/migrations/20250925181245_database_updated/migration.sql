/*
  Warnings:

  - Added the required column `ar` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `felujitasok` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fogyasztas` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hengerUrTartalom` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `meghajtas` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sebessegValtoRendszer` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `serulesek` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tulajdonosokSzama` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `utolsoMuszakiVizsga` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `uzemAnyagTipus` to the `autok` table without a default value. This is not possible if the table is not empty.
  - Added the required column `kiantFogyasztas` to the `kivansagLlista` table without a default value. This is not possible if the table is not empty.
  - Added the required column `kivantHengerUrTartalom` to the `kivansagLlista` table without a default value. This is not possible if the table is not empty.
  - Added the required column `kivantTipus` to the `kivansagLlista` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `autok` ADD COLUMN `ar` INTEGER NOT NULL,
    ADD COLUMN `felujitasok` VARCHAR(191) NOT NULL,
    ADD COLUMN `fogyasztas` INTEGER NOT NULL,
    ADD COLUMN `hengerUrTartalom` VARCHAR(191) NOT NULL,
    ADD COLUMN `meghajtas` VARCHAR(191) NOT NULL,
    ADD COLUMN `sebessegValtoRendszer` VARCHAR(191) NOT NULL,
    ADD COLUMN `serulesek` VARCHAR(191) NOT NULL,
    ADD COLUMN `tulajdonosokSzama` INTEGER NOT NULL,
    ADD COLUMN `utolsoMuszakiVizsga` DATETIME(3) NOT NULL,
    ADD COLUMN `uzemAnyagTipus` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `kivansagllista` ADD COLUMN `kiantFogyasztas` INTEGER NOT NULL,
    ADD COLUMN `kivantHengerUrTartalom` VARCHAR(191) NOT NULL,
    ADD COLUMN `kivantTipus` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `users` ADD COLUMN `email` VARCHAR(191) NOT NULL;

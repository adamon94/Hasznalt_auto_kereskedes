/*
  Warnings:

  - You are about to alter the column `hengerUrTartalom` on the `autok` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - Added the required column `ferohely` to the `autok` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `autok` ADD COLUMN `ferohely` VARCHAR(191) NOT NULL,
    MODIFY `hengerUrTartalom` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `users` ADD COLUMN `telSzam` VARCHAR(191) NULL;

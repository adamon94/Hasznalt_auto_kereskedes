/*
  Warnings:

  - You are about to alter the column `kivantHengerUrTartalom` on the `kivansagllista` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - A unique constraint covering the columns `[autoId,userId]` on the table `kedvencek` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tipus` to the `autok` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `autok` ADD COLUMN `tipus` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `kivansagllista` MODIFY `kivantHengerUrTartalom` INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `kedvencek_autoId_userId_key` ON `kedvencek`(`autoId`, `userId`);

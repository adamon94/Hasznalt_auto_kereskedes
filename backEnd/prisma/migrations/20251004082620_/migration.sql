/*
  Warnings:

  - Added the required column `kivantModel` to the `kivansagLlista` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `kivansagllista` ADD COLUMN `kivantModel` VARCHAR(191) NOT NULL,
    MODIFY `kivantMarka` VARCHAR(191) NULL,
    MODIFY `kivantSebValto` VARCHAR(191) NULL,
    MODIFY `kivantMegtettKm` INTEGER NULL,
    MODIFY `kiantFogyasztas` INTEGER NULL,
    MODIFY `kivantHengerUrTartalom` INTEGER NULL,
    MODIFY `kivantTipus` VARCHAR(191) NULL;

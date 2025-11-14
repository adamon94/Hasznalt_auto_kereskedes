/*
  Warnings:

  - You are about to drop the column `kivantMarka` on the `kivansagllista` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `kivansagLlista_kivantModel_userId_key` ON `kivansagllista`;

-- AlterTable
ALTER TABLE `kivansagllista` DROP COLUMN `kivantMarka`,
    MODIFY `kivantModel` VARCHAR(191) NULL;

/*
  Warnings:

  - Added the required column `img` to the `cars` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `cars` ADD COLUMN `img` LONGBLOB NOT NULL,
    MODIFY `utolsoMuszakiVizsga` DATE NOT NULL;

/*
  Warnings:

  - You are about to drop the column `uzemanyagTipus` on the `cars` table. All the data in the column will be lost.
  - Added the required column `fuel` to the `cars` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `cars` DROP COLUMN `uzemanyagTipus`,
    ADD COLUMN `fuel` VARCHAR(255) NOT NULL;

/*
  Warnings:

  - You are about to drop the column `passsword` on the `users` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `password` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- First, add the password column with a default value
ALTER TABLE `users` ADD COLUMN `password` VARCHAR(191) NOT NULL DEFAULT 'change_me_123';

-- Copy data from the misspelled column to the new one (if there's data)
UPDATE `users` SET `password` = `passsword` WHERE `passsword` IS NOT NULL AND `passsword` != '';

-- Drop the old misspelled column
ALTER TABLE `users` DROP COLUMN `passsword`;

-- Clean up duplicate emails before adding unique constraint
-- Keep only the first occurrence of each email
DELETE u1 FROM `users` u1
INNER JOIN `users` u2 
WHERE u1.id > u2.id AND u1.email = u2.email;

-- Clean up duplicate names before adding unique constraint
DELETE u1 FROM `users` u1
INNER JOIN `users` u2 
WHERE u1.id > u2.id AND u1.name = u2.name;

-- CreateIndex
CREATE UNIQUE INDEX `users_name_key` ON `users`(`name`);

-- CreateIndex
CREATE UNIQUE INDEX `users_email_key` ON `users`(`email`);

/*
  Warnings:

  - A unique constraint covering the columns `[kivantModel,userId]` on the table `kivansagLlista` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `kivansagLlista_kivantModel_userId_key` ON `kivansagLlista`(`kivantModel`, `userId`);

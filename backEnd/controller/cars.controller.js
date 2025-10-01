import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";


const p = new PrismaClient();

const router = express.Router();


router.get("/getCars", async (req, res) => {

    const data  = await p.autok.findMany();
    res.json(data).status(200)
});
/*  Kedvenc autó felvétele  */
/*  1 felhasználó és egy kedvenc autója közti kapcsolat lekérdezése  */
/*tesztvezetés időpont felvétele*/
/*tesztvezetés időpontok lekérdezése*/
/*Kívánt autó felvétele*/
/*Azok lekérdezése*/

export { router };
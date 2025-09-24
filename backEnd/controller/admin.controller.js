
import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";

const p = new PrismaClient()
const router = express.Router();



router.post("/addCar", async (req, res) => {
     const {ev,model,marka,tipus,ar,km, owners, 
        serulesek, tomeg, meghajtas, 
        fogyasztas,sebvaltorendszer, uzemanyag,
         hengerUr, ujitasok} = req.body;
         try {
            await p.cars.create({
                data:{
                 
                    gyartasEve: Number(ev),
                    model: model,
                    marka:marka,
                    tipus:tipus,
                    tomeg: Number(tomeg),
                    ar: Number(ar),
                    megtettKm: Number(km),
                    tulajdonsokSzama: Number(owners),
                    serulesek: serulesek,
                    //utolsoMuszakiVizsga: new Date(utsoMuszaki),
                    meghajtas: meghajtas,
                    fogyasztas: Number(fogyasztas),
                    sebessegvaltoRendszer: sebvaltorendszer,
                    hengerUrtartalom: Number(hengerUr),
                    komolyabbFelujitasok: ujitasok,
                    fuel: uzemanyag,
                },
                
            });
            res.status(201).json({ uzenet: "Az autó közétéve!"})
         }
         catch(err){
            console.log(err);
            res.status(400).json({uzenet: "Hiba történt!"})
         }
});

export { router };
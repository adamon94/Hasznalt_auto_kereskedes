
import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";

const p = new PrismaClient()
const router = express.Router();



router.post("/addCar", async (req, res) => {
     const {gyartasEve,model,marka,tipus,ar,tomeg,meghajtas,hengerUrTartalom,sebessegValtoRendszer,
      ferohely, uzemAnyagTipus, fogyasztas,megtettKm,tulajdonosokSzama,
      serulesek,utolsoMuszakiVizsga,felujitasok} = req.body;
      
         try {
            const data = await p.autok.create({
                data:{
                 
                  gyartasEve: Number(gyartasEve),
                  model,
                  marka,
                  tipus,
                  ar: Number(ar),
                  tomeg:Number(tomeg),
                  meghajtas,
                  hengerUrTartalom : Number(hengerUrTartalom),
                  sebessegValtoRendszer,
                  ferohely: Number(ferohely),
                  uzemAnyagTipus,
                  fogyasztas:Number(fogyasztas),
                  megtettKm:Number(megtettKm),
                  tulajdonosokSzama:Number(tulajdonosokSzama),
                  serulesek,
                  utolsoMuszakiVizsga:new Date(utolsoMuszakiVizsga),
                  felujitasok,
               }
                
            });
            res.status(201).json({message:data.id})
         }
         catch(err){
            console.log(err);
            res.status(400).json({uzenet: "Hiba történt!"})
         }
});


router.get("/kedvencek", async (req,res) => {
   const data = await p.kedvencek.findMany({
      include:{
         Autok:true
      },
   })
   res.status(200).json(data);
})


export { router };
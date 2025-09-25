
import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";

const p = new PrismaClient()
const router = express.Router();



router.post("/addCar", async (req, res) => {
     const {ev,model,marka,tomeg,megtettKm} = req.body;
         try {
            await p.autok.create({
                data:{
                 
                  gyartasEve: Number(ev),
                  model,
                  marka,
                  
                  tomeg:Number(tomeg),
                  megtettKm:Number(megtettKm)
               }
                
            });
            res.status(201).json({ uzenet: "Az autó közétéve!"})
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
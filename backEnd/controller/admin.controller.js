
import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";
import multer from "multer";
import path from "path";

const p = new PrismaClient()
const router = express.Router();

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        /*
            A files nevű mappába mennek a feltöltendő fájlok.
            Ha megadjuk az első paramétert nem nullként,
            akkor dob a multer egy error-t.
        */
        cb(null, "images/");
    },
    filename: function(req, file, cb) {
        /*
            A file az, amit feltöltünk fájlként.
            Ez egy objektum, aminek az originalfilename
            tulajdonsága az eredeti fájl neve.
            Date.now() -> 1970.01.01 óta eltelt milliszekundumok számát.
            extname -> a fájl kiterjesztést adja vissza.
        */
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({storage});

router.post("/addCar", upload.array("files", 10), async (req, res) => {
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
          
            res.status(201).json({uzenet: "Sikeres feltöltés!"});

         }
         catch(err){
            console.log(err);
            res.status(400).json({uzenet: "Hiba történt!"})
         }
});

router.post("/addImages/:carId", upload.array("files",10), async (req, res) => {
   const carId = Number(req.params.carId);
   try {
      for(const file of req.files){
         await p.images.create({
            data:{
               carId:carId,
               path:file.filename
            }
         })
      }
      res.status(201).json({uzenet: "Sikeres feltöltés!"});
   } catch (error) {
      console.error('Error uploading images:', error);
      res.status(500).json({uzenet: "Hiba történt a képek feltöltése során"});
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

/*Összes tesztvezetés lekérdezése*/
router.get("/getAllTestDrives", async (req,res) => {
   try {
      const data = await p.tesztVezetesek.findMany({
         include:{
            Autok:{
               include:{
                  Images:true
               }
            },
            Users:true
         },
         orderBy: {
            datum: 'desc'
         }
      })
      res.status(200).json(data);
   } catch (error) {
      console.error('Error fetching test drives:', error);
      res.status(500).json({message: "Hiba történt a tesztvezetések lekérdezése során"});
   }
})


export { router };
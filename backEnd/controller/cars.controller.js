import { PrismaClient } from '../generated/prisma/index.js'
import express from "express";


const p = new PrismaClient();

const router = express.Router();


router.get("/getCars", async (req, res) => {

    const data  = await p.autok.findMany(
        {
            include:{
                Images:true
            }
        }
    );
    res.json(data).status(200)

});

/*Egy autó lekrdezése*/
router.get("/getCar/:id", async (req, res) => {
const autoId = Number(req.params.id)
    const data  = await p.autok.findFirst(
        {
            where:{
                id:autoId
            },
            include:{
                Images:true
            }
        }
    );
    res.json(data).status(200)

});


/*  Kedvenc autó felvétele  */
router.post("/addFav/:userId/:autotId", async (req, res) => {
  const userId = Number(req.params.userId);
  const autoId = Number(req.params.autotId);
  try {
    const matchLink = await p.kedvencek.findUnique({
      where: {
        autoId_userId: {
          autoId: autoId,
          userId: userId,
        },
      },
    });
    if (matchLink) {
      return res.status(409).json({ message: "Már szerepel a kedvencek között" });
    }

    const data = await p.kedvencek.upsert({
      where: {
        autoId_userId: {
          autoId: autoId,
          userId: userId,
        },
      },
      update: {},
      create: {
        userId: userId,
        autoId: autoId,
      },
    });
    res.status(201).json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Szerver hiba történt" });
  }
});

/*  Kínálat ellenőrzése a kívánságok alapján  */
router.get("/checkMatches/:userId", async (req, res) => {
  const userId = Number(req.params.userId);
  try {
    const wishes = await p.kivansag.findMany({
      where: { userId: userId },
    });

    if (!wishes.length) {
      return res.json({ hasMatches: false, matches: [] });
    }

    const cars = await p.autok.findMany();

    const matches = cars.filter((car) =>
      wishes.some(
        (wish) =>
          (wish.brand && car.brand.toLowerCase().includes(wish.brand.toLowerCase())) ||
          (wish.model && car.model.toLowerCase().includes(wish.model.toLowerCase())) ||
          (wish.year && car.year === wish.year)
      )
    );

    res.json({ hasMatches: matches.length > 0, matches });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Szerver hiba történt" });
  }
});

/*  1 felhasználó és egy kedvenc autója közti kapcsolat lekérdezése  */
router.get("/userfav/:userId/:autotId",async(req,res)=>{
    const userId = Number(req.params.userId)
    const autoId = Number(req.params.autotId)
    const data = await p.kedvencek.findUnique({
        where:{
            autoId_userId:{
                    autoId:autoId,
                    userId:userId
            }
        }
    })
    try{
    if(data){
        res.json({isFav:true}).status(200)
    }else {
        res.json({isFav:false}).status(200)
    }
}catch (err){
    console.error(err)
    res.status(400).json({message: "hiba"})
}
    //res.json({favBtn:false}).status(400)
})


// Összes kedvenc kapcsolat lekérdezése
router.get("/allFavs",async(req,res)=>{
    try{
        const data = await p.kedvencek.findMany()
        res.json(data).status(200)
    }catch (err){
        console.error(err)
        res.status(400).json({message: "hiba"})
    }
})

router.delete("/removeFav/:userId/:autotId",async(req,res)=>{
    const userId = Number(req.params.userId)
    const autoId = Number(req.params.autotId)

    try{
        const data = await p.kedvencek.delete({
            where:{
                autoId_userId:{
                    userId:userId,
                    autoId:autoId
                }
            }
        })
        res.json(data).status(200)
    }catch (err){
        console.error(err)
        res.status(400).json({message: "hiba"})
    }
})

//kedvenc autó törlés
router.delete("/removeFav/:id", async (req, res) => {
   const favId = Number(req.params.id);
   try {
       const data = await p.kedvencek.delete({
           where: {
               id: favId
           }
       })
       res.json(data).status(200)
   } catch (err) {
       console.error(err)
       res.status(400).json({ message: "hiba" })
   }
});

/*1 felhasználó összes kedvence lekérdezése*/
router.get("/userFavorites/:id",async(req,res)=>{
    const userId = Number(req.params.id)
    try{
    const data = await p.kedvencek.findMany({
        where:{
            userId:userId
        },
         include:{
            Autok:{
                include:{
                    Images:true
                }
            }
            
         }
    }) 
    res.json(data).status(400)}catch(err){
        console.error(err)
    }
})

/*tesztvezetés időpont felvétele*/
router.post("/test/:userId/:autoId", async (req,res) => {
    const userId = Number(req.params.userId)
    const carId= Number(req.params.autoId)
    const {date} = req.body
   try{
    const existingTestDrive = await p.tesztVezetesek.findFirst({
        where:{
            userId:userId,
            autoId:carId,
            
        }
    })
    if(existingTestDrive){
        return res.status(409).json({message: "Erre az autóra már van lefoglalt időpontja."})
    }
    if(!date){
        return res.status(401).json({message: "Kérjük, válasszon ki egy dátumot."})
    }
     const data = await p.tesztVezetesek.create({
        data:{
             userId:userId,
             autoId:carId,
             datum: new Date(date).toISOString()
        }
      })
      res.status(201).json(data);} catch(err){console.error(err)}
})


/*tesztvezetés időpontok lekérdezése*/
router.get("/geTest/:id",async (req,res) => {
    const userId = Number(req.params.id)
        const data = await p.tesztVezetesek.findMany({
            where:{
                userId:userId
            },
            include:{
                Autok:{
                    include:{
                        Images:true
                    }
                }
            }
        })
        res.json(data).status(200)
})

// tesztvezetés törlése


router.delete("/deleteTest/:testId", async (req, res) => {
   const testId = Number(req.params.testId);

   try {
       const data = await p.tesztVezetesek.delete({
           where: {
               id: testId
           }
       })
       res.json(data).status(200)
   } catch (err) {
       console.error(err)
       res.status(400).json({ message: "hiba" })
   }
});

/*Kívánt autó felvétele*/

router.post("/addWish/:id",async (req,res) => {
    const userId = Number(req.params.id)
    const {model}= req.body
    const data = await p.kivansagLlista.upsert({
        where:{
            kivantModel_userId:{
                kivantModel:model,
                userId:userId
            }
        },
        update:{

        },
        create:{
            kivantModel:model,
            userId:userId
        }
    })
    res.json(data).status(201)
})

/*Azok lekérdezése*/

router.get("/getWish/:id",async (req,res) => {
    const userId = Number(req.params.id)
        const data = await p.kivansagLlista.findMany({
            where:{
                userId:userId
            },
        })
        res.json(data).status(200)
})





export { router };
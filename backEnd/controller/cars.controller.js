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
router.post("/addFav/:userId/:autotId",async(req,res)=>{
    const userId = Number(req.params.userId)
    const autoId = Number(req.params.autotId)
try{
   const data = await p.kedvencek.upsert({
      where:{
        autoId_userId:{
            autoId:autoId,
            userId:userId
        }
      },
        update:{
            
        },
        create:{
            userId:userId,
            autoId:autoId
        }
        
    })
   res.json(data).status(201)} catch{
    res.status(400).json({message: "hiba"})
   }

})

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
    res.json({favBtn:false}).status(400)
})



/*1 felhasználó összes kedvence lekérdezése*/
router.get("/userFavorites/:id",async(req,res)=>{
    const userId = Number(req.params.id)
    try{
    const data = await p.kedvencek.findMany({
        where:{
            userId:userId
        },
         include:{
            Autok:true
         }
    }) 
    res.json(data).status(400)}catch(err){
        console.error(err)
    }
})



/*tesztvezetés időpont felvétele*/
/*tesztvezetés időpontok lekérdezése*/
/*Kívánt autó felvétele*/
/*Azok lekérdezése*/

export { router };
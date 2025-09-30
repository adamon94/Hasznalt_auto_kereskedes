import {PrismaClient } from '../generated/prisma/index.js'
import express from "express";
import createHash from '../hash.js';

const router = express.Router();
const p = new PrismaClient()

router.get("/getUsers", async (req, res) => {


});

router.post("/registration", async (req,res) => {
    const {name, password, accessLevell,email,telSzam} = req.body
    try{
         await p.users.create({
        data:{
            
            name,
            passsword: createHash(password),
            accessLevel: Number(accessLevell),
            email,
            telSzam
        }
           
    })
    res.status(201).json({message :"created"})
    } catch(err){
        console.error(err)
        res.status(400)
    }
})

export { router };
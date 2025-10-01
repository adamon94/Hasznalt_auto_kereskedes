import {PrismaClient } from '../generated/prisma/index.js'
import express from "express";
import createHash from '../hash.js';

const router = express.Router();
const p = new PrismaClient()

router.get("/getUsers", async (req, res) => {


});

router.post("/registration", async (req,res) => {
    const {name, password, email,telSzam} = req.body
    
    if (name.trim("") === "" || email.trim("") === ""|| password.trim("") === "" ){

        res.status(400).json({message:"Sikertelen regisztráció, kérem töltse ki az összes adatot!"})
        return;
    }
    
        const data = await p.users.create({
        data:{
            
            name,
            passsword: createHash(password),
            accessLevel: 0,
            email,
            telSzam
        }
           
    });
    res.json({Message:"Created"}).status(201)
})

router.get("/login", async (req,res)=> {
        const {inputName,inputPassword} = req.body; 

        const data = await p.users.findFirst({
                where:{
                    name:inputName,
                    passsword:createHash(inputPassword)
                }
        })
        if(data){
                res.status(200).json({id:data.id,isSuccess:true})
        }
        res.status(400).json({isSuccess:false});
})

export { router };
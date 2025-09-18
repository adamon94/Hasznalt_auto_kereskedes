import express from "express"

const app = express();

app.get("/api/cars", (req,res)=>{

})

app.listen(3300, ()=>{
    console.log("Elindult!")
})
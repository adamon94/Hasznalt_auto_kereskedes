import express from "express"
import cors from "cors";
import { router as carsRouter } from "./controller/cars.controller.js";
import { router as adminRouter } from "./controller/admin.controller.js";
import { router as userRouter } from "./controller/users.controller.js";

const corsOptions = {
  origin: ["http://localhost:5173"],
  optionsSuccessStatus: 200,
};

const app = express();
app.use(cors(corsOptions));
app.use(express.json());

app.use("/users", userRouter);
app.use("/admins",adminRouter);
app.use("/cars", carsRouter);

app.listen(3300, ()=>{
    console.log("Elindult!")
})
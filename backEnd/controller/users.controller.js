import {PrismaClient } from '../generated/prisma/index.js'
import {body, validationResult} from 'express-validator'
import createHash from '../hash.js';
import express from "express";

const router = express.Router();
const p = new PrismaClient()

router.get("/getUsers", async (req, res) => {

    const data = await p.users.findMany();
    res.json(data).status(200);

});

router.post("/registration",
    [
    body('name')
        .isLength({min:3})
        .withMessage("A névnek legalább 3 karakter hosszúnak kell lennie!")
        .trim(),
    body('password')
        .isLength({min:8})
        .withMessage("A jelszónak legalább 8 karakter hosszúnak kell lennie!"),
    body('checkPassword')
        .custom((value, { req }) => {
            if (value !== req.body.password) {
                throw new Error("A jelszavaknak meg kell egyezniük!");
            }
            return true;
        }),
    body('email')
        .isEmail()
        .withMessage("Kérem adjon meg egy érvényes email címet!")
        .isAscii()
        .withMessage("Az email cím csak alapvető karaktereket tartalmazhat (ékezetek nélkül)!")
        .normalizeEmail(),
    body('telSzam')
        .optional({ checkFalsy: true })
        .isString()
        /*.withMessage("A telefonszám csak szöveg lehet!")*/
    ],
    async (req,res) => {

        console.log("Registration request body:", req.body); // Debug log

        const {name, password, email,telSzam, checkPassword} = req.body;

        // Check for validation errors
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            console.log("Validation errors:", errors.array()); // Debug log
            return res.status(422).json({ 
                success: false,
                message: "Érvénytelen adatok!",
                errors: errors.array() 
            });
        }

        console.log("Validation passed, proceeding with registration"); // Debug log

        try {
            // Check if user with same email or name already exists
            const existingUser = await p.users.findFirst({
                where: {
                    OR: [
                        { email: email },
                        { name: name }
                    ]
                }
            });

            if (existingUser) {
                if (existingUser.email === email) {
                    return res.status(400).json({ 
                        message: "Ez az email cím már regisztrálva van!" 
                    });
                }
                if (existingUser.name === name) {
                    return res.status(400).json({ 
                        message: "Ez a felhasználónév már foglalt!" 
                    });
                }
            }

            // Create new user
            await p.users.create({
                data: {
                    name,
                    password: createHash(password),
                    accessLevel: 0,
                    email,
                    telSzam
                }
            });
            
            res.status(201).json({message: "Sikeres regisztráció!"});
            
        } catch (error) {
            console.error("Registration error:", error);
            res.status(500).json({ 
                message: "Szerver hiba történt a regisztráció során!" 
            });
        }
    }
); 

router.post("/login", async (req,res)=> {
    try {
        
        const {inputEmail, inputPassword} = req.body;

        // First find the user by email only
        const user = await p.users.findFirst({
            where: {
                email: inputEmail
            }
        });

        if (!user) {
            console.log("User not found:", inputEmail); // Debug log
            return res.status(400).json({
                isSuccess: false, 
                message: "Hibás email cím vagy jelszó!"
            });
        }

        // Then compare the hashed passwords
        const hashedInputPassword = createHash(inputPassword);
        console.log("Stored password hash:", user.password); // Debug log
        console.log("Input password hash:", hashedInputPassword); // Debug log

        if (user.password === hashedInputPassword) {
            console.log("Login successful for user:", user.name); // Debug log
            res.status(200).json({
                id: user.id,
                accessLevel: user.accessLevel,
                isSuccess: true
            });
        } else {
            console.log("Password mismatch for user:", user.name); // Debug log
            res.status(400).json({
                isSuccess: false, 
                message: "Hibás email cím vagy jelszó!"
            });
        }

    } catch (error) {
        console.error("Login error:", error);
        res.status(500).json({
            isSuccess: false,
            message: "Szerver hiba történt a bejelentkezés során!"
        });
    }
});

export { router };
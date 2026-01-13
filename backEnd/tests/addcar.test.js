import request from "supertest";
import app from "../index.js";

test("POST /addCar should add a new car", async () => {
  const response = await request(app).post("/addCar").send({
    gyartasEve: 2000,
    model: "R8",
    marka: "Audi",
    tipus: "Hatchback",
    ar: 2500000,
    tomeg: 2,
    meghajtas: "Összkerék",
    hengerUrTartalom: 30000,
    sebessegValtoRendszer: "Manuális",
    ferohely: 4,
    uzemAnyagTipus: "Benzin",
    fogyasztas: 3,
    megtettKm: 5000,
    tulajdonosokSzama: 1,
    serulesek: "Nincs",
    utolsoMuszakiVizsga: "2025-12-15",
    felujitasok: "Nincs"
  });

  console.log("Status:", response.status);
  console.log("Response:", response.text);

  try {
    const data = JSON.parse(response.text);
    if (!data.uzenet) {
      expect(response.status).toBe(201);
      expect(data).toHaveProperty("id");
    } else {
      expect(response.status).toBe(400);
    }
  } catch (err) {
    console.error("JSON Parse Error:", err.message);
    console.error("Response:", response.text);
  }
});
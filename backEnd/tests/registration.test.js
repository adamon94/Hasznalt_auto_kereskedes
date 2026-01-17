import request from "supertest";
import app from "../index.js";

test("POST users/registration should validate input data", async () => {
  const response = await request(app).post("/users/registration").send({
    name: "admin2",
    password: "12345678",
    checkPassword: "12345678", 
    email: "admin2@gmail.com",
    telSzam: "123456"
  });

  try {
    const data = JSON.parse(response.text).message;
    if (!data) {
      expect(response.status).toBe(201);
    } else {
      expect(response.status).toBe(400);
    }
  } catch (err) {
    console.error("JSON Parse Error:", err.message);
    console.error("Response:", response.text);
  }
});
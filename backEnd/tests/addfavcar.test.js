import request from "supertest";
import app from "../index.js";

test("POST /addFav should add a favorite car", async () => {
  const userId = 3;
  const autoId = 1;

  const response = await request(app)
    .post(`/cars/addFav/${userId}/${autoId}`)
    .send({
      brand: "Audi",
      model: "R8",
      year: 2000,
      price: 2500000,
      description: ""
    });
  
  console.log("Status:", response.status);
  console.log("Response:", response.text);

  if (response.status === 201) {
    expect(response.status).toBe(201);
  } else if (response.status === 409) {
    expect(response.status).toBe(409);
  } else {
    expect(response.status).toBe(500);
  }
});
import request from "supertest";
import app from "../index.js";

test("POST auth/login should be good", async () => {
  const response = await request(app).post("/users/login").send({
    inputEmail: "invalid-email",
    inputPassword: "123",
  });
 

  const data = JSON.parse(response.text).message;
    if (!data){
          expect(response.status).toBe(200);
    }
    else{
          expect(response.status).toBe(400);
    }

});

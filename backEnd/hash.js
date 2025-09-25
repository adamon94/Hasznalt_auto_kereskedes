import cryptro from "crypto";


function createHash(password) {
   
    const hash = cryptro.createHash("sha512")
    .update(password).digest("hex");

    return hash;
}

export default createHash;
import router from "./routes/userRoutes.js";
import router2 from "./routes/petRoutes.js";
import router3 from "./routes/CitaRoutes.js";
import { createPool } from "mysql2/promise";
import express from "express";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

const port = 3000;

// Configuración de CORS

// Configuración del body parser para manejar las solicitudes JSON
app.use(router);
app.use(router2);
app.use(router3);

// Configuración de la conexión a la base de datos MySQL
export const pool = createPool({
  host: "dno6xji1n8fm828n.cbetxkdyhwsb.us-east-1.rds.amazonaws.com",
  port: "3306",
  user: "nrwstpucaf50xu84",
  password: "unn80x8bkiwrzgm5",
  database: "vqz518dddao7thbt",
});
// Inicia el servidor
app.listen(port, "0.0.0.0", () => {
  console.log(`Server running on port ${port}`);
});

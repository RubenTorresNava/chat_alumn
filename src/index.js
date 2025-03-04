import { PORT } from "./config.js";
import app from "./app.js";
import connection from "./service/connection.js";

const start = async () => {
    try {
        await connection.connect(); //nos conectamos a la base de datos
        app.listen(PORT, () => { //iniciamos el servidor
        .log(`Servidor inciciado en http://localhost:${PORT}`);
        });
    } catch (error) {
        .error("Error error al iniciar el servidor:", error.message);
    }
};

start(); //iniciamos la aplicacion
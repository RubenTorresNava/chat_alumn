import express from "express"; //importamos express
import * as mensajesRoute from "../controller/mensajes.controller.js"; //importamos las funciones de los usuarios
import { auth, checkRole } from "../middleware/auth.middleware.js"; //importamos el middleware de autenticacion

const router = express.Router(); //creamos el router

router.post("/conversations", auth, mensajesRoute.createConversationAndMessage); //ruta para crear una conversacion y un mensaje

export default router; //exportamos el router
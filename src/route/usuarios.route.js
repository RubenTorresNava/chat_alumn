/*
archivo que contiene las rutas de los usuarios
*/

import express from "express"; //importamos express
import * as usuariosRoute from "../controller/usuarios.controller.js"; //importamos las funciones de los usuarios
import { auth, checkRole } from "../middleware/auth.middleware.js"; //importamos el middleware de autenticacion

const router = express.Router(); //creamos el router

router.post("/signup", usuariosRoute.signUp); //ruta para registrar un usuario
router.post("/signin", usuariosRoute.signIn); //ruta para iniciar sesion
router.get("/conversations", auth, usuariosRoute.getConversations); //ruta para obtener las conversaciones de un usuario
router.get("/conversations/:id/:messages", auth, usuariosRoute.getMessages); //ruta para obtener una conversacion
export default router; //exportamos el router
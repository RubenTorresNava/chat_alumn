/*
archivo que contiene el middleware de autenticacion, que se encarga de comprobar si el usuario esta autenticado
y manejo de los tokens de autenticacion.
*/
import jwt from "jsonwebtoken"; //importamos jsonwebtoken para generar tokens
import { JWT_SECRET } from "../config.js"; //importamos la clave secreta para los tokens

//middleware que comprueba si el usuario esta autenticado
export const auth = (req, res, next) => {
    try {
        // Obtener el token del header
        const token = req.headers.authorization?.split(' ')[1];
        if (!token) {
            console.log(req.headers.authorization);
            return res.status(401).send('No se proporcionó un token');
        }

        // Verificar el token
        const user = jwt.verify(token, JWT_SECRET);
        req.user = user; // Guardar el usuario en la request
        next(); // Pasar al siguiente middleware
    } catch (error) {
        console.error('Error en auth:', error.message);
        res.status(401).send('No autorizado'); // Si hay un error, devolver un mensaje de error
    }
};

//verificar el rol del usuario
export const checkRole = (role) => (req, res, next) => {
    try {
        if(req.user.tipo === role){ //comprobamos si el usuario tiene el rol necesario
            next(); //pasamos al siguiente middleware
        } else {
            res.status(403).send("No tienes permiso para acceder a este recurso"); //si no tiene permiso devolvemos un mensaje de error
        }
    } catch (error) {
        console.error("Error en checkRole:", error.message);
        res.status(500).send(error.message);
    }
};

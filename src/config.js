/*
archivo de configuracion de variables de entorno para la aplicacion
*/

import { config } from "dotenv"; //importamos dotenv para leer las variables de entorno

config(); //leemos las variables de entorno

export const PORT = process.env.PORT || 3000; //definimos el puerto de la aplicacion
export const POSTGRES_USER = process.env.POSTGRES_USER //definimos el usuario de la base de datos
export const POSTGRES_PASSWORD = process.env.POSTGRES_PASSWORD //definimos la contraseña de la base de datos
export const POSTGRES_DB = process.env.POSTGRES_DB //definimos el nombre de la base de datos
export const POSTGRES_PORT = process.env.POSTGRES_PORT //definimos el puerto de la base de datos
export const POSTGRES_HOST = process.env.POSTGRES_HOST //definimos el host de la base de datos
export const JWT_SECRET = process.env.JWT_SECRET //definimos la clave secreta para el token


/*
archivo de configuracion de la base de datos de postgres usando pg
*/

import  pkg  from "pg"; //importamos pg para conectarnos a la base de datos
import { POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB, POSTGRES_PORT, POSTGRES_HOST } from "../config.js"; //importamos las variables de entorno

const { Pool } = pkg; //extraemos el objeto Pool de pg

const connection = new Pool({ //creamos una nueva instancia de Pool
  user: POSTGRES_USER, //definimos el usuario de la base de datos
  password: POSTGRES_PASSWORD, //definimos la contraseña de la base de datos
  database: POSTGRES_DB, //definimos el nombre de la base de datos
  port: POSTGRES_PORT, //definimos el puerto de la base de datos
  host: POSTGRES_HOST //definimos el host de la base de datos
});

export default connection; //exportamos la instancia de Pool
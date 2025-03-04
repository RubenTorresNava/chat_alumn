/*
archivo que contiene las funciones que hacen los usuarios
*/
import connection from "../service/connection.js"; //importamos la conexion a la base de datos
import bcrypt from "bcrypt"; //importamos bcrypt para encriptar las contraseñas
import jwt from "jsonwebtoken"; //importamos jsonwebtoken para generar tokens
import { JWT_SECRET } from "../config.js"; //importamos la clave secreta para los tokens

//registrar un usuario
export const signUp = async (req, res) => {
    try {
        const { nombre, email, tipo, password } = req.body;

        // Validar que los campos estén presentes
        if (!nombre || !email || !tipo || !password) {
            return res.status(400).send({ message: 'Nombre, email, tipo y contraseña son requeridos' });
        }

        // Hashear la contraseña
        const passwordHash = await bcrypt.hash(password, 10);

        // Insertar el usuario en la base de datos
        const query = `
            INSERT INTO usuarios (nombre, email, tipo, password)
            VALUES ($1, $2, $3, $4)
            RETURNING id_usuario;
        `;
        const values = [nombre, email, tipo, passwordHash];

        const result = await connection.query(query, values);

        // Verificar si se insertó correctamente
        if (result.rowCount === 1) {
            const newUser = result.rows[0]; // Obtener el usuario insertado
            res.status(201).send({ message: 'Usuario creado', user: newUser });
        } else {
            res.status(500).send({ message: 'Error al crear el usuario' });
        }
    } catch (error) {
        console.error("Error en signUp:", error.message);

        // Manejar errores de duplicidad (usuario ya existe)
        if (error.code === '23505') { // Código de error de PostgreSQL para violación de restricción única
            return res.status(409).send({ message: 'El usuario ya existe' });
        }

        res.status(500).send({ message: 'Se ha producido un error', error: error.message });
    }
};

//iniciar sesion
export const signIn = async (req, res) => {
    try {
        const { email, password } = req.body;

        // Validar que email y password estén presentes
        if (!email || !password) {
            return res.status(400).send({ message: 'Email y contraseña son requeridos' });
        }

        // Buscar el usuario en la base de datos
        const query = 'SELECT * FROM usuarios WHERE email = $1'; // Usar $1 para PostgreSQL
        const values = [email]; // Pasar el email como parámetro

        const result = await connection.query(query, values);

        // Verificar si el usuario existe
        if (result.rows.length === 0) {
            return res.status(404).send({ message: 'El usuario no existe' });
        }

        const user = result.rows[0]; // Obtener el primer usuario encontrado

        // Comparar la contraseña proporcionada con el hash almacenado
        const isPasswordCorrect = await bcrypt.compare(password, user.password);

        if (!isPasswordCorrect) {
            return res.status(401).send({ message: 'Contraseña incorrecta' });
        }
 
        // Generar un token JWT
        const token = jwt.sign({ id_usuario: user.id_usuario }, JWT_SECRET, { expiresIn: '24h' });

        // Enviar la respuesta con el token
        res.status(200).send({ message: 'Sesión iniciada', token });
    } catch (error) {
        res.status(500).send({ message: 'Se ha producido un error', error: error.message });
    }
};

//obtener las conversaciones de un usuario con el token de autenticacion
export const getConversations = async (req, res) => {
    try {
        const userID = req.user.id_usuario; // Acceder al ID del usuario autenticado
        // Consulta SQL para obtener las conversaciones
        const query = `
        SELECT 
            c.id_conversacion,
            c.asunto,
            u_remitente.nombre AS remitente,
            u_destinatario.nombre AS destinatario,
            m.nombre_materia AS materia,
            c.fecha_creacion
        FROM 
            Conversaciones c
        JOIN 
            Usuarios u_remitente ON c.id_usuario_remitente = u_remitente.id_usuario
        JOIN 
            Usuarios u_destinatario ON c.id_usuario_destinatario = u_destinatario.id_usuario
        LEFT JOIN  -- Usar LEFT JOIN para incluir conversaciones sin materia
            Materias m ON c.id_materia = m.id_materia
        WHERE 
            c.id_usuario_remitente = $1 OR c.id_usuario_destinatario = $1
        ORDER BY 
            c.fecha_creacion DESC;
        `;

        // Ejecutar la consulta con el ID del usuario
        const result = await connection.query(query, [userID]);

        // Devolver las conversaciones
        res.status(200).send(result.rows);
    } catch (error) {
        res.status(500).send({ message: 'Error al obtener las conversaciones' });
    }
};

//obtener los mensajes de una conversacion
export const getMessages = async (req, res) => {
    try {
        const { id_conversacion } = req.params; // Obtener el id_conversacion de los parámetros de la URL
        const userId = req.user.id_usuario; // Obtener el id del usuario logueado desde el middleware de autenticación
        // Consulta SQL para obtener los mensajes de la conversación
        const query = `
            SELECT 
                m.id_mensaje,
                m.contenido,
                m.estado,
                u_remitente.nombre AS remitente,
                u_destinatario.nombre AS destinatario,
                m.fecha_envio
            FROM 
                Mensajes m
            JOIN 
                Conversaciones c ON m.id_conversacion = c.id_conversacion
            JOIN 
                Usuarios u_remitente ON m.id_usuario_remitente = u_remitente.id_usuario
            JOIN 
                Usuarios u_destinatario ON c.id_usuario_destinatario = u_destinatario.id_usuario
            WHERE 
                c.id_conversacion = $1
                AND (c.id_usuario_remitente = $2 OR c.id_usuario_destinatario = $3)
            ORDER BY 
                m.fecha_envio;
        `;

        // Ejecutar la consulta
        const result = await connection.query(query, [id_conversacion, userId, userId]);

        // Devolver los resultados
        res.status(200).json(result.rows); // En PostgreSQL, los resultados están en result.rows
    } catch (error) {
        res.status(500).json({ message: "Error al obtener los mensajes de la conversación" });
    }
};
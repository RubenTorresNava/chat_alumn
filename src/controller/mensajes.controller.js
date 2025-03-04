import connection from "../service/connection.js"; //importamos la conexion a la base de datos

export const createConversationAndMessage = async (req, res) => {
    try {
        const { id_materia, nombre_destinatario, asunto, contenido } = req.body;

        if (!nombre_destinatario || !contenido) {
            return res.status(400).json({ message: "Faltan campos obligatorios" });
        }
        // Obtener el id_usuario_remitente desde el middleware de autenticación
        const id_usuario_remitente = req.user.id_usuario;

        // Obtener el id_usuario_destinatario basado en el nombre del destinatario
        const getDestinatarioIdQuery = `
            SELECT id_usuario 
            FROM usuarios 
            WHERE LOWER(nombre) = LOWER($1);
        `;

        const destinatarioResult = await connection.query(getDestinatarioIdQuery, [nombre_destinatario]);

        if (destinatarioResult.rows.length === 0) {
            return res.status(404).json({ message: "El destinatario no existe" });
        }

        const id_usuario_destinatario = destinatarioResult.rows[0].id_usuario;

        // Verificar si la conversación ya existe
        const checkConversationQuery = `
            SELECT id_conversacion 
            FROM conversaciones 
            WHERE id_usuario_remitente = $1 
              AND id_usuario_destinatario = $2 
              AND asunto = $3;
        `;

        const checkConversationResult = await connection.query(checkConversationQuery, [
            id_usuario_remitente,
            id_usuario_destinatario, // Usar el id_usuario_destinatario obtenido
            asunto,
        ]);

        let id_conversacion;

        if (checkConversationResult.rows.length > 0) {
            // Si la conversación ya existe, usar su ID
            id_conversacion = checkConversationResult.rows[0].id_conversacion;
        } else {
            // Si la conversación no existe, crearla
            const insertConversationQuery = `
                INSERT INTO conversaciones (id_materia, id_usuario_remitente, id_usuario_destinatario, asunto)
                VALUES ($1, $2, $3, $4)
                RETURNING id_conversacion;
            `;

            // Si id_materia no está definido, se inserta NULL
            const conversationResult = await connection.query(insertConversationQuery, [
                id_materia || null, // Si id_materia es undefined, se inserta NULL
                id_usuario_remitente,
                id_usuario_destinatario, // Usar el id_usuario_destinatario obtenido
                asunto,
            ]);

            id_conversacion = conversationResult.rows[0].id_conversacion;
        }

        // Insertar el nuevo mensaje
        const insertMessageQuery = `
            INSERT INTO mensajes (id_conversacion, id_usuario_remitente, contenido)
            VALUES ($1, $2, $3)
            RETURNING id_mensaje;
        `;

        const messageResult = await connection.query(insertMessageQuery, [
            id_conversacion,
            id_usuario_remitente,
            contenido,
        ]);

        // Devolver los IDs de la conversación y el mensaje creados
        res.status(201).json({
            message: "Mensaje creado exitosamente",
            id_mensaje: messageResult.rows[0].id_mensaje,
        });
    } catch (error) {
        res.status(500).json({ message: "Error al crear la conversación y el mensaje" });
    }
};
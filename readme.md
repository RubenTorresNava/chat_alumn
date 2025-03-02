crear un archivo .env con el siguiente contenido:
PORT=3000
POSTGRES_USER=postgres
POSTGRES_PASSWORD=[poner_tu_contraseña]
POSTGRES_DB=chat_alumn
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
JWT_SECRET=secret

para iniciar el proyecto ingresa el siguiente comando:
node src/index.js
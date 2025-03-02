import express, { json } from 'express';
import morgan from 'morgan';
import corse from 'cors';
import UseariosRoute from './route/usuarios.route.js';

const app = express();

app.use(morgan('dev'));
app.use(corse());
app.use(express.json());

app.get('/', (req, res) => {
    res.json({ message: 'Hello World' });
});

app.use('/api/usuarios', UseariosRoute);

export default app;
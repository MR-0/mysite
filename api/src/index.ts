import express, { json, Express, Request, Response } from 'express';
import helmet from 'helmet';
import morgan from 'morgan';
import config from './config';
import log from './logger';
import brandsRouter from './v1/routes/brands';

const app: Express = express();

app.use(helmet())
app.use(json());
if (config.isDev) app.use(morgan('tiny'))
app.use(brandsRouter)

app.get('/', (req: Request, res: Response) => {
  res.send('Hola');
});

app.listen(config.PORT, () => {
  log(`⚡️[server]: Server is running at https://localhost:${config.PORT}`);
});

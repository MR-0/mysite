import dotenv from 'dotenv'
import express, { json, Express, Request, Response } from 'express';
import helmet from 'helmet';
import morgan from 'morgan';

dotenv.config()

const app: Express = express();
const port = process.env.PORT;

app.use(helmet())
app.use(json());
app.use(morgan('tiny'))

const brands = [
  { id: '1', name: 'Brand 1', image: 'bucket/images/brand_id/image.jpg'}
]

app.get('/', (req: Request, res: Response) => {
  res.send('Hola');
});

app.get('/brands', (_req, res) => {
  res.send(brands);
});

app.get('/brands/:id', (req, res) => {
  const brand = brands.find(({ id }) => id === req.params.id);
  if (!brand) return res.sendStatus(404);
  return res.send(brand);
});

app.post('/brands', (req, res) => {
  const brand = {
    id: (brands.length + 1).toString(),
    ...req.body
  };
  brands.push(brand)
  res.send(brand);
});

app.put('/brands/:id', (req, res) => {
  const index = brands.map(({ id }) => id).indexOf(req.params.id);
  if (index < 0) return res.sendStatus(404);
  brands[index] = {
    ...brands[index],
    ...req.body
  }
  res.send(brands[index]);
});

app.delete('/brands/:id', (req, res) => {
  const index = brands.map(({ id }) => id).indexOf(req.params.id);
  if (index < 0) return res.sendStatus(404);
  res.send(brands.splice(index, 1).pop());
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at https://localhost:${port}`);
});

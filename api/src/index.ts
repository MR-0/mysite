import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv'

dotenv.config()

const app: Express = express();
const port = process.env.PORT;

app.use(express.json());

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
  if (!brand) res.sendStatus(404);
  else res.send(brand);
});

app.post('/brands', (req, res) => {
  const brand = {
    id: brands.length + 1,
    ...req.body
  };
  brands.push(brand)
  res.send(brand);
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at https://localhost:${port}`);
});

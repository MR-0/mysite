import express from 'express';

const router = express.Router();

const brands = [
  { id: '1', name: 'Brand 1', image: 'bucket/images/brand_id/image.jpg'}
]

router.get('/brands', (_req, res) => {
  res.send(brands);
});

router.get('/brands/:id', (req, res) => {
  const brand = brands.find(({ id }) => id === req.params.id);
  if (!brand) return res.sendStatus(404);
  return res.send(brand);
});

router.post('/brands', (req, res) => {
  const brand = {
    id: (brands.length + 1).toString(),
    ...req.body
  };
  brands.push(brand)
  res.send(brand);
});

router.put('/brands/:id', (req, res) => {
  const index = brands.map(({ id }) => id).indexOf(req.params.id);
  if (index < 0) return res.sendStatus(404);
  brands[index] = {
    ...brands[index],
    ...req.body
  }
  res.send(brands[index]);
});

router.delete('/brands/:id', (req, res) => {
  const index = brands.map(({ id }) => id).indexOf(req.params.id);
  if (index < 0) return res.sendStatus(404);
  res.send(brands.splice(index, 1).pop());
});

export default router
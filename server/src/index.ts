import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { PrismaClient } from '@prisma/client';

dotenv.config();

const app = express();
const prisma = new PrismaClient();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Test database connection
app.get('/db-test', async (req, res) => {
  try {
    const userCount = await prisma.user.count();
    const cardCount = await prisma.card.count();
    res.json({ 
      status: 'connected',
      users: userCount,
      cards: cardCount
    });
  } catch (error) {
    res.status(500).json({ status: 'error', message: String(error) });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
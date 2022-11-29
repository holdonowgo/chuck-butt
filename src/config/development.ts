import dotenv from 'dotenv';

dotenv.config();

const keys = {
  schema: ["public", "private"],
  jwtSecret: process.env.DEV_JWT_SECRET,
  databaseURL: process.env.DEV_DATABASE_URL,
  databaseUser: process.env.DEV_DATABASE_USER,
  databasePassword: process.env.DEV_DATABASE_PASSWORD,
  watch: true,
}

export default keys;

import dotenv from 'dotenv';
import { IEnvConfig } from './config';

dotenv.config();

const envConfig: IEnvConfig = {
  schema: ["public", "private"],
  jwtSecret: process.env.JWT_SECRET,
  databaseURL: process.env.DATABASE_URL,
  databaseUser: process.env.DATABASE_USER,
  databasePassword: process.env.DATABASE_PASSWORD,
  databaseName: process.env.DATABASE_NAME,
  host: process.env.DEV_HOST,
  port: process.env.DEV_PORT ? parseInt(process.env.DEV_PORT) : 5432,
  watch: true,
}

export default envConfig;

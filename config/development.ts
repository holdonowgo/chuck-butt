import dotenv from 'dotenv';
import { IEnvConfig } from './config';

dotenv.config();

const envConfig: IEnvConfig = {
  schema: ["public", "private"],
  jwtSecret: process.env.DEV_JWT_SECRET,
  databaseURL: process.env.DEV_DATABASE_URL,
  databaseUser: process.env.DEV_DATABASE_USERNAME,
  databasePassword: process.env.DEV_DATABASE_PASSWORD,
  databaseName: process.env.DEV_DATABASE_NAME,
  host: process.env.DEV_HOST,
  port: process.env.DEV_PORT ? parseInt(process.env.DEV_PORT) : 5432,
  watch: true,
}

export default envConfig;

import dotenv from 'dotenv';
import { IEnvConfig } from './config';

dotenv.config();

const envConfig: IEnvConfig = {
  schema: ["public", "private"],
  jwtSecret: process.env.JWT_SECRET,
  databaseURL: process.env.DATABASE_URL,
  databaseUser: process.env.DATABASE_USERNAME,
  databasePassword: process.env.DATABASE_PASSWORD,
  databaseName: process.env.DATABASE_NAME,
  host: process.env.HOST,
  port: process.env.PORT ? parseInt(process.env.PORT) : 5432,
  watch: true,
}

export default envConfig;

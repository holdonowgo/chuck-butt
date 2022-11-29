import dotenv from 'dotenv';

dotenv.config();

const keys = {
  schema: ["public", "private"],
  jwtSecret: process.env.JWT_SECRET,
  databaseURL: process.env.DATABASE_URL,
  databaseUser: process.env.DATABASE_USER,
  databasePassword: process.env.DATABASE_PASSWORD,
  // connection: "postgres://Randall.Spencer:@localhost:5432/chuckster",
  // defaultRole: "myapp_anonymous",
  // jwtTokenIdentifier: "myApp.jwt_token",
  watch: true,
}

export default keys;

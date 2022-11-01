import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import * as bodyParser from 'body-parser';

dotenv.config();

const app: Express = express();
import { postgraphile, PostGraphileOptions } from 'postgraphile';

const { PORT } = process.env

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

const postgraphileOptions: PostGraphileOptions = {
  subscriptions: true,
  watchPg: true,
  dynamicJson: true,
  setofFunctionsContainNulls: false,
  ignoreRBAC: false,
  showErrorStack: 'json',
  extendedErrors: ['hint', 'detail', 'errcode'],
  appendPlugins: [require('@graphile-contrib/pg-simplify-inflector')],
  exportGqlSchemaPath: 'schema.graphql',
  graphiql: true,
  enhanceGraphiql: true,
  allowExplain(_req: any) {
    // TODO: customise condition!
    return true;
  },
  enableQueryBatching: true,
  legacyRelations: 'omit',
  // pgSettings(req: any) {
  //   /* TODO */
  // },
  jwtSignOptions: { algorithm: 'RS256' },
  jwtPgTypeIdentifier: 'public.jwt_token',
  jwtSecret: 'secret',
};

app.use(
  postgraphile(
    process.env.DATABASE_URL || 'postgres://Randall.Spencer:@localhost:5432/chuckster',
    'public',
    { ...postgraphileOptions }
  )
);

app.get('/', (req: Request, res: Response) => {
  // console.log(req);
  res.send('Express + TypeScript Server the terminal is watching you');
});

app.listen(PORT, () => console.log(`⚡️[server]: Server is running at https://localhost:${PORT}`));
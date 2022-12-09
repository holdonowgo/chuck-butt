import express, { Express, Request, Response } from 'express';
import { postgraphile, PostGraphileOptions } from 'postgraphile';
import cors from 'cors';
import dotenv from 'dotenv';
import * as bodyParser from 'body-parser';

import fs from 'fs';

dotenv.config();

const app: Express = express();

const { PORT } = process.env

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

import productionKeys from '../config/production'
import developmentKeys from '../config/development'
import { ConfigLevel, EnvConfigMap } from '../config/config';


const mappedEnvConfigs: EnvConfigMap = {
  production: productionKeys,
  development: developmentKeys,
  test: developmentKeys,
};

const envConfig = mappedEnvConfigs[process.env.NODE_ENV as ConfigLevel];

const RSA_PRIVATE_KEY = fs.readFileSync(__dirname + '/../jwtRS256.key');

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
  jwtSecret: RSA_PRIVATE_KEY,
};

app.use(
  postgraphile(
    envConfig.databaseURL,
    ['public', 'private'],
    { ...postgraphileOptions }
  )
);

app.get('/', (req: Request, res: Response) => {
  res.send('Express + TypeScript Server the terminal is watching you');
});

app.listen(PORT, () => console.log(`⚡️[server]: Server is running at https://localhost:${PORT}`));

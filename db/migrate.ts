import { migrate } from "postgres-migrations"
import pg from "pg"

import productionKeys from '../config/production'
import developmentKeys from '../config/development'
import { ConfigLevel, EnvConfigMap } from '../config/config';



const mappedEnvConfigs: EnvConfigMap = {
  production: productionKeys,
  development: developmentKeys,
  test: developmentKeys,
};

const envConfig = mappedEnvConfigs[process.env.NODE_ENV as ConfigLevel];

// // If you want sane date handling, it is recommended you use the following code snippet to fix a node - postgres bug:
// const pg = require("pg")
// const parseDate = (val) =>
//   val === null ? null : moment(val).format("YYYY-MM-DD")
// const DATATYPE_DATE = 1082
// pg.types.setTypeParser(DATATYPE_DATE, (val) => {
//   return val === null ? null : parseDate(val)
// })

(async function (): Promise<void> {
  const dbConfig: pg.ClientConfig = {
    database: envConfig.databaseName,
    user: envConfig.databaseUser,
    password: envConfig.databasePassword,
    host: envConfig.host,
    port: envConfig.port || 5432,
  }

  // Note: when passing a client, it is assumed that the database already exists
  const client = new pg.Client(dbConfig) // or a Pool, or a PoolClient
  await client.connect()
  try {
    await migrate({ client }, "./db/migrations")
  } finally {
    await client.end()
  }
})()

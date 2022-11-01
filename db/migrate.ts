import { migrate } from "postgres-migrations"
// import moment from 'moment';
import pg from "pg"

// // If you want sane date handling, it is recommended you use the following code snippet to fix a node - postgres bug:
// const pg = require("pg")
// const parseDate = (val) =>
//   val === null ? null : moment(val).format("YYYY-MM-DD")
// const DATATYPE_DATE = 1082
// pg.types.setTypeParser(DATATYPE_DATE, (val) => {
//   return val === null ? null : parseDate(val)
// })

(async function (): Promise<void> {
  const dbConfig = {
    database: "chuckster",
    user: "Randall.Spencer",
    password: "",
    host: "localhost",
    port: 5432,
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

// import { migrate } from "postgres-migrations"

// async function() {
//   const dbConfig = {
//     database: "database-name",
//     user: "postgres",
//     password: "password",
//     host: "localhost",
//     port: 5432,

//     // Default: false for backwards-compatibility
//     // This might change!
//     ensureDatabaseExists: true

//     // Default: "postgres"
//     // Used when checking/creating "database-name"
//     defaultDatabase: "postgres"
//   }

//   await migrate(dbConfig, "path/to/migration/files")
// }
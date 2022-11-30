export interface IEnvConfig {
  readonly schema?: string[];
  readonly jwtSecret?: string;
  readonly databaseURL?: string;
  readonly databaseName?: string;
  readonly databaseUser?: string;
  readonly databasePassword?: string;
  readonly host?: string;
  readonly port?: number;
  readonly watch?: boolean;
}

export type ConfigLevel = 'development' | 'test' | 'production'

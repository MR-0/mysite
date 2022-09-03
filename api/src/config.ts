import dotenv from 'dotenv'

dotenv.config({ override: true })

interface configInterface {
  PORT?: number,
  NODE_ENV?: 'development' | 'production',
  isDev?: boolean,
  isProd?: boolean,
}

const defaults = {
  PORT: 3300,
  NODE_ENV: 'development'
}

const config:configInterface = {
  ...defaults as configInterface,
  ...process.env
}

config.isDev = config.NODE_ENV === 'development';
config.isProd = config.NODE_ENV === 'production';

export default config
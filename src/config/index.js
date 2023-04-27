require("dotenv").config();
module.exports = {
  VERSION: "/v1",
  PORT: 8080,
  mysql: {
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    insecureAuth: true,
    dateStrings: true,
    charset: "utf8mb4",
  },
  tokens: {
    JWT_SECRETE_KEY: process.env.JWT_SECRETE_KEY,
  },
  google_storage: {
    BUCKET_NAME: process.env.BUCKET_NAME,
    GOOGLE_CLOUD_KEY_FILE: process.env.GOOGLE_CLOUD_KEY_FILE,
  },
  smsglobal: {
    API_KEY: process.env.SMSGLOBAL_API_KEY,
    SECRETE_KEY: process.env.SMSGLOBAL_SECRETE_KEY,
  },
};

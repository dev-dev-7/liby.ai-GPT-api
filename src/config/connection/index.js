const config = require("../../config");

const DBConnection = require("knex")({
  client: "mysql",
  connection: config.mysql,
  useNullAsDefault: true,
});
DBConnection.raw("SELECT 1")
  .then(() => {
    console.log("DB " + config.mysql.host + " connected");
  })
  .catch((e) => {
    console.log("DB not connected");
    console.error(e);
  });

module.exports = DBConnection;

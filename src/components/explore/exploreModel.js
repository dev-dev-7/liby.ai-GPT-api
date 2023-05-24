const db = require("../../config/connection");
const tableMessages = "tbl_messages";

const getMessage = (id) => {
  return db(tableMessages).where("id", id).first();
};

module.exports = {
  getMessage,
};

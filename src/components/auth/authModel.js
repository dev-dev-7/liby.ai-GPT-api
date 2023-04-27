const db = require("../../config/connection");
const Hash = require("../../helpers/hash");
const userTable = "tbl_users";

const createUser = async ({ mobie }) => {
  return db(userTable)
    .insert({
      mobie: mobie,
    })
    .then((user_id) => getUserById(user_id));
};

const updateUser = async (user_id, data) => {
  return db(userTable)
    .where("user_id", user_id)
    .update(data)
    .then((updated) => getUserById(user_id));
};

const updateUserByMobile = async (mobile, data) => {
  return db(userTable)
    .where("mobile", mobile)
    .update(data)
    .then((updated) => getUserByMobile(mobile));
};

const getUsers = () => {
  return db(userTable);
};

const getUserById = (user_id) => {
  return db(userTable).where("user_id", user_id).first();
};

const getUserByEmail = (email) => {
  return db(userTable).where("email", email).first();
};

const getUserByMobile = (mobile) => {
  return db(userTable).where("mobile", mobile).first();
};

const deleteUserById = (user_id) => {
  return db(userTable).where("user_id", user_id).del();
};

module.exports = {
  createUser,
  updateUser,
  updateUserByMobile,
  getUsers,
  getUserById,
  getUserByEmail,
  getUserByMobile,
  deleteUserById,
};

const db = require("../../config/connection");
const tableChats = "tbl_chats";
const chatCategories = "tbl_chat_categories";

const createChat = async ({ user_id, category_id, question, answer }) => {
  return db(tableChats)
    .insert({
      user_id: user_id,
      category_id: category_id,
      question: question,
      answer: answer,
      status: 1,
    })
    .then((id) => getChatById(id));
};

const getChatById = (id) => {
  return db(tableChats).where("id", id).first();
};

const updateChat = async (id, data) => {
  return db(tableChats)
    .where("id", id)
    .update(data)
    .then((updated) => getChatById(id));
};

const getRecentChats = (user_id, category_id) => {
  return db(tableChats)
    .where("user_id", user_id)
    .andWhere("category_id", category_id)
    .orderBy("id", "asc")
    .limit(200);
};

const getCategories = () => {
  return db(chatCategories).where("status", 1);
};

const getCategoryById = (id) => {
  return db(chatCategories).where("id", id).first();
};

module.exports = {
  createChat,
  getChatById,
  updateChat,
  getCategories,
  getCategoryById,
  getRecentChats,
};

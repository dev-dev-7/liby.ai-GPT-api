const db = require("../../config/connection");
const tableMessages = "tbl_messages";
const chatCategories = "tbl_chat_categories";

const createMessage = async ({
  user_id,
  category_id,
  question,
  answer,
  likes,
}) => {
  return db(tableMessages)
    .insert({
      user_id: user_id,
      category_id: category_id,
      question: question,
      answer: answer,
      likes: likes,
      status: 1,
    })
    .then((id) => getMessageById(id));
};

const getMessageById = (id) => {
  return db(tableMessages).where("id", id).first();
};

const updateMessage = async (id, data) => {
  return db(tableMessages)
    .where("id", id)
    .update(data)
    .then((updated) => getMessageById(id));
};

const deleteMessageById = (id) => {
  return db(tableMessages).where("id", id).del();
};

const getRecentMessages = (user_id, category_id) => {
  return db(tableMessages)
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
  createMessage,
  getMessageById,
  deleteMessageById,
  updateMessage,
  getCategories,
  getCategoryById,
  getRecentMessages,
};

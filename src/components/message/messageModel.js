const db = require("../../config/connection");
const tableMessages = "tbl_messages";
const chatCategories = "tbl_chat_categories";

const createMessage = async ({
  user_id,
  category_id,
  question,
  answer,
  likes,
  translate,
}) => {
  return db(tableMessages)
    .insert({
      user_id: user_id,
      category_id: category_id,
      type: "message",
      question: question,
      answer: answer,
      likes: likes,
      status: 1,
      translate: translate,
    })
    .then((id) => getMessageById(id[0] ? id[0] : id));
};

const getMessageById = (id) => {
  return db(tableMessages).where("id", id).first();
};

const getLastMessageByCategory = (user_id, category_id) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("category_id", category_id)
    .orderBy("id", "desc")
    .first();
};

const updateMessage = async (id, data) => {
  return db(tableMessages)
    .where("id", id)
    .update(data)
    .then((updated) => getMessageById(id));
};

const updateMessageByUserCategory = async (user_id, category_id, data) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("category_id", category_id)
    .update(data);
};

const deleteMessageById = (id) => {
  return db(tableMessages).where("id", id).del();
};

const getRecentMessages = (user_id, category_id) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("category_id", category_id)
    .andWhere("clear", 0)
    .andWhere("type", "message")
    .orderBy("id", "desc");
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
  updateMessageByUserCategory,
  getCategories,
  getCategoryById,
  getLastMessageByCategory,
  getRecentMessages,
};

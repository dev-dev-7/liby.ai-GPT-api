const db = require("../../config/connection");
const common = require("../../helpers/common");
const tableMessages = "tbl_messages";

const createAudio = async ({ user_id, question, answer, likes }) => {
  return db(tableMessages)
    .insert({
      user_id: user_id,
      type: "audio",
      question: question,
      answer: answer,
      likes: likes,
      status: 1,
    })
    .then((id) => getAudioById(id[0] ? id[0] : id));
};

const getAudioById = (id) => {
  return db(tableMessages).where("id", id).first();
};

const updateAudio = async (id, data) => {
  return db(tableMessages)
    .where("id", id)
    .update(data)
    .then((updated) => getAudioById(id));
};

const updateAudioByUserCategory = async (user_id, data) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("type", "audio")
    .update(data);
};

const deleteAudioById = (id) => {
  return db(tableMessages).where("id", id).del();
};

const getRecentAudios = async (user_id, page = "") => {
  const pagination = await common.getPagination(page, 20);
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("clear", 0)
    .andWhere("type", "audio")
    .orderBy("id", "desc")
    .limit(pagination.limit)
    .offset(pagination.offset);
};

const getAllRecentAudios = (user_id) => {
  return db(tableMessages)
    .count("id as total")
    .where("user_id", user_id)
    .andWhere("type", "audio")
    .andWhere("clear", 0)
    .first();
};

const getAudios = async (page = "1") => {
  const pagination = await common.getPagination(page, 20);
  return db(tableMessages)
    .where("clear", 0)
    .andWhere("type", "audio")
    .orderBy("id", "desc")
    .limit(pagination.limit)
    .offset(pagination.offset);
};

const getAllAudios = async () => {
  return db(tableMessages)
    .count("id as total")
    .where("type", "audio")
    .andWhere("clear", 0)
    .first();
};

module.exports = {
  createAudio,
  getAudioById,
  deleteAudioById,
  updateAudio,
  updateAudioByUserCategory,
  getRecentAudios,
  getAllRecentAudios,
  getAudios,
  getAllAudios,
};

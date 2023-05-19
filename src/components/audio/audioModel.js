const db = require("../../config/connection");
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
    .then((id) => getAudioById(id));
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

const getRecentAudios = (user_id) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("clear", 0)
    .andWhere("type", "audio")
    .orderBy("id", "desc");
};

module.exports = {
  createAudio,
  getAudioById,
  deleteAudioById,
  updateAudio,
  updateAudioByUserCategory,
  getRecentAudios,
};

const db = require("../../config/connection");
const common = require("../../helpers/common");
const tableMessages = "tbl_messages";

const createVideo = async ({ user_id, question, answer, likes }) => {
  return db(tableMessages)
    .insert({
      user_id: user_id,
      type: "video",
      question: question,
      answer: answer,
      likes: likes,
      status: 1,
    })
    .then((id) => getVideoById(id[0] ? id[0] : id));
};

const getVideoById = (id) => {
  return db(tableMessages).where("id", id).first();
};

const updateVideo = async (id, data) => {
  return db(tableMessages)
    .where("id", id)
    .update(data)
    .then((updated) => getVideoById(id));
};

const updateVideoByUserCategory = async (user_id, data) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("type", "video")
    .update(data);
};

const deleteVideoById = (id) => {
  return db(tableMessages).where("id", id).del();
};

const getRecentVideos = (user_id) => {
  return db(tableMessages)
    .where("user_id", user_id)
    .andWhere("clear", 0)
    .andWhere("type", "video")
    .orderBy("id", "desc");
};

const getAllVideos = async (page = "") => {
  const pagination = await common.getPagination(page, 10);
  return db(tableMessages)
    .where("clear", 0)
    .andWhere("type", "video")
    .orderBy("id", "desc")
    .limit(pagination.limit)
    .offset(pagination.offset);
};

module.exports = {
  createVideo,
  getVideoById,
  deleteVideoById,
  updateVideo,
  updateVideoByUserCategory,
  getRecentVideos,
  getAllVideos,
};

const db = require('../../config/connection')
const common = require('../../helpers/common')
const tableMessages = 'tbl_messages'

const createImage = async ({ user_id, question, answer, likes }) => {
  return db(tableMessages)
    .insert({
      user_id: user_id,
      type: 'image',
      question: question,
      answer: answer,
      likes: likes,
      status: 1,
    })
    .then((id) => getImageById(id[0] ? id[0] : id))
}

const getImageById = (id) => {
  return db(tableMessages).where('id', id).first()
}

const updateImage = async (id, data) => {
  return db(tableMessages)
    .where('id', id)
    .update(data)
    .then((updated) => getImageById(id))
}

const updateImageByUserCategory = async (user_id, data) => {
  return db(tableMessages)
    .where('user_id', user_id)
    .andWhere('type', 'image')
    .update(data)
}

const deleteImageById = (id) => {
  return db(tableMessages).where('id', id).del()
}

const getRecentImages = (user_id) => {
  return db(tableMessages)
    .where('user_id', user_id)
    .andWhere('clear', 0)
    .andWhere('type', 'image')
    .orderBy('id', 'desc')
}

const getAllImages = async (page = '') => {
  const pagination = await common.getPagination(page, 40)
  return db(tableMessages)
    .where('clear', 0)
    .andWhere('type', 'image')
    .orderBy('id', 'desc')
    .limit(pagination.limit)
    .offset(pagination.offset)
}

module.exports = {
  createImage,
  getImageById,
  deleteImageById,
  updateImage,
  updateImageByUserCategory,
  getRecentImages,
  getAllImages,
}

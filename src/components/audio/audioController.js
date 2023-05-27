require('dotenv').config()
const audioModel = require('./audioModel')
const authorization = require('../../helpers/authorization')
const { validationResult } = require('express-validator')
const { Configuration, OpenAIApi } = require('openai')
const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
})
const openai = new OpenAIApi(configuration)
const gTTS = require('gtts')
const fs = require('fs')
const { makeid } = require('../../helpers/common')
const {
  createBlobFromReadStream,
} = require('../../components/file/fileService')
const { deleteFile } = require('../../../downloadUrl')

exports.createAudio = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  let question = req.body.question
  // const completion = await openai.createChatCompletion({
  //   model: "gpt-3.5-turbo",
  //   messages: [{ role: "user", content: question }],
  // });
  // answer = completion.data.choices[0].message.content;
  answer = question
  if (answer && user) {
    let fileName = (await makeid(10)) + '.mp3'
    const gtts = new gTTS(answer, req.body.language ? req.body.language : 'ar')
    gtts.save(fileName, async function (err) {
      let stream = fs.createReadStream(fileName)
      let answer = await createBlobFromReadStream(fileName, stream)
      if (err) {
        throw new Error(err)
      }
      var body = {
        user_id: user.user_id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      }
      chat = await audioModel.createAudio(body)
      deleteFile(fileName)
      return res.status(201).json({
        data: chat,
      })
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.updateAudio = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  let question = req.body.question
  // const completion = await openai.createChatCompletion({
  //   model: "gpt-3.5-turbo",
  //   messages: [{ role: "user", content: question }],
  // });
  // answer = completion.data.choices[0].message.content;
  answer = question
  if (answer && user) {
    let fileName = (await makeid(10)) + '.mp3'
    const gtts = new gTTS(answer, req.body.language ? req.body.language : 'ar')
    gtts.save(fileName, async function (err) {
      let stream = fs.createReadStream(fileName)
      let answer = await createBlobFromReadStream(fileName, stream)
      if (err) {
        throw new Error(err)
      }
      var body = {
        user_id: user.user_id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      }
      chat = await audioModel.updateAudio(req.params.id, body)
      deleteFile(fileName)
      return res.status(201).json({
        data: chat,
      })
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.deleteAudio = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  let image = await audioModel.getAudioById(req.params.id)
  if (image.user_id == user.user_id) {
    chats = await audioModel.deleteAudioById(image.id)
    return res.status(200).json({
      msg: 'Audio has been succesfully deleted',
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.recentAudios = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  if (user) {
    let audios = await audioModel.getRecentAudios(user.user_id)
    let totalrecords = await audioModel.getAllRecentAudios(user.user_id)
    return res.status(200).json({
      data: audios,
      currentPage: Math.round(req.params.page),
      prevPage: req.params.page > 1 ? true : false,
      nextPage: audios.length > 9 ? true : false,
      totalPages: Math.round(totalrecords.total / 10),
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.explore = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  if (user) {
    let audios = await audioModel.getAudios(req.params.page)
    let totalrecords = await audioModel.getAllAudios()
    return res.status(200).json({
      data: audios,
      currentPage: Math.round(req.params.page),
      prevPage: req.params.page > 1 ? true : false,
      nextPage: audios.length > 9 ? true : false,
      totalPages: Math.round(totalrecords.total / 10),
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.like = async (req, res) => {
  if (req.params.id) {
    // let user = await authorization.authorization(req, res);
    let image = await audioModel.getAudioById(req.params.id)
    if (image) {
      var body = {
        likes: image.likes + 1,
      }
      chat = await audioModel.updateAudio(req.params.id, body)
      return res.status(201).json({
        msg: 'Like action has been execeuted!',
      })
    } else {
      return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
    }
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.clearAudios = async (req, res) => {
  let user = await authorization.authorization(req, res)
  if (user) {
    var body = {
      clear: 1,
    }
    await audioModel.updateAudioByUserCategory(user.user_id, body)
    return res.status(201).json({
      msg: 'Clear action has been execeuted!',
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

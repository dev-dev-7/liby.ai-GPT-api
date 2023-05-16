require('dotenv').config()
const chatModel = require('./imageModel')
const authorization = require('../../helpers/authorization')
const { validationResult } = require('express-validator')
const { Configuration, OpenAIApi } = require('openai')
const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
})
const openai = new OpenAIApi(configuration)

exports.createImage= async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let question = req.body.question;
  let answer;
  const completion = await openai.createImage({
    prompt: question,
    n: 1,
    size: "1024x1024",
  })
  answer = completion.data.data[0].url;
  if (answer) {
    let user = await authorization.authorization(req, res)
    if (user) {
      var body = {
        user_id: user.user_id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      }
      chat = await chatModel.createImage(body)
      chat.language = req.body.language
      return res.status(201).json({
        data: chat,
      })
    } else {
      return res.status(404).json({ errors: [{ msg: 'Error generating!!!!' }] })
    }
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.updateImage= async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let question = await req.body.question;
  let answer;
  const completion = await openai.createImage({
    prompt: question,
    n: 1,
    size: "1024x1024",
  })
  answer = completion.data.data[0].url;
  if (answer) {
    let user = await authorization.authorization(req, res)
    if (user) {
      var body = {
        user_id: user.user_id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      }
      chat = await chatModel.updateImage(req.params.id, body)
      chat.language = req.body.language
      return res.status(201).json({
        data: chat,
      })
    } else {
      return res.status(404).json({ errors: [{ msg: 'Error generating!!!!' }] })
    }
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.deleteImage= async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  let image = await chatModel.getImageById(req.params.id)
  if (image.user_id == user.user_id) {
    chats = await chatModel.deleteImageById(image.id)
    return res.status(200).json({
      msg: 'Image has been succesfully deleted',
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.recentImages = async (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() })
  }
  let user = await authorization.authorization(req, res)
  if (user) {
    let images = await chatModel.getRecentImages(user.user_id)
    return res.status(200).json({
      data: images,
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

exports.like = async (req, res) => {
  if (req.params.id) {
    // let user = await authorization.authorization(req, res);
    let image = await chatModel.getImageById(req.params.id)
    if (image) {
      var body = {
        likes: image.likes + 1,
      }
      chat = await chatModel.updateImage(req.params.id, body)
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

exports.clearImages= async (req, res) => {
  let user = await authorization.authorization(req, res)
  if (user) {
    var body = {
      clear: 1,
    }
    await chatModel.updateImageByUserCategory(
      user.user_id,
      body,
    )
    return res.status(201).json({
      msg: 'Clear action has been execeuted!',
    })
  } else {
    return res.status(404).json({ errors: [{ msg: 'Invalid request' }] })
  }
}

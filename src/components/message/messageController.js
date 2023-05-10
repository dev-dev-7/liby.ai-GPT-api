require("dotenv").config();
const chatModel = require("./messageModel");
const authorization = require("../../helpers/authorization");
const { validationResult } = require("express-validator");
const { Configuration, OpenAIApi } = require("openai");
const { getPostFix } = require("../../helpers/chatGptPostfix");
const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

exports.getCategories = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let categories = await chatModel.getCategories();
  if (categories?.length) {
    return res.status(201).json({
      data: categories,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "No data available" }] });
  }
};

exports.createMessage = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let question = await getPostFix(
    req.body.question,
    req.body.category_id,
    req.body.language
  );
  let answer;
  if (req.body.category_id == 1) {
    const completion = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: question,
      max_tokens: 100,
      temperature: 0,
    });
    answer = completion.data.choices[0].text;
  } else {
    const completion = await openai.createChatCompletion({
      model: "gpt-3.5-turbo",
      messages: [{ role: "system", content: question }],
    });
    answer = completion.data.choices[0].message.content;
  }
  if (answer) {
    let user = await authorization.authorization(req, res);
    let category = await chatModel.getCategoryById(req.body.category_id);
    if (user && category) {
      var body = {
        user_id: user.user_id,
        category_id: category.id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      };
      chat = await chatModel.createMessage(body);
      return res.status(201).json({
        data: chat,
      });
    } else {
      return res
        .status(404)
        .json({ errors: [{ msg: "Error generating!!!!" }] });
    }
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.updateMessage = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let question = await getPostFix(
    req.body.question,
    req.body.category_id,
    req.body.language
  );
  if (req.body.category_id == 1) {
    const completion = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: question,
      max_tokens: 100,
      temperature: 0,
    });
    answer = completion.data.choices[0].text;
  } else {
    const completion = await openai.createChatCompletion({
      model: "gpt-3.5-turbo",
      messages: [{ role: "system", content: question }],
    });
    answer = completion.data.choices[0].message.content;
  }
  if (answer && req.params.id) {
    let user = await authorization.authorization(req, res);
    let category = await chatModel.getCategoryById(req.body.category_id);
    if (user && category) {
      var body = {
        user_id: user.user_id,
        category_id: category.id,
        question: req.body.question,
        answer: answer,
        likes: 0,
      };
      chat = await chatModel.updateMessage(req.params.id, body);
      return res.status(201).json({
        data: chat,
      });
    } else {
      return res
        .status(404)
        .json({ errors: [{ msg: "Error generating!!!!" }] });
    }
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.deleteMessage = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let message = await chatModel.getMessageById(req.params.id);
  if (message.user_id == user.user_id) {
    chats = await chatModel.deleteMessageById(message.id);
    return res.status(200).json({
      msg: "Message has been succesfully deleted",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.recentMessages = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let category = await chatModel.getCategoryById(req.body.category_id);
  if (user && category) {
    chats = await chatModel.getRecentMessages(user.user_id, category.id);
    return res.status(200).json({
      data: chats,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.like = async (req, res) => {
  if (req.params.id) {
    // let user = await authorization.authorization(req, res);
    let message = await chatModel.getMessageById(req.params.id);
    if (message) {
      var body = {
        likes: message.likes + 1,
      };
      chat = await chatModel.updateMessage(req.params.id, body);
      return res.status(201).json({
        msg: "Like action has been execeuted!",
      });
    } else {
      return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
    }
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.clearMessage = async (req, res) => {
  let user = await authorization.authorization(req, res);
  if (user) {
    var body = {
      clear: 1,
    };
    console.log(user.user_id);
    await chatModel.updateMessageByUserCategory(
      user.user_id,
      req.params.category_id,
      body
    );
    return res.status(201).json({
      msg: "Clear action has been execeuted!",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

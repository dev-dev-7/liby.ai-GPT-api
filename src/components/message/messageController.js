require("dotenv").config();
const chatModel = require("./messageModel");
const authModel = require("../auth/authModel");
const authorization = require("../../helpers/authorization");
const { validationResult } = require("express-validator");
const { Configuration, OpenAIApi } = require("openai");
const { getPostFix } = require("../../helpers/chatGptPostfix");
const { getDate, convertToDate } = require("../../helpers/time");
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
  let user = await authorization.authorization(req, res);
  let question = await getPostFix(
    req.body.question,
    req.body.category_id,
    req.body.translate,
    req.body.language
  );
  let answer;
  let messages = [{ role: "user", content: question }];
  if (req.body.category_id == 1) {
    let lastMessage = await chatModel.getLastMessageByCategory(
      user.user_id,
      req.body.category_id
    );
    if (lastMessage && convertToDate(lastMessage.created_at) === getDate()) {
      messages.push({ role: "assistant", content: lastMessage.answer });
    }
  }
  const completion = await openai.createChatCompletion({
    model: "gpt-3.5-turbo",
    messages: messages,
  });
  answer = completion.data.choices[0].message.content;
  if (answer) {
    let category = await chatModel.getCategoryById(req.body.category_id);
    if (user && category) {
      var body = {
        user_id: user.user_id,
        category_id: category.id,
        question: req.body.question,
        answer: answer,
        likes: 0,
        translate: req.body.translate,
      };
      chat = await chatModel.createMessage(body);
      chat.language = req.body.language;
      await authModel.createTokenHistory(chat);
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
  let user = await authorization.authorization(req, res);
  let question = await getPostFix(
    req.body.question,
    req.body.category_id,
    req.body.translate,
    req.body.language
  );
  let messages = [{ role: "user", content: question }];
  const completion = await openai.createChatCompletion({
    model: "gpt-3.5-turbo",
    messages: messages,
  });
  answer = completion.data.choices[0].message.content;
  if (answer && req.params.id) {
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
      chat.language = req.body.language;
      await authModel.createTokenHistory(chat);
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
        likes: message.likes ? 0 : 1,
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
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    await chatModel.clearMessages(user.user_id, req.params.ids);
    return res.status(201).json({
      msg: "Messages has been cleared!!!",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

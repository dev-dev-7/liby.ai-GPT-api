require("dotenv").config();
const chatModel = require("./chatModel");
const authController = require("../auth/authController");
const authModel = require("../auth/authModel");
const { validationResult } = require("express-validator");

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

exports.createChat = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authController.authorization(req, res);
  let category = await chatModel.getCategoryById(req.body.category_id);
  if (user && category) {
    var body = {
      user_id: user.user_id,
      category_id: category.id,
      question: req.body.question,
      answer: req.body.question,
    };
    chat = await chatModel.createChat(body);
    return res.status(201).json({
      data: chat,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.recentChats = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authController.authorization(req, res);
  let category = await chatModel.getCategoryById(req.body.category_id);
  if (user && category) {
    chats = await chatModel.getRecentChats(user.user_id, category.id);
    return res.status(200).json({
      data: chats,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

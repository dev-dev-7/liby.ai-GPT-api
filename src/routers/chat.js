const express = require("express");
const router = express.Router();
const verifyToken = require("./../helpers/verifyToken");
const chatController = require("../components/chat/chatController");
const validation = require("../helpers/validation/chat");

// Chat
router.get("/categories", [verifyToken], chatController.getCategories);
router.post(
  "/create-chat",
  [validation.chat, verifyToken],
  chatController.createChat
);
router.post(
  "/recent-chats",
  [validation.recentChat, verifyToken],
  chatController.recentChats
);

module.exports = router;

const express = require("express");
const router = express.Router();
const verifyToken = require("./../helpers/verifyToken");
const chatController = require("../components/message/messageController");
const validation = require("../helpers/validation/message");

// Chat
router.get("/categories", [verifyToken], chatController.getCategories);
router.post(
  "/message",
  [validation.message, verifyToken],
  chatController.createMessage
);
router.put(
  "/message/:id",
  [validation.message, verifyToken],
  chatController.updateMessage
);
router.delete("/message/:id", [verifyToken], chatController.deleteMessage);
router.post(
  "/get-messages",
  [validation.recentMessage, verifyToken],
  chatController.recentMessages
);
router.put("/message/like/:id", [verifyToken], chatController.like);
router.get("/message/clear/:category_id", [verifyToken], chatController.clearMessage);

module.exports = router;

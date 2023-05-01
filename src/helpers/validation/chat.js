const { check, body } = require("express-validator");

exports.chat = [check("category_id").notEmpty(), check("question").notEmpty()];
exports.recentChat = [
  check("user_id").notEmpty(),
  check("category_id").notEmpty(),
];

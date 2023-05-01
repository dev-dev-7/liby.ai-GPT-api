const { check, body } = require("express-validator");

exports.chat = [check("category_id").notEmpty(), check("question").notEmpty()];
exports.recentChat = [check("category_id").notEmpty()];

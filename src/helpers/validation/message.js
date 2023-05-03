const { check, body } = require("express-validator");

exports.message = [
  check("category_id").notEmpty(),
  check("question").notEmpty(),
];
exports.recentMessage = [check("category_id").notEmpty()];

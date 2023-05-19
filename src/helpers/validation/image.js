const { check, body } = require("express-validator");

exports.image = [check("question").notEmpty(), check("type").notEmpty()];

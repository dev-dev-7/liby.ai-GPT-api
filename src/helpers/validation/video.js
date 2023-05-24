const { check, body } = require("express-validator");

exports.video = [check("question").notEmpty(), check("type").notEmpty()];

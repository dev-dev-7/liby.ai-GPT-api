const { check, body } = require("express-validator");

exports.audio = [check("question").notEmpty()];

const { check, body } = require("express-validator");

exports.change_status = [check("status").notEmpty()];

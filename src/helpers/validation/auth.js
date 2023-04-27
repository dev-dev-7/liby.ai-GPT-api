const { check, body } = require("express-validator");

// AUTH VALIDATION
exports.login_validation = [check("mobile").notEmpty()];

exports.update = [check("name").notEmpty(), check("email").notEmpty()];

exports.otp = [check("mobile").notEmpty(), check("mobile_otp").notEmpty()];

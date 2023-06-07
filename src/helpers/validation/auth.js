const { check, body } = require("express-validator");

// AUTH VALIDATION
exports.login_validation = [check("mobile").notEmpty()];

exports.update = [check("name").notEmpty(), check("email").notEmpty()];

exports.otp = [check("mobile").notEmpty(), check("mobile_otp").notEmpty()];

exports.resend_otp = [check("mobile").notEmpty()];

exports.package = [check("package_id").notEmpty()];

exports.contact = [
  check("first_name").notEmpty(),
  check("last_name").notEmpty(),
  check("email").notEmpty(),
  check("mobile").notEmpty(),
  check("message").notEmpty(),
];

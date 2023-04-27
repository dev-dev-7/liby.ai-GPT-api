const express = require("express");
const router = express.Router();
const verifyToken = require("./../helpers/verifyToken");
const authController = require("../components/auth/authController");
const validation = require("../helpers/validation/auth");

// Auth
router.post("/auth", validation.login_validation, authController.login);

router.post("/verify-otp", validation.otp, authController.verifyOtp);

router.put("/update", [validation.update, verifyToken], authController.update);

module.exports = router;

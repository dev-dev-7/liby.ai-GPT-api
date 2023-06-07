const express = require("express");
const router = express.Router();
const verifyToken = require("./../helpers/verifyToken");
const authController = require("../components/auth/authController");
const validation = require("../helpers/validation/auth");

// Auth
router.post("/auth", validation.login_validation, authController.login);

router.post("/verify-otp", validation.otp, authController.verifyOtp);

router.post("/resend-otp", validation.resend_otp, authController.resendOtp);

router.post(
  "/subscribe",
  [validation.package, verifyToken],
  authController.subscribe
);

router.get("/user", [verifyToken], authController.getUserDetails);

router.put(
  "/profile/update/:user_id",
  [validation.update, verifyToken],
  authController.update
);

router.get("/plans", [verifyToken], authController.getPlan);
router.post("/contact", validation.contact, authController.contact);

module.exports = router;

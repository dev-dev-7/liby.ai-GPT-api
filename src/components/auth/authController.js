require("dotenv").config();
const authModel = require("./authModel");
const authorization = require("../../helpers/authorization");
const jwt = require("jsonwebtoken");
const config = require("../../config/index");
const { validationResult } = require("express-validator");
const { JWT_SECRETE_KEY } = config.tokens;
const { sendMessage } = require("../../helpers/smsglobal");

exports.login = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authModel.getUserByMobile(req.body.mobile);
  if (!user) {
    user = await authModel.createUser(req.body);
  }
  if (user) {
    let otp = 1111; //  Math.floor(1000 + Math.random() * 9000);
    await authModel.updateUser(user.user_id, {
      mobile_otp: otp,
    });
    await sendMessage(req.body.mobile, otp);
    return res.status(201).json({
      data: {
        user: user,
      },
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.verifyOtp = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty())
    return res.status(400).json({ errors: errors.array() });
  let mobile = await authModel.getUserByMobile(req.body.mobile);
  if (mobile.mobile_otp == req.body.mobile_otp) {
    let user = await authModel.updateUser(mobile.user_id, {
      status: 1,
      mobile_otp: Math.floor(1000 + Math.random() * 9000),
    });
    const token = jwt.sign({ user: user }, JWT_SECRETE_KEY);
    return res.status(201).json({
      data: {
        user: user,
        msg: "Otp has been verified",
      },
      token,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid otp code" }] });
  }
};

exports.resendOtp = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let otp = 1111; // Math.floor(1000 + Math.random() * 9000);
  let user = await authModel.updateUserByMobile(req.body.mobile, {
    mobile_otp: otp,
  });
  if (user) {
    await sendMessage(req.body.mobile, otp);
    return res.status(200).json({
      msg: "New otp has been Sent",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Not Found" }] });
  }
};

exports.update = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty())
    return res.status(400).json({ errors: errors.array() });
  let user = await authModel.getUserById(req.params.user_id);
  if (user) {
    await authModel.updateUser(req.params.user_id, {
      name: req.body.name,
      email: req.body.email,
      mobile: req.body.mobile,
      notification: req.body.notification,
    });
    return res.status(201).json({
      data: await authModel.getUserById(req.params.user_id),
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Not Found" }] });
  }
};

exports.getUserDetails = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    return res.status(200).json({
      data: await authModel.getUserById(user.user_id),
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Not Found" }] });
  }
};

exports.subscribe = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    return res.status(200).json({
      msg: "Payment link generated",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Not Found" }] });
  }
};

exports.getPlan = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let plans = await authModel.getPlans();
  if (plans) {
    return res.status(200).json({
      data: plans,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Not Found" }] });
  }
};

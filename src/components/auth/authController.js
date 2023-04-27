require("dotenv").config();
const authModel = require("./authModel");
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
    user = await authModel.createUser(req.body.mobile);
  }
  if (user) {
    await authModel.updateUser(user.user_id, {
      mobile_otp: Math.floor(100000 + Math.random() * 900000),
    });
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
    let user = await authModel.updateUser(req.body.user_id, {
      status: 1,
      mobile_otp: Math.floor(100000 + Math.random() * 900000),
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
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.resendOtp = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authModel.updateUserByMobile(req.body.mobile, {
    mobile_otp: Math.floor(100000 + Math.random() * 900000),
  });
  if (user) {
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
    });
    return res.status(201).json({
      data: await authModel.getUserById(req.params.user_id),
    });
  } else {
    return res.status(400).json({ errors: [{ msg: result }] });
  }
};

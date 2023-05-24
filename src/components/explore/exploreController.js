require("dotenv").config();
const exploreModel = require("./exploreModel");
const { validationResult } = require("express-validator");

exports.explore = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let message = await exploreModel.getMessage(req.params.id);
  if (message) {
    return res.status(200).json({
      data: message,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

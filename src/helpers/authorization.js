require("dotenv").config();
const config = require("../config/index");
const jwt = require("jsonwebtoken");
const { JWT_SECRETE_KEY } = config.tokens;

exports.authorization = async (req, res) => {
  if (req.headers && req.headers.authorization) {
    var authorization = req.headers.authorization.split(" ")[1],
      decoded;
    try {
      decoded = jwt.verify(authorization, JWT_SECRETE_KEY);
    } catch (e) {
      return res.status(401).send("unauthorized");
    }
    if (decoded?.user) {
      return decoded?.user;
    } else {
      return null;
    }
  }
  return res.send(500);
};

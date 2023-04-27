const jwt = require("jsonwebtoken");
const config = require("../config/index");

function verifyToken(req, res, next) {
  const bearerHeader = req.headers["authorization"];
  if (typeof bearerHeader !== "undefined") {
    const bearerToken = bearerHeader.split(" ")[1];
    try {
      req.token = bearerToken;
      let user = jwt.verify(req.token, config.tokens.JWT_SECRETE_KEY);
      if (user) {
        req.user = user.user;
      }
      next();
    } catch (e) {
      console.error(e);
      res.status(401).json({ errors: [{ msg: "Invalid credentials" }] });
    }
  } else {
    res.sendStatus(403);
  }
}

module.exports = verifyToken;

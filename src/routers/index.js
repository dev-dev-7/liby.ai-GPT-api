const express = require("express");
const router = express.Router();

const auth = require("./auth");
const file = require("./file");
const message = require("./message");

// Home Page
router.get("/", (req, res) => {
  res.send("Welcome to the Liby.ai");
});

router.use("/", auth);
router.use("/", file);
router.use("/", message);

module.exports = router;

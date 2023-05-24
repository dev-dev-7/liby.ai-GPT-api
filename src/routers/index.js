const express = require("express");
const router = express.Router();

const auth = require("./auth");
const file = require("./file");
const message = require("./message");
const image = require("./image");
const audio = require("./audio");
const video = require("./video");
const explore = require("./explore");

// Home Page
router.get("/", (req, res) => {
  res.send("Welcome to the Liby.ai");
});

router.use("/", auth);
router.use("/", file);
router.use("/", message);
router.use("/", image);
router.use("/", audio);
router.use("/", video);
router.use("/", explore);

module.exports = router;

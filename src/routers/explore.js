const express = require("express");
const router = express.Router();
const exploreController = require("../components/explore/exploreController");

// Explore
router.get("/explore/:id", exploreController.explore);

module.exports = router;

const express = require("express");
const router = express.Router();
const fileController = require("../components/file/fileController");

router.post("/upload-file", fileController.uploadMultiFiles);

module.exports = router;

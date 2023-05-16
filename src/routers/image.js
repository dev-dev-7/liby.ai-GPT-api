const express = require("express");
const router = express.Router();
const verifyToken = require("../helpers/verifyToken");
const chatController = require("../components/image/imageController");
const validation = require("../helpers/validation/image");

// Image
router.post(
  "/image",
  [validation.image, verifyToken],
  chatController.createImage
);
router.put(
  "/image/:id",
  [validation.image, verifyToken],
  chatController.updateImage
);
router.delete("/image/:id", [verifyToken], chatController.deleteImage);
router.post(
  "/get-images",
  [verifyToken],
  chatController.recentImages
);
router.put("/image/like/:id", [verifyToken], chatController.like);
router.get("/image/clear/:category_id", [verifyToken], chatController.clearImage);

module.exports = router;

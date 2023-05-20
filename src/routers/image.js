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
router.post("/get-images", [verifyToken], chatController.recentImages);
router.get("/image/explore/:page", [verifyToken], chatController.explore);
router.put("/image/like/:id", [verifyToken], chatController.like);
router.get(
  "/images/clear/:category_id",
  [verifyToken],
  chatController.clearImages
);

module.exports = router;

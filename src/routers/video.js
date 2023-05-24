const express = require("express");
const router = express.Router();
const verifyToken = require("../helpers/verifyToken");
const videoController = require("../components/video/videoController");
const validation = require("../helpers/validation/video");

// Video
router.post(
  "/video",
  [validation.video, verifyToken],
  videoController.createVideo
);
router.put(
  "/video/:id",
  [validation.video, verifyToken],
  videoController.updateVideo
);
router.delete("/video/:id", [verifyToken], videoController.deleteVideo);
router.post("/get-videos", [verifyToken], videoController.recentVideos);
router.get("/video/explore/:page", [verifyToken], videoController.explore);
router.put("/video/like/:id", [verifyToken], videoController.like);
router.get(
  "/videos/clear/:category_id",
  [verifyToken],
  videoController.clearVideos
);

module.exports = router;

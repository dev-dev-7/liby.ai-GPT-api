const express = require("express");
const router = express.Router();
const verifyToken = require("../helpers/verifyToken");
const audioController = require("../components/audio/audioController");
const validation = require("../helpers/validation/audio");

// audio
router.post(
  "/audio",
  [validation.audio, verifyToken],
  audioController.createAudio
);
router.put(
  "/audio/:id",
  [validation.audio, verifyToken],
  audioController.updateAudio
);
router.delete("/audio/:id", [verifyToken], audioController.deleteAudio);
router.post("/get-audios", [verifyToken], audioController.recentAudios);
router.put("/audio/like/:id", [verifyToken], audioController.like);
router.get(
  "/audios/clear/:category_id",
  [verifyToken],
  audioController.clearAudios
);

module.exports = router;

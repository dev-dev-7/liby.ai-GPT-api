require("dotenv").config();
const videoModel = require("./videoModel");
const authorization = require("../../helpers/authorization");
const { validationResult } = require("express-validator");
const { Configuration, OpenAIApi } = require("openai");
const fs = require("fs");
const { download, deleteFile } = require("../../../downloadUrl");

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

exports.createVideo = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let question = req.body.question;
  if (req.body.type == "variation") {
    let fileName = question.substring(
      question.lastIndexOf("/") + 1,
      question.length
    );
    await download(question, fileName, async function () {
      let stream = fs.createReadStream(fileName);
      let result = await openai.createVideoVariation(stream, 1, "1024x1024");
      let variation = result.data.data[0].url;
      if (variation) {
        await deleteFile(fileName);
        if (user) {
          var body = {
            user_id: user.user_id,
            question: question,
            answer: variation,
            likes: 0,
          };
          chat = await videoModel.createVideo(body);
          chat.language = req.body.language;
          return res.status(201).json({
            data: chat,
          });
        } else {
          return res.status(401).json({ errors: [{ msg: "Unauthorized" }] });
        }
      } else {
        return res
          .status(404)
          .json({ errors: [{ msg: "Error generating!!!!" }] });
      }
    });
  } else {
    let completion = await openai.createVideo({
      prompt: question,
      n: 1,
      size: "1024x1024",
    });
    let answer = completion.data.data[0].url;
    if (answer) {
      if (user) {
        var body = {
          user_id: user.user_id,
          question: req.body.question,
          answer: answer,
          likes: 0,
        };
        chat = await videoModel.createVideo(body);
        chat.language = req.body.language;
        return res.status(201).json({
          data: chat,
        });
      } else {
        return res.status(401).json({ errors: [{ msg: "Unauthorized" }] });
      }
    } else {
      return res
        .status(404)
        .json({ errors: [{ msg: "Error generating!!!!" }] });
    }
  }
};

exports.updateVideo = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let question = await req.body.question;
  if (req.body.type == "variation") {
    let fileName = question.substring(
      question.lastIndexOf("/") + 1,
      question.length
    );
    await download(question, fileName, async function () {
      let stream = fs.createReadStream(fileName);
      let result = await openai.createVideoVariation(stream, 1, "1024x1024");
      let variation = result.data.data[0].url;
      if (variation) {
        if (user) {
          var body = {
            user_id: user.user_id,
            question: req.body.question,
            answer: variation,
            likes: 0,
          };
          chat = await videoModel.updateVideo(req.params.id, body);
          return res.status(201).json({
            data: chat,
          });
        } else {
          return res.status(401).json({ errors: [{ msg: "Unauthorized" }] });
        }
      } else {
        return res
          .status(404)
          .json({ errors: [{ msg: "Error generating!!!!" }] });
      }
    });
  } else {
    let completion = await openai.createVideo({
      prompt: question,
      n: 1,
      size: "1024x1024",
    });
    let answer = completion.data.data[0].url;
    if (answer) {
      if (user) {
        var body = {
          user_id: user.user_id,
          question: req.body.question,
          answer: answer,
          likes: 0,
        };
        chat = await videoModel.updateVideo(req.params.id, body);
        chat.language = req.body.language;
        return res.status(201).json({
          data: chat,
        });
      } else {
        return res.status(401).json({ errors: [{ msg: "Unauthorized" }] });
      }
    } else {
      return res
        .status(404)
        .json({ errors: [{ msg: "Error generating!!!!" }] });
    }
  }
};

exports.deleteVideo = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let video = await videoModel.getVideoById(req.params.id);
  if (video.user_id == user.user_id) {
    chats = await videoModel.deleteVideoById(video.id);
    return res.status(200).json({
      msg: "Video has been succesfully deleted",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.recentVideos = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    let images = await videoModel.getRecentVideos(user.user_id);
    return res.status(200).json({
      data: images,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.explore = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    let images = await videoModel.getAllVideos(req.params.page);
    let totalVideos = await videoModel.getAllVideos();
    return res.status(200).json({
      data: images,
      currentPage: Math.round(req.params.page),
      prevPage: req.params.page > 1 ? true : false,
      nextPage: images.length > 9 ? true : false,
      totalPages: Math.round(totalVideos.length / 10),
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.like = async (req, res) => {
  if (req.params.id) {
    // let user = await authorization.authorization(req, res);
    let video = await videoModel.getVideoById(req.params.id);
    if (video) {
      var body = {
        likes: video.likes + 1,
      };
      chat = await videoModel.updateVideo(req.params.id, body);
      return res.status(201).json({
        msg: "Like action has been execeuted!",
      });
    } else {
      return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
    }
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.clearVideos = async (req, res) => {
  let user = await authorization.authorization(req, res);
  if (user) {
    var body = {
      clear: 1,
    };
    await videoModel.updateVideoByUserCategory(user.user_id, body);
    return res.status(201).json({
      msg: "Clear action has been execeuted!",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

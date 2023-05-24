require("dotenv").config();
const imageModel = require("./imageModel");
const authorization = require("../../helpers/authorization");
const { validationResult } = require("express-validator");
const { Configuration, OpenAIApi } = require("openai");
const fs = require("fs");
const { download, deleteFile } = require("../../../downloadUrl");
const {
  createBlobFromReadStream,
} = require("../../components/file/fileService");

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

exports.createImage = async (req, res) => {
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
      console.log(fileName);
      let stream = fs.createReadStream(fileName);
      let result = await openai.createImageVariation(stream, 2, "1024x1024");
      let variation = result.data.data[0].url;
      if (variation) {
        await deleteFile(fileName);
        // Upload to ishrostorage
        if (user) {
          let fileName = Date.now() + ".png";
          await download(variation, fileName, async function () {
            let stream = fs.createReadStream(fileName);
            let answer = await createBlobFromReadStream(fileName, stream);
            if (answer) {
              await deleteFile(fileName);
              if (user) {
                var body = {
                  user_id: user.user_id,
                  question: question,
                  answer: answer,
                  likes: 0,
                };
                chat = await imageModel.createImage(body);
                chat.language = req.body.language;
                return res.status(201).json({
                  data: chat,
                });
              } else {
                return res
                  .status(401)
                  .json({ errors: [{ msg: "Unauthorized" }] });
              }
            } else {
              return res
                .status(404)
                .json({ errors: [{ msg: "Error generating!!!!" }] });
            }
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
    let completion = await openai.createImage({
      prompt: question,
      n: 1,
      size: "1024x1024",
    });
    let answer = completion.data.data[0].url;
    if (answer) {
      let fileName = Date.now() + ".png";
      await download(answer, fileName, async function () {
        let stream = fs.createReadStream(fileName);
        let answer = await createBlobFromReadStream(fileName, stream);
        if (answer) {
          await deleteFile(fileName);
          if (user) {
            var body = {
              user_id: user.user_id,
              question: question,
              answer: answer,
              likes: 0,
            };
            chat = await imageModel.createImage(body);
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
      return res
        .status(404)
        .json({ errors: [{ msg: "Error generating!!!!" }] });
    }
  }
};

exports.updateImage = async (req, res) => {
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
      let result = await openai.createImageVariation(stream, 1, "1024x1024");
      let variation = result.data.data[0].url;
      if (variation) {
        if (user) {
          var body = {
            user_id: user.user_id,
            question: req.body.question,
            answer: variation,
            likes: 0,
          };
          chat = await imageModel.updateImage(req.params.id, body);
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
    let completion = await openai.createImage({
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
        chat = await imageModel.updateImage(req.params.id, body);
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

exports.deleteImage = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  let image = await imageModel.getImageById(req.params.id);
  if (image.user_id == user.user_id) {
    chats = await imageModel.deleteImageById(image.id);
    return res.status(200).json({
      msg: "Image has been succesfully deleted",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.recentImages = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  let user = await authorization.authorization(req, res);
  if (user) {
    let images = await imageModel.getRecentImages(user.user_id);
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
    let images = await imageModel.getAllImages(req.params.page);
    return res.status(200).json({
      data: images,
      prevPage: req.params.page > 1 ? true : false,
      nextPage: images.length > 39 ? true : false,
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

exports.like = async (req, res) => {
  if (req.params.id) {
    // let user = await authorization.authorization(req, res);
    let image = await imageModel.getImageById(req.params.id);
    if (image) {
      var body = {
        likes: image.likes + 1,
      };
      chat = await imageModel.updateImage(req.params.id, body);
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

exports.clearImages = async (req, res) => {
  let user = await authorization.authorization(req, res);
  if (user) {
    var body = {
      clear: 1,
    };
    await imageModel.updateImageByUserCategory(user.user_id, body);
    return res.status(201).json({
      msg: "Clear action has been execeuted!",
    });
  } else {
    return res.status(404).json({ errors: [{ msg: "Invalid request" }] });
  }
};

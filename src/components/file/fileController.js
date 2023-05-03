const fileUploadService = require("./fileService.js");

exports.uploadMultiFiles = async (req, res) => {
  try {
    if (!req.files) {
      return res
        .status(400)
        .send({ message: "Please select at least one file!" });
    }
    const data = await fileUploadService.uploadMultiFiles(req.files);
    return res.status(200).json({ success: true, data });
  } catch (err) {
    if (err.code === "LIMIT_UNEXPECTED_FILE") {
      return res.status(500).json({
        success: false,
        message: "Too many files to upload.",
      });
    }
    if (err.code == "LIMIT_FILE_SIZE") {
      return res.status(500).json({
        success: false,
        message: "File size cannot be larger than 5 MB!",
      });
    }
    res.status(500).json({
      success: false,
      message: `Could not upload the file:  ${err.message}`,
    });
  }
};

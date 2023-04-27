const { format } = require("util");
const { Storage } = require("@google-cloud/storage");
const config = require("../../config/index.js");

// **************************************************************

const { BUCKET_NAME, GOOGLE_CLOUD_KEY_FILE } = config.google_storage;

// Instantiate a storage client with credentials
const storage = new Storage({ keyFilename: GOOGLE_CLOUD_KEY_FILE });
const bucket = storage.bucket(BUCKET_NAME);

// **************************************************************

exports.uploadMultiFiles = async (files, folder_name) => {
  try {
    let result = files.map((file) => {
      let file_extention = file.originalname.substring(
        file.originalname.lastIndexOf("."),
        file.originalname.length
      );
      file.file_name = Date.now() + file_extention;
      const { originalname, file_name } = file;
      const blob = bucket.file(folder_name + file_name);
      const blobStream = blob.createWriteStream({
        metadata: {
          contentType: file.mimetype,
        },
        resumable: false,
      });
      return new Promise(async (resolve, reject) => {
        blobStream
          .on("error", (err) => {
            console.error(err);
            reject({ message: err.message });
          })
          .on("finish", async (data) => {
            try {
              let publicUrl = "";
              publicUrl = format(
                `https://storage.googleapis.com/${bucket.name}/${blob.name}`
              );
              await bucket.file(folder_name + file_name).makePublic();
              resolve({
                file_name: file_name,
                originalname: originalname,
                type: file?.mimetype,
                public_url: publicUrl,
                size: file?.size,
              });
            } catch (err) {
              console.error("error : ", err);
              reject({
                message: err.message,
              });
            }
          })
          .end(file.buffer);
      });
    });
    return Promise.all(result);
  } catch (err) {
    console.error("error : ", err);
    throw new Error(err.message);
  }
};
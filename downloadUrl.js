const fs = require("fs");
const request = require("request");
const path = require('path');

exports.download = async (uri, filename, callback) => {
  request.head(uri, async function (err, res, body) {
    request(uri).pipe(fs.createWriteStream(filename)).on("close", callback);
  });
};

exports.deleteFile = async (filename) => {
  let fileNameWithPath =path.resolve(__dirname, filename);
  console.log("fileNameWithPath: ", fileNameWithPath)
  fs.unlink(fileNameWithPath, function(err) {
      if(err && err.code == 'ENOENT') {
          console.info("File doesn't exist");
      } else if (err) {
          console.error("Error occurred while trying to remove file");
      } else {
          console.info('File has been removed');
      }
  });
};
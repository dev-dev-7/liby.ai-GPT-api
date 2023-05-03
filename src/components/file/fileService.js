require("dotenv").config();
const { BlobServiceClient, BlockBlobClient } = require("@azure/storage-blob");
const { Readable } = require("stream");

const blobServiceClient = BlobServiceClient.fromConnectionString(
  process.env.AZURE_CONNECTION_STRING
);
const containerClient = blobServiceClient.getContainerClient(
  process.env.AZURE_CONTAINER_NAME
);

exports.uploadMultiFiles = async (files) => {
  try {
    let result = files.map(async (file) => {
      let file_extention = file.originalname.substring(
        file.originalname.lastIndexOf("."),
        file.originalname.length
      );
      let blobName = Date.now() + file_extention;
      let blobService = new BlockBlobClient(
        process.env.AZURE_CONNECTION_STRING,
        process.env.AZURE_CONTAINER_NAME,
        blobName
      );
      let stream = Readable.from(file.buffer);
      let streamLength = file.buffer.length;
      return await blobService
        .uploadStream(stream, streamLength)
        .then(() => {
          return {
            file_name: blobName,
            originalname: file.originalname,
            type: file?.mimetype,
            public_url:
              "https://" +
              process.env.AZURE_STORAGE_ACCOUNT +
              ".blob.core.windows.net/" +
              process.env.AZURE_CONTAINER_NAME +
              "/" +
              blobName,
            size: file?.size,
          };
        })
        .catch((err) => {
          return err;
        });
    });
    return Promise.all(result);
  } catch (err) {
    console.error("error : ", err);
    throw new Error(err.message);
  }
};

const deleteDocumentFromAzure = async () => {
  const response = await containerClient.deleteBlob("FILENAME-TO-DELETE");
  if (response._response.status !== 202) {
    throw new Error(`Error deleting ${"FILENAME-TO-DELETE"}`);
  }
};

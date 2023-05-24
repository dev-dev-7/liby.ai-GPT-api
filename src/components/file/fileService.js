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
      // let file_extention = file.originalname.substring(
      //   file.originalname.lastIndexOf("."),
      //   file.originalname.length
      // );
      let blobName = Date.now() + ".png";
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

exports.createBlobFromReadStream = async (blobName, readableStream) => {
  // Create blob client from container client
  const blockBlobClient = await containerClient.getBlockBlobClient(blobName);
  // Size of every buffer allocated, also
  // the block size in the uploaded block blob.
  // Default value is 8MB
  const bufferSize = 4 * 1024 * 1024;
  // Max concurrency indicates the max number of
  // buffers that can be allocated, positive correlation
  // with max uploading concurrency. Default value is 5
  const maxConcurrency = 20;
  // use transform per chunk - only to see chunck
  // const transformedReadableStream = readableStream.pipe(myTransform);
  // Upload stream
  await blockBlobClient.uploadStream(
    readableStream,
    bufferSize,
    maxConcurrency
  );
  // do something with blob
  // const getTagsResponse = await blockBlobClient.getTags();
  // console.log(`tags for ${blobName} = ${JSON.stringify(getTagsResponse.tags)}`);
  return (
    "https://" +
    process.env.AZURE_STORAGE_ACCOUNT +
    ".blob.core.windows.net/" +
    process.env.AZURE_CONTAINER_NAME +
    "/" +
    blobName
  );
};

const deleteDocumentFromAzure = async () => {
  const response = await containerClient.deleteBlob("FILENAME-TO-DELETE");
  if (response._response.status !== 202) {
    throw new Error(`Error deleting ${"FILENAME-TO-DELETE"}`);
  }
};


async function getPagination(page = "", perPage = 1000) {
  if (!page) page = 1;
  let offset = perPage * (page - 1);
  let limit = perPage;
  return { offset: offset, limit: limit };
};

async function makeid(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
      counter += 1;
    }
    return result;
}

module.exports = { makeid, getPagination };
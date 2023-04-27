const bcrypt = require("bcryptjs");
// TODO: use async to speed up the hashing process
exports.make = (plain) => {
  return bcrypt.hashSync(plain, 10);
};

exports.check = (plain, hash) => {
  return bcrypt.compareSync(plain, hash);
};

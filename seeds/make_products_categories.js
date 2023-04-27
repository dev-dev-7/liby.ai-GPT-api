const faker = require("../node_modules/@faker-js/faker");

exports.seed = function (knex) {
  const table = "products_categories";
  // Deletes ALL existing entries
  return knex(table).then(function () {
    // Inserts seed entries
    let records = [];
    for (let i = 0; i < 10; i++) {
      faker.locale = "ar";
      let name_en = faker.name.findName().split(" ")[0];
      let name_ar = faker.name.findName().split(" ")[1];
      let record = {
        name_en,
        name_ar,
        icon: "fa fa-mobile",
        status: "1",
      };
      records.push(record);
    }

    return knex(table).insert(records);
  });
};

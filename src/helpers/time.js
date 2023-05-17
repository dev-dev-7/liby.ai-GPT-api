const timeNow = (second = "", operator = "") => {
  let date_ob = new Date();
  if (operator == "minus") {
    date_ob = subtractSeconds(date_ob, second);
  }
  if (operator == "add") {
    date_ob = addSeconds(date_ob, second);
  }
  let date = ("0" + date_ob.getDate()).slice(-2);
  let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
  let year = date_ob.getFullYear();
  let hours = date_ob.getHours();
  let minutes = date_ob.getMinutes();
  let seconds = date_ob.getSeconds();
  return (
    year +
    "-" +
    month +
    "-" +
    date +
    " " +
    hours +
    ":" +
    minutes +
    ":" +
    seconds
  );
};

function subtractSeconds(date, seconds) {
  date.setSeconds(date.getSeconds() - seconds);
  return date;
}

function addSeconds(date, seconds) {
  date.setSeconds(date.getSeconds() + seconds);
  return date;
}

const getDate = () => {
  var today = new Date();
  var year = today.getFullYear();
  var month = today.getMonth() + 1;
  var date = today.getDate();
  return year + "-" + month + "-" + date;
};

const convertToDate = (created_date) => {
  let date_ob = new Date(created_date);
  let year = date_ob.getFullYear();
  let month = date_ob.getMonth() + 1;
  let date = date_ob.getDate();
  return year + "-" + month + "-" + date;
};

module.exports = { timeNow, getDate, convertToDate };

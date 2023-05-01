const config = require("../config/index");
const apiKey = config.smsglobal.API_KEY;
const apiSecret = config.smsglobal.SECRETE_KEY;
var smsglobal = require("smsglobal")(apiKey, apiSecret);

const sendMessage = async (phone, otp_code) => {
  var payload = {
    origin: "ISHRO",
    destination: phone,
    message: "Your one time otp for Liby.ai is " + otp_code,
  };
  smsglobal.sms.send(payload, function (error, response) {
    // console.log(response);
    return true;
  });
};

module.exports = { sendMessage };

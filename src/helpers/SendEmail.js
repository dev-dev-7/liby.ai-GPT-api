const nodemailer = require("nodemailer");

const verifyEmailAddress = async (email, email_sub, token_url) => {
  // let testAccount = await nodemailer.createTestAccount();
  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    service: "gmail",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: "leafmillion@gmail.com", // generated ethereal user
      pass: "dcatrduqwneufgox", // generated ethereal password
    },
  });
  let info = await transporter.sendMail({
    from: '"Olaenergy Vendor Form" <leafmillion@gmail.com>',
    to: email, // list of receivers
    subject: email_sub, // Subject line
    html: token_url, // html body
  });
  return info.messageId;
};

module.exports = { verifyEmailAddress };

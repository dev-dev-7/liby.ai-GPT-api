exports.getPostFix = async (question, category_id, language = "english") => {
  switch (category_id) {
    case "1":
      return question;
    case "2":
      return question + " anwer me in home work format";
    case "3":
      return '"' + question + '"' + " translate to me in " + language;
    case "4":
      return '"' + question + '"' + " answer me in research model";
    case "5":
      return '"' + question + '"' + " expecting answer by progaming language";
    case "6":
      return '"' + question + '"' + " write to me email based on this matter";
    default:
      return "";
  }
};

exports.getPostFix = async (
  question,
  category_id,
  translate = "English",
  language = "ar"
) => {
  language = language == "ar" ? "Arabic" : "English";
  switch (category_id) {
    case "1":
      return (
        question +
        "Answer me the following text in " +
        language +
        ' language: "' +
        question +
        '"'
      );
    case "2":
      return question + " anwer me in home work format";
    case "3":
      return (
        "Translate the following English text to " +
        translate +
        ': "' +
        question +
        '"'
      );
    case "4":
      return '"' + question + '"' + " answer me in research model";
    case "5":
      return (
        "Answer me in sample code syntax with short description" +
        ': "' +
        question +
        '"'
      );
    case "6":
      return '"' + question + '"' + " write to me email based on this matter";
    default:
      return "";
  }
};

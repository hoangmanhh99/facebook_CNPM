// import 'package:validators/validators.dart' as validate;

class ParseDate {
  // Check email
  static String parse(String created) {
    print(created);
    // if(DateTime.)
    var b, a;
    try {
      b = DateTime.parse(created);
      a = DateTime.now().difference(b);
    } catch (e) {
      return created;
    }

    // if (a.inHours.)
    var createdTemp;
    if (a.inMinutes < 1) {
      createdTemp = "Just now";
    } else if (a.inHours < 1) {
      createdTemp = a.inMinutes.toString() + " minutes";
    } else if (a.inHours < 24) {
      createdTemp = a.inHours.toString() + " hours";
    } else if (a.inDays < 31) {
      createdTemp = a.inDays.toString() + " days";
    } else {
      createdTemp = b.day.toString() +
          "  " +
          b.month.toString() +
          ", " +
          b.year.toString();
    }
    return createdTemp;
  }

  static String parseMessage(String created) {
    var b = DateTime.parse(created);
    var a = DateTime.now().difference(b);
    // if (a.inHours.)
    var minute =
    b.minute > 10 ? b.minute.toString() : "0" + b.minute.toString();
    var hour = b.hour > 10 ? b.hour.toString() : "0" + b.hour.toString();
    var createdTemp;
    var weekday = b.weekday == 8 ? "Sunday" : " " + b.weekday.toString();
    if (a.inHours < 24) {
      createdTemp = hour + ":" + minute;
    } else if (a.inDays > 1) {
      createdTemp = weekday + " " + hour + ":" + minute;
    } else {
      createdTemp = hour +
          ":" +
          minute +
          " " +
          b.day.toString() +
          "  " +
          b.month.toString() +
          ", " +
          b.year.toString();
    }
    return createdTemp;
  }
}

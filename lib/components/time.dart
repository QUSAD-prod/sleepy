class MyTime {

  MyTime();

  DateTime getDefault() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 7, 30);
  }

  DateTime addTime(int hour, int minute) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String getTimeFromDateTime(DateTime time) {
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    if (hour.length < 2) {
      hour = "0" + hour;
    }
    if (minute.length < 2) {
      minute = "0" + minute;
    }
    return hour + ":" + minute;
  }
}
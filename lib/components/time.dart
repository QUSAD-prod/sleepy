import 'package:hive/hive.dart';

part 'time.g.dart';

@HiveType(typeId: 32)
class SettingsTime {
  @HiveField(0)
  int hour;
  @HiveField(1)
  int minute;

  SettingsTime({
    required this.hour,
    required this.minute,
  });

  @override
  String toString() {
    String hour = this.hour.toString();
    String minute = this.minute.toString();

    if (hour.length == 1) {
      hour = "0" + hour;
    }
    if (minute.length == 1) {
      minute = "0" + minute;
    }

    return hour + ":" + minute;
  }
}
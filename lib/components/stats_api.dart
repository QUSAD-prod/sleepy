import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sleepy/components/time.dart';

class StatsApi {
  void alarmReset(Box box) {
    DateTime now = DateTime.now();
    if (now.millisecondsSinceEpoch >=
        (box.get("alarm_stop") as DateTime).millisecondsSinceEpoch) {
      String key = now.day.toString() +
          "." +
          now.month.toString() +
          "." +
          now.year.toString();
      DateTime time =
          box.get("alarm_time", defaultValue: MyTime().getDefault());
      double value =
          double.parse((time.hour + (time.minute / 60)).toStringAsFixed(2));
      if (box.get("statistics") != null) {
        Map map = box.get("statistics");
        if (map.containsKey(key)) {
          map.update(key, (oldValue) => oldValue + value);
        } else {
          map[key] = value;
        }
        box.put(
          "statistics",
          map,
        );
      } else {
        Map<String, double> map = {};
        map[key] = value;
        box.put(
          "statistics",
          map,
        );
      }
    }

    box.delete("alarm_start");
    box.delete("alarm_stop");
  }

  void alarmCheck(Box box) {
    DateTime now = DateTime.now();
    if (now.millisecondsSinceEpoch >=
        (box.get("alarm_stop") as DateTime).millisecondsSinceEpoch) {
      String key = now.day.toString() +
          "." +
          now.month.toString() +
          "." +
          now.year.toString();
      DateTime time =
          box.get("alarm_time", defaultValue: MyTime().getDefault());
      double value =
          double.parse((time.hour + (time.minute / 60)).toStringAsFixed(2));
      print(value);
      if (box.get("statistics") != null) {
        Map map = box.get("statistics");
        if (map.containsKey(key)) {
          map.update(key, (oldValue) => (oldValue as double) + value);
        } else {
          map[key] = value;
        }
        box.put(
          "statistics",
          map,
        );
      } else {
        Map<String, double> map = {};
        map[key] = value;
        box.put(
          "statistics",
          map,
        );
      }
      box.put("is_sleep", !box.get("is_sleep", defaultValue: false));
      box.delete("alarm_start");
      box.delete("alarm_stop");
    }
  }

  List<double> getHours(List<double> hours, Box box) {
    List<String> keys = getWeekHoursKeys();
    Map map;
    if (box.get("statistics") != null) {
      map = box.get("statistics", defaultValue: Map<String, double>());
    } else {
      map = {};
    }
    for (int i = 0; i < 7; i++) {
      var temp = map[keys[i]];
      if (temp != null) {
        hours.add(temp);
      } else {
        hours.add(0.0);
      }
    }
    return hours;
  }

  List<String> getWeekHoursKeys() {
    DateTime firstWeekDay =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    List<String> weekHoursKeys = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = firstWeekDay.add(Duration(days: i));
      weekHoursKeys.add(date.day.toString() +
          "." +
          date.month.toString() +
          "." +
          date.year.toString());
    }
    return weekHoursKeys;
  }

  double getTimeSleep(Map map) {
    double time = 0;
    map.forEach((key, value) {
      time += value;
    });
    time /= map.length;
    return double.parse(time.toStringAsFixed(2));
  }
}

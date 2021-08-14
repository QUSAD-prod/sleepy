import 'dart:async';
//import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleepy/components/clock.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/clockWidget.dart';
import 'package:sleepy/components/clock_page_button.dart';
import 'package:sleepy/components/stats_api.dart';
import 'package:sleepy/components/time.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

void setAlarm() {
  print("alarm");
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    tz.initializeTimeZones();
    return ValueListenableBuilder(
        valueListenable: Hive.box("data").listenable(),
        builder: (context, Box box, widget) {
          if (box.get("is_sleep", defaultValue: false)) {
            StatsApi().alarmCheck(box);
          }
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF4D52DD),
              image: DecorationImage(
                image: AssetImage('res/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Text(
                    "Время сна",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  margin: EdgeInsets.only(top: height * 0.06),
                ),
                Container(
                  child: Text(
                    "Установите время отхода ко сну и пробуждению",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  width: width * 0.8,
                  margin: EdgeInsets.only(top: height * 0.005),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.035),
                  width: width * 0.835,
                  height: width * 0.835,
                  child: Clock(),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.015),
                  width: width * 0.84,
                  child: ClockWidget(
                    isActive: box.get("is_sleep", defaultValue: false),
                    width: width,
                    box: box,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  width: width * 0.84,
                  child: MyButton(
                    isActive: box.get("is_sleep", defaultValue: false),
                    onClick: buttonClick(box),
                    box: box,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Function buttonClick(Box box) {
    DateTime temp = box.get("alarm_time", defaultValue: MyTime().getDefault());
    return () => {
          box.put("is_sleep", !box.get("is_sleep", defaultValue: false)),
          if (box.get("is_sleep", defaultValue: false) == true)
            {
              box.put("alarm_start", DateTime.now()),
              box.put(
                "alarm_stop",
                DateTime.now().add(
                  Duration(
                    hours: temp.hour,
                    minutes: temp.minute,
                  ),
                ),
              ),
              addNotification(box),
              //addAlarm(box),
            }
          else
            {
              StatsApi().alarmReset(box),
              flutterLocalNotificationsPlugin.cancelAll(),
            }
        };
  }

  // Future<void> addAlarm(Box box) async {
  //   await AndroidAlarmManager.oneShot(
  //     Duration(seconds: 10),
  //     10,
  //     setAlarm,
  //     alarmClock: true,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }

  Future<void> addNotification(Box box) async {
    DateTime time = box.get(
      "alarm_time",
      defaultValue: MyTime().getDefault(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      box.get("alarm_channel", defaultValue: 0),
      "Sleepy - Новый подход ко сну",
      "Пора вставать",
      tz.TZDateTime.now(tz.local).add(
        Duration(hours: time.hour, minutes: time.minute),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          ('alarm' + box.get("alarm_channel", defaultValue: 0).toString()),
          'sleepy',
          'sleepy alarm',
          icon: 'ic_stat_bell',
          largeIcon: DrawableResourceAndroidBitmap('ic_notification_big'),
          playSound: true,
          sound: RawResourceAndroidNotificationSound(getMelody(box)),
          enableVibration: box.get('alarm_vibration', defaultValue: true),
          priority: Priority.high,
          importance: Importance.max,
          showWhen: false,
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    box.put("alarm_channel", box.get("alarm_channel", defaultValue: 0) + 1);
  }

  String? getMelody(Box box) {
    int melody = box.get("alarm_sound", defaultValue: 0);
    switch (melody) {
      case 0:
        return "birds";
      case 1:
        return "instrumental";
      case 2:
        return "moon_discovery";
      case 3:
        return "rington";
      case 4:
        return "garmony";
      case 5:
        return "vertu";
      case 6:
        return "trap";
      default:
        return "birds";
    }
  }
}

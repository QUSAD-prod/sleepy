import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepy/components/clock.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/clockWidget.dart';
import 'package:sleepy/components/clock_page_button.dart';
import 'package:sleepy/components/time.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
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
                  child: ClockWidget(isActive: box.get("is_sleep", defaultValue: false), width: width, box: box),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: height * 0.03),
                    width: width * 0.84,
                    child: MyButton(
                      isActive: box.get("is_sleep", defaultValue: false),
                      onClick: buttonClick(box),
                    )),
              ],
            ),
          );
        });
  }

  Function buttonClick(Box box) {
    return () => {
          box.put("is_sleep", !box.get("is_sleep", defaultValue: false)),
          if (box.get("is_sleep", defaultValue: false) == true)
            {
              addNotification(box),
            }
          else
            {
              flutterLocalNotificationsPlugin.cancel(0),
            }
        };
  }

  Future<void> addNotification(Box box) async {
    DateTime time = box.get("alarm_time", defaultValue: MyTime().getDefault());
    var scheduledNotificationDateTime = tz.TZDateTime.now(tz.local).add(
      Duration(hours: time.hour, minutes: time.minute),
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm',
      'sleepy',
      'sleepy alarm',
      icon: 'sleepy_icon_notification',
      largeIcon: DrawableResourceAndroidBitmap('sleepy_icon_notification'),
      playSound: true,
      enableVibration: box.get('alarm_vibration', defaultValue: true),
      priority: Priority.high,
      importance: Importance.max,
      showWhen: false,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Sleepy - Новый подход ко сну",
      "Пора вставать",
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

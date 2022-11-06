import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleepy/components/clock.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/clockWidget.dart';
import 'package:sleepy/components/clock_page_button.dart';
import 'package:sleepy/components/stats_api.dart';
import 'package:sleepy/components/time.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';

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

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(() {}),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                child: Text(
                  "Время сна",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
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
                width: width * 0.9,
              ),
              Expanded(
                child: Container(),
                flex: 4,
              ),
              Container(
                width: width * 0.835,
                height: width * 0.835,
                child: Clock(),
              ),
              Expanded(
                child: Container(),
                flex: 4,
              ),
              Container(
                width: width * 0.9,
                child: ClockWidget(
                  isActive: box.get("is_sleep", defaultValue: false),
                  width: width,
                  box: box,
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                width: width * 0.9,
                child: MyButton(
                  isActive: box.get("is_sleep", defaultValue: false),
                  onClick: () async => await buttonClick(box),
                  box: box,
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> buttonClick(Box box) async {
    PermissionStatus statusNotification = await Permission.notification.status;
    PermissionStatus statusNotificationPolicy =
        await Permission.accessNotificationPolicy.status;
    PermissionStatus statusAlarm = await Permission.scheduleExactAlarm.status;
    int sdk = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    if (sdk < 32) {
      statusAlarm = PermissionStatus.granted;
    }

    if (statusNotification.isGranted &&
        statusNotificationPolicy.isGranted &&
        statusAlarm.isGranted) {
      sleep(box);
    } else {
      if (!statusNotification.isGranted) {
        if (!await Permission.notification.request().isGranted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Разрешите приложению присылать уведомления, чтобы поставить будильник',
              ),
            ),
          );
        }
      }
      if (!statusNotificationPolicy.isGranted) {
        if (!await Permission.accessNotificationPolicy.request().isGranted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Разрешите приложению управлять режимом "Не беспокоить", чтобы поставить будильник',
              ),
            ),
          );
        }
      }
      if (!statusAlarm.isGranted) {
        if (!await Permission.scheduleExactAlarm.request().isGranted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Разрешите приложению управлять настройками будильника, чтобы поставить будильник',
              ),
            ),
          );
        }
      }
    }
  }

  void sleep(Box box) async {
    DateTime temp = box.get("alarm_time", defaultValue: MyTime().getDefault());
    box.put(
      "is_sleep",
      !box.get("is_sleep", defaultValue: false),
    );
    if (box.get("is_sleep", defaultValue: false)) {
      box.put("alarm_start", DateTime.now());
      box.put(
        "alarm_stop",
        DateTime.now().add(
          Duration(
            hours: temp.hour,
            minutes: temp.minute,
          ),
        ),
      );
      await flutterLocalNotificationsPlugin.zonedSchedule(
        box.get("alarm_channel", defaultValue: 0),
        "Sleepy - Новый подход ко сну",
        "Пора вставать",
        tz.TZDateTime.now(tz.local).add(
          Duration(hours: temp.hour, minutes: temp.minute),
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
            ('alarm' + box.get("alarm_channel", defaultValue: 0).toString()),
            'sleepy_alarm',
            icon: 'ic_stat_bell',
            largeIcon: DrawableResourceAndroidBitmap('ic_notification_big'),
            playSound: true,
            sound: RawResourceAndroidNotificationSound(getMelody(box)),
            enableVibration: box.get('alarm_vibration', defaultValue: true),
            visibility: NotificationVisibility.public,
            priority: Priority.max,
            importance: Importance.max,
            category: AndroidNotificationCategory.alarm,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            channelAction: AndroidNotificationChannelAction.createIfNotExists,
            showWhen: false,
            enableLights: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      box.put("alarm_channel", box.get("alarm_channel", defaultValue: 0) + 1);
    } else {
      StatsApi().alarmReset(box);
      await flutterLocalNotificationsPlugin.cancelAll();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleepy/components/clock.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/time.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                  child: getWidget(width, box),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  child: bottomButton(width, box),
                ),
              ],
            ),
          );
        });
  }

  SvgPicture getIcon(bool isActive, double width) {
    if (isActive) {
      return SvgPicture.asset(
        "res/bell_icon.svg",
        color: Colors.white,
        width: width * 0.135 * 0.42,
        height: width * 0.135 * 0.47,
      );
    } else {
      return SvgPicture.asset(
        "res/bed_icon.svg",
        color: Colors.white,
      );
    }
  }

  String getWidgetText1(Box box) {
    SettingsTime time =
        box.get("alarm_time", defaultValue: SettingsTime(hour: 7, minute: 30));
    String hour;
    switch (time.hour) {
      case 1:
      case 21:
        hour = " час";
        break;
      case 2:
      case 3:
      case 4:
      case 22:
      case 23:
      case 24:
        hour = " часа";
        break;
      default:
        hour = " часов";
        break;
    }
    return box.get("is_sleep", defaultValue: false)
        ? "Разбужу через " + time.toString() + hour
        : "Вы хотите спать";
  }

  String getWidgetText2(Box box) {
    SettingsTime time =
        box.get("alarm_time", defaultValue: SettingsTime(hour: 7, minute: 30));
    String hour;
    String day;
    switch (time.hour) {
      case 1:
      case 21:
        hour = " час";
        break;
      case 2:
      case 3:
      case 4:
      case 22:
      case 23:
      case 24:
        hour = " часа";
        break;
      default:
        hour = " часов";
        break;
    }
    if (time.hour >= 4 && time.hour <= 11) {
      day = "Утром в ";
    } else if (time.hour >= 12 && time.hour <= 16) {
      day = "Днём в ";
    } else if (time.hour >= 17 && time.hour <= 23) {
      day = "Вечером в ";
    } else {
      day = "Ночью в ";
    }
    return box.get("is_sleep", defaultValue: false)
        ? day + time.toString()
        : time.toString() + hour;
  }

  Widget getWidget(double width, Box box) {
    return Container(
      width: width * 0.84,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        child: Row(
          children: [
            Container(
              width: width * 0.135,
              height: width * 0.135,
              decoration: BoxDecoration(
                color: box.get("is_sleep", defaultValue: false)
                    ? Color(0xFF65C7FF)
                    : Color(0xFFBE97E5),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: getIcon(
                  box.get(
                    "is_sleep",
                    defaultValue: false,
                  ),
                  width,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.84 * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getWidgetText1(box),
                    style: TextStyle(
                      color: Color(0xFF9B99A9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    getWidgetText2(box),
                    style: TextStyle(
                      color: Color(0xFF160647),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(double width, Box box) {
    return Container(
      width: width * 0.84,
      decoration: BoxDecoration(
        color: box.get("is_sleep", defaultValue: false)
            ? Color(0xFFFFFFFF).withOpacity(0.0)
            : Color(0xFF5868F0),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Color(0xFF5868F0),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () => box.put("is_sleep", !box.get("is_sleep", defaultValue: false)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.5),
            child: Center(
              child: Text(
                box.get("is_sleep", defaultValue: false)
                    ? "Перестать спать"
                    : "Пойти спать",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

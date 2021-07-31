import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/time.dart';
class ClockWidget extends StatelessWidget {
  final bool isActive;
  final double width;
  final Box box;

  ClockWidget({
    required this.isActive,
    required this.width,
    required this.box,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: getColor(),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: getImage(),
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.84 * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isActive ? getWidgetText1(box, true) : getWidgetText1(box, false),
                    style: TextStyle(
                      color: Color(0xFF9B99A9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isActive ? getWidgetText2(box, true) : getWidgetText2(box, false),
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

  String getWidgetText1(Box box, bool flag) {
    DateTime timeStop = box.get("alarm_stop");
    DateTime now = DateTime.now();
    DateTime time = timeStop.add(Duration(hours: -now.hour, minutes: -now.minute,));
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
    return flag
        ? "Разбужу через " + MyTime().getTimeFromDateTime(time) + hour
        : "Вы хотите спать";
  }

  String getWidgetText2(Box box, bool flag) {
    DateTime time = box.get("alarm_time", defaultValue: MyTime().getDefault());
    DateTime time2 =
        DateTime.now().add(Duration(hours: time.hour, minutes: time.minute));
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
    if (time2.hour >= 4 && time2.hour <= 11) {
      day = "Утром в ";
    } else if (time2.hour >= 12 && time2.hour <= 16) {
      day = "Днём в ";
    } else if (time2.hour >= 17 && time2.hour <= 23) {
      day = "Вечером в ";
    } else {
      day = "Ночью в ";
    }
    return flag
        ? day + MyTime().getTimeFromDateTime(time2)
        : MyTime().getTimeFromDateTime(time) + hour;
  }

  Color getColor() {
    if (isActive) {
      return Color(0xFF65C7FF);
    } else {
      return Color(0xFFBE97E5);
    }
  }

  Widget getImage() {
    if (isActive) {
      return Center(
        child: SvgPicture.asset(
          "res/bell_icon.svg",
          color: Colors.white,
          width: width * 0.135 * 0.42,
          height: width * 0.135 * 0.47,
        ),
      );
    } else {
      return Center(
        child: SvgPicture.asset(
          "res/bed_icon.svg",
          color: Colors.white,
        ),
      );
    }
  }

}

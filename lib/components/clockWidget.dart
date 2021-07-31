import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sleepy/components/time.dart';
import 'package:supercharged/supercharged.dart';

enum _ClockWidgetProps {
  color,
  opacity,
}

class ClockWidget extends StatelessWidget {
  final bool isActive;
  final double width;
  final Box box;

  ClockWidget({
    required this.isActive,
    required this.width,
    required this.box,
  });

  final MultiTween<_ClockWidgetProps> _clockWidgetTween =
      MultiTween<_ClockWidgetProps>()
        ..add(
          _ClockWidgetProps.color,
          Color(0xFFBE97E5).tweenTo(Color(0xFF65C7FF)),
          10.milliseconds,
        )
        ..add(
          _ClockWidgetProps.opacity,
          1.0.tweenTo(0.0),
          10.milliseconds,
        );

  @override
  Widget build(BuildContext context) {
    return CustomAnimation<MultiTweenValues<_ClockWidgetProps>>(
      control: isActive
          ? CustomAnimationControl.play
          : CustomAnimationControl.playReverse,
      tween: _clockWidgetTween,
      curve: Curves.easeInOut,
      builder: _clockWidgetBuilder,
    );
  }

  Widget _clockWidgetBuilder(
    context,
    child,
    MultiTweenValues<_ClockWidgetProps> value,
  ) {
    box.put("clock_widget_old", isActive);
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
                color: getColor(box, isActive, value),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: getImage(box, isActive, value),
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.84 * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Text(
                        getWidgetText1(box, true),
                        style: TextStyle(
                          color: Color(0xFF9B99A9).withOpacity(
                              1 - value.get(_ClockWidgetProps.opacity)),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        getWidgetText1(box, false),
                        style: TextStyle(
                          color: Color(0xFF9B99A9).withOpacity(
                              value.get(_ClockWidgetProps.opacity)),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Text(
                        getWidgetText2(box, true),
                        style: TextStyle(
                          color: Color(0xFF160647).withOpacity(
                              1 - value.get(_ClockWidgetProps.opacity)),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        getWidgetText2(box, false),
                        style: TextStyle(
                          color: Color(0xFF160647).withOpacity(
                              value.get(_ClockWidgetProps.opacity)),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
    DateTime time = box.get("alarm_time", defaultValue: MyTime().getDefault());
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

  Color getColor(
    Box box,
    bool isActive,
    MultiTweenValues<_ClockWidgetProps> value,
  ) {
    if (box.get("clock_widget_old") != null &&
        box.get("clock_widget_old") != isActive) {
      return value.get(_ClockWidgetProps.color);
    } else {
      if (isActive) {
        return Color(0xFFBE97E5);
      } else {
        return Color(0xFF65C7FF);
      }
    }
  }

  Widget getImage(
    Box box,
    bool isActive,
    MultiTweenValues<_ClockWidgetProps> value,
  ) {
    if (box.get("clock_widget_old") != null &&
        box.get("clock_widget_old") != isActive) {
      return Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              "res/bell_icon.svg",
              color: Colors.white
                  .withOpacity(1.0 - value.get(_ClockWidgetProps.opacity)),
              width: width * 0.135 * 0.42,
              height: width * 0.135 * 0.47,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              "res/bed_icon.svg",
              color: Colors.white
                  .withOpacity(value.get(_ClockWidgetProps.opacity)),
            ),
          ),
        ],
      );
    } else {
      if (!isActive) {
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
}

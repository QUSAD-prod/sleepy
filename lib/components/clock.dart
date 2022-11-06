import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/indicators.dart';
import 'package:sleepy/components/time.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
        valueListenable: Hive.box("data").listenable(),
        builder: (context, Box box, widget) {
          DateTime bellTime = box.get(
            "alarm_stop",
            defaultValue: DateTime.now().add(
              Duration(
                hours: box
                    .get("alarm_time", defaultValue: MyTime().getDefault())
                    .hour,
                minutes: box
                    .get("alarm_time", defaultValue: MyTime().getDefault())
                    .minute,
              ),
            ),
          );
          return Container(
            child: CustomPaint(
              painter: ClockPaint(),
              child: Stack(
                children: [
                  decoration(width, height),
                  Indicators(
                    width: width,
                    height: height,
                    bell: true,
                    bed: false,
                    bellAngle: (bellTime.hour + (bellTime.minute / 60)) / 24,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget decoration(double width, height) {
    TextStyle textA = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    TextStyle textB = TextStyle(
      color: Colors.black.withOpacity(0.5),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Container(
      margin: EdgeInsets.all(width * 0.18),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.108),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "22",
                        style: textB,
                      ),
                      padding: EdgeInsets.only(top: width * 0.03),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: Text(
                        "0 ",
                        style: textA,
                      ),
                      padding: EdgeInsets.only(bottom: width * 0.03),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: Text(
                        "2 ",
                        style: textB,
                      ),
                      padding: EdgeInsets.only(top: width * 0.03),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.032),
                padding: EdgeInsets.only(bottom: width * 0.025),
                child: Row(
                  children: [
                    Text(
                      "20",
                      style: textB,
                    ),
                    Expanded(child: Container()),
                    Text(
                      "4 ",
                      style: textB,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Text(
                    "18",
                    style: textA,
                  ),
                  Expanded(child: Container()),
                  Text(
                    "6",
                    style: textA,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.032),
                padding: EdgeInsets.only(top: width * 0.025),
                child: Row(
                  children: [
                    Text(
                      "16",
                      style: textB,
                    ),
                    Expanded(child: Container()),
                    Text(
                      "8 ",
                      style: textB,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.108),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "14",
                        style: textB,
                      ),
                      padding: EdgeInsets.only(bottom: width * 0.03),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: Text(
                        "12",
                        style: textA,
                      ),
                      padding: EdgeInsets.only(top: width * 0.03),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: Text(
                        "10",
                        style: textB,
                      ),
                      padding: EdgeInsets.only(bottom: width * 0.03),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: width * 0.065),
            child: Column(
              children: [
                SvgPicture.asset(
                  "res/moon_icon.svg",
                  color: Color(0xFF7D81F2),
                ),
                Expanded(child: Container()),
                SvgPicture.asset(
                  "res/sun_icon.svg",
                  color: Color(0xFFFFBC11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClockPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    drawBackground(canvas, center, radius, size);
    drawSmallLines(canvas, size, center, radius);
    drawBigLines(canvas, size, center, radius);
  }

  void drawBackground(Canvas canvas, Offset center, var radius, Size size) {
    Paint outsideCircle = Paint()..color = Color(0xFF5868F0);

    Paint insideCircle = Paint()..color = Colors.white;

    canvas.drawCircle(center, radius, outsideCircle);
    canvas.drawCircle(center, radius - size.height * 0.12, insideCircle);
  }

  void drawSmallLines(Canvas canvas, Size size, Offset center, var radius) {
    double l = size.height;
    var centerX = l / 2;
    double h = l * 0.016;
    double w = l * 0.005;
    var outRadius = radius - (l * 0.02 + l * 0.14);
    var inRadius = outRadius - h;

    Paint line = Paint()
      ..color = Color(0xFFA4A0BD)
      ..strokeWidth = w;

    for (double i = 0; i < 360; i += (360 / 108)) {
      var x1 = centerX + outRadius * cos(i * pi / 180);
      var y1 = centerX + outRadius * sin(i * pi / 180);
      var x2 = centerX + inRadius * cos(i * pi / 180);
      var y2 = centerX + inRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
    }
  }

  void drawBigLines(Canvas canvas, Size size, Offset center, var radius) {
    double l = size.height;
    var centerX = l / 2;
    double h = l * 0.0381;
    double w = l * 0.01;
    var outRadius = radius - (l * 0.02 + l * 0.14);
    var inRadius = outRadius - h;

    Paint line = Paint()
      ..color = Color(0xFFA4A0BD)
      ..strokeWidth = w;

    for (int i = 0; i < 360; i += 30) {
      var x1 = centerX + outRadius * cos(i * pi / 180);
      var y1 = centerX + outRadius * sin(i * pi / 180);
      var x2 = centerX + inRadius * cos(i * pi / 180);
      var y2 = centerX + inRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

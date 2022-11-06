<<<<<<< HEAD
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _IndicatorsProps {
  bedPosition,
  bellPosition,
}

class Indicators extends StatelessWidget {
  final double width, height;
  final bool bed, bell;
  final double bellAngle;
  final double? bedAngle;

  Indicators({
    required this.width,
    required this.height,
    required this.bell,
    required this.bellAngle,
    this.bed = false,
    this.bedAngle,
  });

  @override
  Widget build(BuildContext context) {
    var bellTween = MultiTween<_IndicatorsProps>()
      ..add(
        _IndicatorsProps.bellPosition,
        0.0.tweenTo(2 * pi * bellAngle),
        0.5.seconds,
      );

    var bedTween = MultiTween<_IndicatorsProps>()
      ..add(
        _IndicatorsProps.bedPosition,
        0.0.tweenTo(bedAngle ?? 0.0),
        0.5.seconds,
      );

    return Container(
      width: width * 0.835,
      height: width * 0.835,
      child: showIndicators(bedTween, bellTween),
    );
  }

  Widget showIndicators(var bedTween, var bellTween) {
    if (this.bed) {
      return CustomPaint();
    } else {
      return CustomAnimation(
        tween: bellTween,
        duration: bellTween.duration,
        builder: (BuildContext context, Widget? child,
            MultiTweenValues<_IndicatorsProps> value) {
          return new Transform.rotate(
            angle: value.get(_IndicatorsProps.bellPosition),
            child: Stack(
              children: [
                Center(
                  child: CustomPaint(
                    painter: BellPainter(
                      width: width,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: height * 0.012),
                  child: new Transform.rotate(
                    angle: -value.get(_IndicatorsProps.bellPosition),
                    child: SvgPicture.asset(
                      "res/bell_clock.svg",
                      color: Color(0xFF42B4F4),
                      width: 0.048 * width,
                      height: 0.05 * width,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}

class BellPainter extends CustomPainter {
  double width;

  BellPainter({
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double dRad = width * 0.368;

    Paint whiteCircle = Paint()..color = Colors.white;
    Paint blueCircle = Paint()..color = Color(0xFF65C7FF);

    canvas.drawCircle(Offset(centerX, centerY - dRad),
        (width * 0.411 - width * 0.325) / 2, blueCircle);
    double a = 1;
    for (double i = -90; i > -250; i -= 0.1) {
      var x1 = centerX + width * 0.411 * cos(i * pi / 180);
      var y1 = centerX + width * 0.411 * sin(i * pi / 180);
      var x2 = centerX + width * 0.325 * cos(i * pi / 180);
      var y2 = centerX + width * 0.325 * sin(i * pi / 180);
      if (a >= 0) {
        Paint line = Paint()
          ..color = Color(0xFF65C7FF).withOpacity(a)
          ..strokeWidth = 0.6;
        a -= 0.0007;
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
      } else {
        break;
      }
    }
    a = 0.8;
    for (double i = -97; i > -250; i -= 2.5) {
      var x1 = centerX + (width * 0.4 - 2) * cos(i * pi / 180);
      var y1 = centerX + (width * 0.4 - 2) * sin(i * pi / 180);
      var x2 = centerX + (width * 0.335 + 2) * cos(i * pi / 180);
      var y2 = centerX + (width * 0.335 + 2) * sin(i * pi / 180);
      if (a >= 0) {
        Paint line = Paint()
          ..color = Color(0xFFFFFFFF).withOpacity(a)
          ..strokeWidth = 2.5;
        a -= 0.02;
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
      } else {
        break;
      }
    }
    canvas.drawCircle(Offset(centerX, centerY - dRad),
        (width * 0.4 - width * 0.335) / 2, whiteCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
=======
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _IndicatorsProps {
  bedPosition,
  bellPosition,
}

class Indicators extends StatelessWidget {
  final double width, height;
  final bool bed, bell;
  final double bellAngle;
  final double? bedAngle;

  Indicators({
    required this.width,
    required this.height,
    required this.bell,
    required this.bellAngle,
    this.bed = false,
    this.bedAngle,
  });

  @override
  Widget build(BuildContext context) {
    var bellTween = MultiTween<_IndicatorsProps>()
      ..add(
        _IndicatorsProps.bellPosition,
        0.0.tweenTo(2 * pi * bellAngle),
        0.5.seconds,
      );

    var bedTween = MultiTween<_IndicatorsProps>()
      ..add(
        _IndicatorsProps.bedPosition,
        0.0.tweenTo(bedAngle ?? 0.0),
        0.5.seconds,
      );

    return Container(
      width: width * 0.835,
      height: width * 0.835,
      child: showIndicators(bedTween, bellTween),
    );
  }

  Widget showIndicators(var bedTween, var bellTween) {
    if (this.bed) {
      return CustomPaint();
    } else {
      return CustomAnimation(
        tween: bellTween,
        duration: bellTween.duration,
        builder: (BuildContext context, Widget? child,
            MultiTweenValues<_IndicatorsProps> value) {
          return new Transform.rotate(
            angle: value.get(_IndicatorsProps.bellPosition),
            child: Stack(
              children: [
                Center(
                  child: CustomPaint(
                    painter: BellPainter(
                      width: width,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: height * 0.012),
                  child: new Transform.rotate(
                    angle: -value.get(_IndicatorsProps.bellPosition),
                    child: SvgPicture.asset(
                      "res/bell_clock.svg",
                      color: Color(0xFF42B4F4),
                      width: 0.048 * width,
                      height: 0.05 * width,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}

class BellPainter extends CustomPainter {
  double width;

  BellPainter({
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double dRad = width * 0.368;

    Paint whiteCircle = Paint()..color = Colors.white;
    Paint blueCircle = Paint()..color = Color(0xFF65C7FF);

    canvas.drawCircle(Offset(centerX, centerY - dRad),
        (width * 0.411 - width * 0.325) / 2, blueCircle);
    double a = 1;
    for (double i = -90; i > -250; i -= 0.1) {
      var x1 = centerX + width * 0.411 * cos(i * pi / 180);
      var y1 = centerX + width * 0.411 * sin(i * pi / 180);
      var x2 = centerX + width * 0.325 * cos(i * pi / 180);
      var y2 = centerX + width * 0.325 * sin(i * pi / 180);
      if (a >= 0) {
        Paint line = Paint()
          ..color = Color(0xFF65C7FF).withOpacity(a)
          ..strokeWidth = 0.6;
        a -= 0.0007;
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
      } else {
        break;
      }
    }
    a = 0.8;
    for (double i = -97; i > -250; i -= 2.5) {
      var x1 = centerX + (width * 0.4 - 2) * cos(i * pi / 180);
      var y1 = centerX + (width * 0.4 - 2) * sin(i * pi / 180);
      var x2 = centerX + (width * 0.335 + 2) * cos(i * pi / 180);
      var y2 = centerX + (width * 0.335 + 2) * sin(i * pi / 180);
      if (a >= 0) {
        Paint line = Paint()
          ..color = Color(0xFFFFFFFF).withOpacity(a)
          ..strokeWidth = 2.5;
        a -= 0.02;
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
      } else {
        break;
      }
    }
    canvas.drawCircle(Offset(centerX, centerY - dRad),
        (width * 0.4 - width * 0.335) / 2, whiteCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
>>>>>>> 1d1672ed47b61a54f267f54e6d5ce01563f595cf

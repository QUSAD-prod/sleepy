<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _StatsGraphProps { height }

class StatsGraph extends StatelessWidget {
  StatsGraph({
    required this.hours,
    required this.maxHeight,
    required this.width,
  });
  final double hours;
  final double maxHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<_StatsGraphProps>()
      ..add(
        _StatsGraphProps.height,
        0.0.tweenTo((hours / 24) * maxHeight),
        0.1.seconds,
      );

    return CustomAnimation<MultiTweenValues<_StatsGraphProps>>(
      tween: tween,
      curve: Curves.easeInOut,
      builder: buildGraphLine,
    );
  }

  Widget buildGraphLine(
    context,
    child,
    MultiTweenValues<_StatsGraphProps> value,
  ) {
    return Column(
      children: [
        Expanded(child: Container()),
        Container(
          height: value.get(_StatsGraphProps.height),
          width: this.width,
          decoration: BoxDecoration(
            color: Color(0xFF65C7FF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
          ),
        ),
      ],
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _StatsGraphProps { height }

class StatsGraph extends StatelessWidget {
  StatsGraph({
    required this.hours,
    required this.maxHeight,
    required this.width,
  });
  final double hours;
  final double maxHeight;
  final double width;

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<_StatsGraphProps>()
      ..add(
        _StatsGraphProps.height,
        0.0.tweenTo((hours / 24) * maxHeight),
        0.1.seconds,
      );

    return CustomAnimation<MultiTweenValues<_StatsGraphProps>>(
      tween: tween,
      curve: Curves.easeInOut,
      builder: buildGraphLine,
    );
  }

  Widget buildGraphLine(
    context,
    child,
    MultiTweenValues<_StatsGraphProps> value,
  ) {
    return Column(
      children: [
        Expanded(child: Container()),
        Container(
          height: value.get(_StatsGraphProps.height),
          width: this.width,
          decoration: BoxDecoration(
            color: Color(0xFF65C7FF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
          ),
        ),
      ],
    );
  }
}
>>>>>>> 1d1672ed47b61a54f267f54e6d5ce01563f595cf

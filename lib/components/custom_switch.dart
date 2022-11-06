<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _SwitchBoxProps { paddingLeft, color }

class CustomSwitch extends StatelessWidget {
  final bool switched;

  CustomSwitch({required this.switched});

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<_SwitchBoxProps>()
      ..add(
        _SwitchBoxProps.paddingLeft,
        0.0.tweenTo(23.0),
        0.2.seconds,
      )
      ..add(
        _SwitchBoxProps.color,
        Colors.red.tweenTo(Color(0xFF65C7FF)),
        0.2.seconds,
      );

    return CustomAnimation<MultiTweenValues<_SwitchBoxProps>>(
      control: switched
          ? CustomAnimationControl.play
          : CustomAnimationControl.playReverse,
      startPosition: switched ? 1.0 : 0.0,
      duration: tween.duration,
      tween: tween,
      curve: Curves.easeInOut,
      builder: _buildSwitchBox,
    );
  }

  Widget _buildSwitchBox(
    context,
    child,
    MultiTweenValues<_SwitchBoxProps> value,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: value.get(_SwitchBoxProps.color),
        borderRadius: BorderRadius.circular(100),
      ),
      width: 51,
      height: 28,
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding:
                  EdgeInsets.only(left: value.get(_SwitchBoxProps.paddingLeft)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _SwitchBoxProps { paddingLeft, color }

class CustomSwitch extends StatelessWidget {
  final bool switched;

  CustomSwitch({required this.switched});

  @override
  Widget build(BuildContext context) {
    var tween = MultiTween<_SwitchBoxProps>()
      ..add(
        _SwitchBoxProps.paddingLeft,
        0.0.tweenTo(23.0),
        0.2.seconds,
      )
      ..add(
        _SwitchBoxProps.color,
        Colors.red.tweenTo(Color(0xFF65C7FF)),
        0.2.seconds,
      );

    return CustomAnimation<MultiTweenValues<_SwitchBoxProps>>(
      control: switched
          ? CustomAnimationControl.play
          : CustomAnimationControl.playReverse,
      startPosition: switched ? 1.0 : 0.0,
      duration: tween.duration,
      tween: tween,
      curve: Curves.easeInOut,
      builder: _buildSwitchBox,
    );
  }

  Widget _buildSwitchBox(
    context,
    child,
    MultiTweenValues<_SwitchBoxProps> value,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: value.get(_SwitchBoxProps.color),
        borderRadius: BorderRadius.circular(100),
      ),
      width: 51,
      height: 28,
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding:
                  EdgeInsets.only(left: value.get(_SwitchBoxProps.paddingLeft)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 1d1672ed47b61a54f267f54e6d5ce01563f595cf

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _ButtonProps {
  color,
  inkWellColor,
  opacity,
}

class MyButton extends StatelessWidget {

  final bool isActive;
  final Function onClick;
  final Box box;

  MyButton({
    required this.isActive,
    required this.onClick,
    required this.box,
  });

  final MultiTween<_ButtonProps> buttonTween = MultiTween<_ButtonProps>()
    ..add(
      _ButtonProps.color,
      Color(0xFFFFFFFF).withOpacity(0.0).tweenTo(Color(0xFF5868F0)),
      10.milliseconds,
    )
    ..add(
      _ButtonProps.inkWellColor,
      Colors.white.withOpacity(0.8).tweenTo(Colors.white.withOpacity(0.0)),
      10.milliseconds,
    )
    ..add(
      _ButtonProps.opacity,
      1.0.tweenTo(0.0),
      10.milliseconds,
    );

  @override
  Widget build(BuildContext context) {
    if (isActive != box.get("")) {
    
    }
    return CustomAnimation<MultiTweenValues<_ButtonProps>>(
      control: !isActive
          ? CustomAnimationControl.play
          : CustomAnimationControl.playReverse,
      tween: buttonTween,
      curve: Curves.easeInOut,
      builder: _buttonBuilder,
    );
  }

  Widget _buttonBuilder(
    context,
    child,
    MultiTweenValues<_ButtonProps> value,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: value.get(_ButtonProps.color),
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
          splashColor: value.get(_ButtonProps.inkWellColor),
          borderRadius: BorderRadius.circular(16.0),
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.5),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Пойти спать",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF).withOpacity(1 - value.get(_ButtonProps.opacity)),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "Перестать спать",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF).withOpacity(value.get(_ButtonProps.opacity)),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyButton extends StatelessWidget {

  final bool isActive;
  final Function onClick;
  final Box box;

  MyButton({
    required this.isActive,
    required this.onClick,
    required this.box,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.transparent : Color(0xFF5868F0),
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
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.5),
            child: Center(
              child: Text(
                isActive ? "Перестать спать" : "Пойти спать",
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

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    !isActive ? Icons.bedtime : Icons.bedtime_off,
                    color: Colors.black.withOpacity(0.9),
                  ),
                  Padding(padding: EdgeInsets.only(left: 4)),
                  Text(
                    isActive ? "Перестать спать" : "Пойти спать",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

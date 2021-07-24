import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
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
        children: [
          Container(
            child: Text(
              "Статистика засыпания и пробуждения",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 48.0),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/bottom_navigation.dart';
import 'package:sleepy/components/time.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsTimeAdapter());
  await Hive.openBox<dynamic>("data");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: MyBottomNavigation(),
    );
  }
}

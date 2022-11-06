<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/custom_switch.dart';
import 'package:sleepy/components/time.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: Hive.box("data").listenable(),
      builder: (context, Box box, widget) {
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                child: Text(
                  "Настройки",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                child: Text(
                  "Установка времени и настройка вибрации",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                width: width * 0.9,
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                width: (width * 0.9),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Длительность сна",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: height * 0.025),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () => selectTime(
                        context,
                        box,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFBE97E5),
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        width: 94.0,
                        height: 52.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            MyTime().getTimeFromDateTime(
                              box.get(
                                "alarm_time",
                                defaultValue: MyTime().getDefault(),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                width: width * 0.9,
                child: Column(
                  children: [
                    listEl(
                      "Пение птиц",
                      0,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Гитарная мелодия",
                      1,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Открытие луны",
                      2,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Латрина",
                      3,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Гармония",
                      4,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Вертулион",
                      5,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Тримиол",
                      6,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.025,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                width: (width * 0.9),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Вибрация",
                        style: TextStyle(
                          color: Color(0xFF160647),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          box.put(
                            "alarm_vibration",
                            !box.get(
                              "alarm_vibration",
                              defaultValue: true,
                            ),
                          );
                        },
                        child: CustomSwitch(
                          switched: box.get(
                            "alarm_vibration",
                            defaultValue: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget seporator(double width) {
    return Container(
      color: Color(0xFF160647).withOpacity(0.1),
      width: double.infinity,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: width * 0.064),
    );
  }

  Widget listEl(
    String child,
    int id,
    int _currentListEl,
    double width,
    double height,
    Box box,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectListEl(id, box),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height * 0.06,
            padding: EdgeInsets.symmetric(horizontal: width * 0.045),
            child: Center(
              child: Row(
                children: [
                  Text(
                    child,
                    style: TextStyle(
                      color: getListElcolor(id, _currentListEl),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  isChecked(id, _currentListEl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getListElcolor(int id, int _currentListEl) {
    if (id == _currentListEl) {
      return Color(0xFF65C7FF);
    } else {
      return Color(0xFF160647);
    }
  }

  Widget isChecked(int id, int _currentListEl) {
    if (id == _currentListEl) {
      return SvgPicture.asset("res/settings_check.svg");
    } else {
      return Container();
    }
  }

  void selectListEl(int id, Box box) {
    setState(
      () {
        box.put("alarm_sound", id);
      },
    );
  }

  Future<Null> selectTime(BuildContext context, Box box) async {
    DateTime boxTime = await box.get(
      "alarm_time",
      defaultValue: MyTime().getDefault(),
    );
    TimeOfDay selectedTime = TimeOfDay(
      hour: boxTime.hour,
      minute: boxTime.minute,
    );
    TimeOfDay? temp = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      cancelText: "Отмена",
      confirmText: "Ок",
      helpText: "Сколько вы хотите спать?",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (temp != null && (temp.hour != 0 || temp.minute != 0)) {
      box.put("alarm_time", MyTime().addTime(temp.hour, temp.minute));
    }
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/custom_switch.dart';
import 'package:sleepy/components/time.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: Hive.box("data").listenable(),
      builder: (context, Box box, widget) {
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                child: Text(
                  "Настройки",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                child: Text(
                  "Установка времени и настройка вибрации",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                width: width * 0.9,
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                width: (width * 0.9),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Длительность сна",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: height * 0.025),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () => selectTime(
                        context,
                        box,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFBE97E5),
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        width: 94.0,
                        height: 52.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            MyTime().getTimeFromDateTime(
                              box.get(
                                "alarm_time",
                                defaultValue: MyTime().getDefault(),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                width: width * 0.9,
                child: Column(
                  children: [
                    listEl(
                      "Пение птиц",
                      0,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Гитарная мелодия",
                      1,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Открытие луны",
                      2,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Латрина",
                      3,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Гармония",
                      4,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Вертулион",
                      5,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                    seporator(width),
                    listEl(
                      "Тримиол",
                      6,
                      box.get("alarm_sound", defaultValue: 0),
                      width,
                      height,
                      box,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.025,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                width: (width * 0.9),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Вибрация",
                        style: TextStyle(
                          color: Color(0xFF160647),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          box.put(
                            "alarm_vibration",
                            !box.get(
                              "alarm_vibration",
                              defaultValue: true,
                            ),
                          );
                        },
                        child: CustomSwitch(
                          switched: box.get(
                            "alarm_vibration",
                            defaultValue: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget seporator(double width) {
    return Container(
      color: Color(0xFF160647).withOpacity(0.1),
      width: double.infinity,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: width * 0.064),
    );
  }

  Widget listEl(
    String child,
    int id,
    int _currentListEl,
    double width,
    double height,
    Box box,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectListEl(id, box),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height * 0.06,
            padding: EdgeInsets.symmetric(horizontal: width * 0.045),
            child: Center(
              child: Row(
                children: [
                  Text(
                    child,
                    style: TextStyle(
                      color: getListElcolor(id, _currentListEl),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  isChecked(id, _currentListEl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getListElcolor(int id, int _currentListEl) {
    if (id == _currentListEl) {
      return Color(0xFF65C7FF);
    } else {
      return Color(0xFF160647);
    }
  }

  Widget isChecked(int id, int _currentListEl) {
    if (id == _currentListEl) {
      return SvgPicture.asset("res/settings_check.svg");
    } else {
      return Container();
    }
  }

  void selectListEl(int id, Box box) {
    setState(
      () {
        box.put("alarm_sound", id);
      },
    );
  }

  Future<Null> selectTime(BuildContext context, Box box) async {
    DateTime boxTime = await box.get(
      "alarm_time",
      defaultValue: MyTime().getDefault(),
    );
    TimeOfDay selectedTime = TimeOfDay(
      hour: boxTime.hour,
      minute: boxTime.minute,
    );
    TimeOfDay? temp = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      cancelText: "Отмена",
      confirmText: "Ок",
      helpText: "Сколько вы хотите спать?",
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (temp != null && (temp.hour != 0 || temp.minute != 0)) {
      box.put("alarm_time", MyTime().addTime(temp.hour, temp.minute));
    }
  }
}
>>>>>>> 1d1672ed47b61a54f267f54e6d5ce01563f595cf

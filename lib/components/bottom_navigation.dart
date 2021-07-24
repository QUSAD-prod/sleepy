import 'package:flutter/material.dart';
import 'package:sleepy/pages/clock_page.dart';
import 'package:sleepy/pages/settings_page.dart';
import 'package:sleepy/pages/stats_page.dart';
import 'bottom_panel_icons_icons.dart';

class MyBottomNavigation extends StatefulWidget {

  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF3E42B2),
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white.withOpacity(.40),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: "Время сна",
            icon: Icon(BottomPanelIcons.bed),
          ),
          BottomNavigationBarItem(
            label: "Статистика",
            icon: Icon(BottomPanelIcons.graph),
          ),
          BottomNavigationBarItem(
            label: "Настройки",
            icon: Icon(BottomPanelIcons.settings),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (this._currentIndex) {
      case 0:
        return ClockPage();
      case 1:
        return StatsPage();
      case 2:
        return SettingsPage();
      default:
        return ClockPage();
    }
  }
}

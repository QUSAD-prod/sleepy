import 'package:flutter/material.dart';
import 'package:sleepy/pages/clock_page.dart';
import 'package:sleepy/pages/settings_page.dart';
import 'package:sleepy/pages/stats_page.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int _currentIndex = 0;

  late final ClockPage clockPage;
  late final StatsPage statsPage;
  late final SettingsPage settingsPage;

  @override
  void initState() {
    super.initState();
    clockPage = ClockPage();
    statsPage = StatsPage();
    settingsPage = SettingsPage();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: NavigationBar(
        height: height * 0.09,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() => _currentIndex = value);
        },
        destinations: const <Widget>[
          NavigationDestination(
            label: "Главная",
            icon: Icon(Icons.bedtime_outlined),
            selectedIcon: Icon(Icons.bedtime),
          ),
          NavigationDestination(
            label: "Статистика",
            icon: Icon(Icons.insert_chart_outlined_rounded),
            selectedIcon: Icon(Icons.insert_chart_rounded),
          ),
          NavigationDestination(
            label: "Настройки",
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (this._currentIndex) {
      case 0:
        return clockPage;
      case 1:
        return statsPage;
      case 2:
        return settingsPage;
      default:
        return clockPage;
    }
  }
}

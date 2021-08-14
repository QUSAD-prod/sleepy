import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleepy/components/stats_api.dart';
import 'package:sleepy/components/stats_graph.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int activeGraph = 1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Box box = Hive.box("data");
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
            margin: EdgeInsets.only(top: height * 0.06),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.029),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
            ),
            width: width * 0.829,
            height: height * 0.52,
            child: Container(
              margin: EdgeInsets.all(height * 0.029),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFF1F767680).withOpacity(0.12),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  activeGraph = 0;
                                });
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                decoration: getContainerStyle(0, activeGraph),
                                child: Center(
                                  child: Text(
                                    "День",
                                    style: getTextStyle(0, activeGraph),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        getSeporator(height),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  activeGraph = 1;
                                });
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                decoration: getContainerStyle(1, activeGraph),
                                child: Center(
                                  child: Text(
                                    "Неделя",
                                    style: getTextStyle(1, activeGraph),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: height * 0.03),
                    child: Text(
                      getText(box),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF160647),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  getStats(width, height, box),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getStats(double width, double height, Box box) {
    List<double> hours = [];
    hours = StatsApi().getHours(hours, box);
    if (activeGraph == 0) {
      if (hours[DateTime.now().weekday - 1] == 0) {
        return Expanded(
          child: Center(
            child: Text(
              "Вы ещё не пользовались нашим приложением сегодня",
              style: TextStyle(
                color: Color(0xFF160647),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        double hour = hours[DateTime.now().weekday - 1];
        Map statistics = (box.get("statistics") as Map);
        double timeSleep = StatsApi().getTimeSleep(statistics);
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(top: height * 0.02),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: width * 0.17,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height * 0.016),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                horizontalLine(width),
                                Expanded(child: Container()),
                                horizontalLine(width),
                                Expanded(child: Container()),
                                horizontalLine(width),
                                Expanded(child: Container()),
                                horizontalLine(width),
                                Expanded(child: Container()),
                                horizontalLine(width),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: height * 0.016,
                              left: width * 0.048,
                            ),
                            child: Row(
                              children: [
                                verticalLine(width, height),
                                Expanded(child: Container()),
                                verticalLine(width, height),
                                Expanded(child: Container()),
                                verticalLine(width, height),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  getGraphText("24"),
                                  Expanded(child: Container()),
                                  getGraphText("18"),
                                  Expanded(child: Container()),
                                  getGraphText("12"),
                                  Expanded(child: Container()),
                                  getGraphText("6"),
                                  Expanded(child: Container()),
                                  getGraphText("0"),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.048),
                        child: Center(
                          child: Container(
                            width: width * 0.065,
                            child: StatsGraph(
                              hours: hour,
                              maxHeight: height * 0.331,
                              width: width,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: width * 0.024,
                      top: height * 0.016,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Вы спали: " +
                              hour.toString() +
                              getHourString(hour.toInt()),
                          style: getDayGraphTextStyle(),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: height * 0.007),
                          height: 2,
                          color: Color(0xFF65C7FF),
                        ),
                        Text(
                          statistics.length > 1
                              ? getDeltaHours(hour, timeSleep)
                              : "Дополнительная статистика недоступна",
                          style: getDayGraphTextStyle(),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: height * 0.007),
                          height: 2,
                          color: Color(0xFF65C7FF),
                        ),
                        Text(
                          (box.get("statistics") as Map).length > 1
                              ? "Среднее время сна: " + timeSleep.toString() + getHourString(timeSleep.toInt())
                              : "Среднее время сна недоступно",
                          style: getDayGraphTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      if (hours[0] != 0 ||
          hours[1] != 0 ||
          hours[2] != 0 ||
          hours[3] != 0 ||
          hours[4] != 0 ||
          hours[5] != 0 ||
          hours[6] != 0) {
        return Stack(
          children: [
            getGraphBackground(width, height),
            Container(
              margin: EdgeInsets.only(top: height * 0.02),
              height: height * 0.31,
              child: Container(
                margin: EdgeInsets.only(
                  left: width * 0.1005,
                  right: width * 0.052,
                ),
                child: Row(
                  children: [
                    StatsGraph(
                      hours: hours[0],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[1],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[2],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[3],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[4],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[5],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                    Expanded(child: Container()),
                    StatsGraph(
                      hours: hours[6],
                      maxHeight: height * 0.293,
                      width: width * 0.06,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Expanded(
          child: Center(
            child: Text(
              "Вы ещё не пользовались нашим приложением на этой неделе",
              style: TextStyle(
                color: Color(0xFF160647),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  String getDeltaHours(double hour, double stats) {
    if (hour > stats) {
      return "Это на " + (hour-stats).toString() + getHourString((hour-stats).toInt()) + " больше, чем обычно";
    } else if (hour < stats) {
      return "Это на " + (stats-hour).toString() + getHourString((stats-hour).toInt()) + " меньше, чем обычно";
    } else {
      return "Это столько же, сколько обычно";
    }
  }

  TextStyle getDayGraphTextStyle() {
    return TextStyle(
      color: Color(0xFF160647),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  String getHourString(int hour) {
    switch (hour) {
      case 1:
      case 21:
        return " час";
      case 2:
      case 3:
      case 4:
      case 22:
      case 23:
      case 24:
        return " часа";
      default:
        return " часов";
    }
  }

  Widget horizontalLine(double width) {
    return Container(
      height: 2,
      color: Color(0xFFF2F2F2),
      margin: EdgeInsets.only(left: width * 0.048),
    );
  }

  Widget verticalLine(double width, double height) {
    return Container(
      width: 2,
      color: Color(0xFFF2F2F2),
    );
  }

  BoxDecoration getContainerStyle(int id, int activeGraph) {
    if (id != activeGraph) {
      return BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      );
    } else {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black.withOpacity(0.04),
            offset: Offset(0, 3),
            spreadRadius: 0.0,
          ),
          BoxShadow(
            blurRadius: 8.0,
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 3),
            spreadRadius: 0.0,
          ),
        ],
      );
    }
  }

  Text getGraphText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF9B99A9),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextStyle getTextStyle(int id, int activeGraph) {
    if (id != activeGraph) {
      return TextStyle(
        color: Color(0xFF160647),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
    } else {
      return TextStyle(
        color: Color(0xFF160647),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );
    }
  }

  Widget getSeporator(double h) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 1,
        height: h * 0.023,
        decoration: BoxDecoration(
          color: Color(0xFF8E8E93).withOpacity(0.3),
        ),
      ),
    );
  }

  String getText(Box box) {
    if (activeGraph == 0) {
      return "Сегодня, " +
          DateTime.now().day.toString() +
          getMonth(DateTime.now().month) +
          DateTime.now().year.toString() +
          "г.";
    } else {
      return getText1();
    }
  }

  String getMonth(int m) {
    switch (m) {
      case 1:
        return " января ";
      case 2:
        return " февраля ";
      case 3:
        return " марта ";
      case 4:
        return " апреля ";
      case 5:
        return " мая ";
      case 6:
        return " июня ";
      case 7:
        return " июля ";
      case 8:
        return " августа ";
      case 9:
        return " сентября ";
      case 10:
        return " октября ";
      case 11:
        return " ноября ";
      case 12:
        return " декабря ";
      default:
        return " ";
    }
  }

  String getText1() {
    String s;
    if (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1))
            .day
            .toString()
            .length ==
        1) {
      s = "0" +
          DateTime.now()
              .subtract(Duration(days: DateTime.now().weekday - 1))
              .day
              .toString();
    } else {
      s = DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - 1))
          .day
          .toString();
    }

    if (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1))
            .month ==
        (DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))
            .add(Duration(days: 6))
            .month) {
      s = s + " - ";
    } else {
      s = s +
          getMonth(DateTime.now()
              .subtract(Duration(days: DateTime.now().weekday - 1))
              .month) +
          "- ";
    }

    if ((DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))
            .add(Duration(days: 6))
            .day
            .toString()
            .length ==
        1) {
      s = s +
          "0" +
          (DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))
              .add(Duration(days: 6))
              .day
              .toString();
    } else {
      s = s +
          (DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))
              .add(Duration(days: 6))
              .day
              .toString();
    }

    s = s +
        getMonth((DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 1)))
            .add(Duration(days: 6))
            .month) +
        DateTime.now().year.toString() +
        "г.";
    return s;
  }

  Widget getGraphBackground(double width, double height) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: height * 0.02),
          height: height * 0.31,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.016),
                child: Column(
                  children: [
                    horizontalLine(width),
                    Expanded(child: Container()),
                    horizontalLine(width),
                    Expanded(child: Container()),
                    horizontalLine(width),
                    Expanded(child: Container()),
                    horizontalLine(width),
                    Expanded(child: Container()),
                    horizontalLine(width),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.016,
                  left: width * 0.048,
                ),
                child: Row(
                  children: [
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                    Expanded(child: Container()),
                    verticalLine(width, height),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        getGraphText("24"),
                        Expanded(child: Container()),
                        getGraphText("18"),
                        Expanded(child: Container()),
                        getGraphText("12"),
                        Expanded(child: Container()),
                        getGraphText("6"),
                        Expanded(child: Container()),
                        getGraphText("0"),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: width * 0.070, top: height * 0.008, right: width * 0.022),
          child: Row(
            children: [
              Expanded(child: Container()),
              getGraphText("Пн"),
              Expanded(child: Container()),
              getGraphText("Вт"),
              Expanded(child: Container()),
              getGraphText("Ср"),
              Expanded(child: Container()),
              getGraphText("Чт"),
              Expanded(child: Container()),
              getGraphText("Пт"),
              Expanded(child: Container()),
              getGraphText("Сб"),
              Expanded(child: Container()),
              getGraphText("Вс"),
              Expanded(child: Container()),
            ],
          ),
        ),
      ],
    );
  }
}

<<<<<<< HEAD
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sleepy/components/bottom_navigation.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({Key? key}) : super(key: key);

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MyBottomNavigation(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: MediaQuery.of(context).viewPadding.top,
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
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
            Expanded(child: Container()),
            Container(
              width: width * 0.4,
              height: width * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "Sleepy",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.055,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                "Новый подход ко сну",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  height: 0.9,
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.04),
              child: Text(
                "by Oslopov",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
=======
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sleepy/components/bottom_navigation.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({Key? key}) : super(key: key);

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MyBottomNavigation(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: MediaQuery.of(context).viewPadding.top,
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
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
            Expanded(child: Container()),
            Container(
              width: width * 0.4,
              height: width * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "Sleepy",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.055,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                "Новый подход ко сну",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  height: 0.9,
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.04),
              child: Text(
                "by Oslopov",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
>>>>>>> 1d1672ed47b61a54f267f54e6d5ce01563f595cf

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nevis/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'intro_screen.dart';

class SplashScreenView extends StatefulWidget {
  static const String id = "/splashScreen";

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<SplashScreenView> {
  final splashDelay = 1;
  String _versionName = 'V1.0';

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Timer(Duration(seconds: splashDelay),
          () => Navigator.popAndPushNamed(context, Home.id));
    } else {
      await prefs.setBool('seen', true);
      Timer(Duration(seconds: splashDelay),
          () => Navigator.popAndPushNamed(context, IntroScreen.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;
    checkFirstSeen();
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/nevis.JPG',
                        height: height/2,
                        width: width/2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }
}

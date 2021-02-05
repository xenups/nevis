import 'package:flutter/material.dart';
import 'package:nevis/views/home.dart';
import 'package:nevis/views/intro_screen.dart';
import 'package:nevis/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreenView.id,
      routes: {
        IntroScreen.id: (context) => IntroScreen(),
        Home.id: (context) => Home(),
        SplashScreenView.id: (context) => SplashScreenView(),
      },
    );
  }
}

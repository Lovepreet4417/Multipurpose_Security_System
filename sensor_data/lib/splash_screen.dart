import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'homeScreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        "Multipurpose Security System",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
      ),

      gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.004, 1.000],
          colors: [Color(0x11232526), Color(0XFF232526)]), // LinearGradient
      photoSize: 50,
      loaderColor: Colors.white,
    ); // SplashScreen
  }
}

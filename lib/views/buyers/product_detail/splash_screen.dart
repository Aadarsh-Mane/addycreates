import 'package:addycreates/views/buyers/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text('Home Made ',
            style: TextStyle(
                fontSize: 34,
                // width:MediaQuery.of(context).size.width * 0.5,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: <Color>[
                      Colors.pinkAccent,
                      Colors.deepPurpleAccent,
                      Colors.red
                      //add more color here.
                    ],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)))),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 2,),
              Text(
                'G r a s s V E S S',
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'provided by',
                    style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                  ),
              ),

            Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  heightFactor: 0.4,
                  child: Image.asset('images/grassland_logo_transparent.png'),
                ),
            ),
              Spacer(flex: 1,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'in association with',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
              ),

              Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    heightFactor: 0.3,
                    child: Image.asset('images/teagasc_logo_transparent.png'),
                  ),
              ),
            ]
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_app/splashScreen.dart';

/*
  Main program entry point.
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Uncomment when user wants to clear previous application assessment details.
    //deleteFile();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrassVESS',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFF5F5F5)),
      home: SplashScreen(), // Firstly, display the application splash screen.
    );
  }
}
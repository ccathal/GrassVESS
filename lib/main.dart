import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/splashScreen.dart';

///
/// Application Main Entry Point.
///
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((val) {
    runApp(MyApp());
  });
}

///
/// Method: MyApp
///
/// Main Application Method.
///
/// Return: [Widget] is the main application page that displays the splash screen.
///
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
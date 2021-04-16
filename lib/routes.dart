import 'package:flutter/material.dart';

///
/// Class: Routes.
///
/// Displays the next page in the application by performing transition.
///
class Routes {

  ///
  /// Method: _transitionBuilder
  ///
  /// Method for page transition.
  ///
  /// Return: [Widget] of the page transition.
  ///
  static Widget _transitionBuilder(animation, child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  ///
  /// Method: createRoutingPage
  ///
  /// Method for displaying the next application page by route.
  ///
  /// Input: [routeClass] the widget class of the new application page.
  /// Return: [Widget] of the page transition with new application page.
  ///
  static Route createRoutingPage(routeClass) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => routeClass,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _transitionBuilder(animation, child);
      },
    );
  }
}
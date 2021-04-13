import 'package:flutter/material.dart';

class Routes {

  /*
    Method for page transition.
   */
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

  /*
    Method for displaying the next application page by route.
   */
  static Route createRoutingPage(routeClass) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => routeClass,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _transitionBuilder(animation, child);
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushReplaceMent(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: newScreen,
      ),
    );
  }

  Future<dynamic> push(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: newScreen,
      ),
    );
  }
}

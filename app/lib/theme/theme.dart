import 'package:flutter/material.dart';

class KeplerTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFF20211E),
        dialogBackgroundColor: Color(0xFFF312F31),
        cardColor: Colors.grey[600],
      );

  static builder(child) => ScrollConfiguration(
        behavior: RemoveGlow(),
        child: child,
      );
}

//Remove Glow OverScroll effect behaviour
class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/views/homeView.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Kepler',
    darkTheme: ThemeData(brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    home: Home(),
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: RemoveGlow(),
        child: child,
      );
    },
  ));
}

//Remove Glow OverScroll effect behaviour
class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

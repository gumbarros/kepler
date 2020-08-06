import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/views/home.dart';

void main() {
  runApp(GetMaterialApp(
    darkTheme: ThemeData(brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/locale/translations.dart';

class Snackbars {
  static void error(String description) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(
        string.text("error"),
        description,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(seconds: 2),
      );
  }

  static void development() {
    if (!Get.isSnackbarOpen)
      Get.snackbar(string.text("coming_soon"), string.text("under_development"),
          backgroundColor: Colors.white,
          colorText: Colors.black);
  }

  static void snackbar({String title = "", String text = "", Color color = Colors.white}) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(title, text,
          backgroundColor: color,
          colorText: Colors.black);
  }
}

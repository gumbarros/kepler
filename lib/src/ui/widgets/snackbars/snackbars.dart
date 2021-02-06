import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbars {
  static void error(String description) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(
        "error".tr,
        description,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(seconds: 2),
      );
  }

  static void development() {
    if (!Get.isSnackbarOpen)
      Get.snackbar("coming_soon".tr, "under_development".tr,
          backgroundColor: Colors.white,
          colorText: Colors.black);
  }

  static void snackbar({String title = "", String text = "", Color color = Colors.white}) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(title, text,
          backgroundColor: color,
          colorText: Colors.black);
  }

  static void success({String title = "", String text = "", Color color = Colors.green}) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(title, text,
          backgroundColor: color,
          colorText: Colors.white);
  }
}

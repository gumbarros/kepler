import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StarsController extends GetxController {
  static StarsController get to => Get.find();

  Color getStarColor(double temperature) {
    temperature = temperature ?? 0;
    if (temperature >= 25000) {
      return Colors.blue[200];
    } else if (temperature < 25000 && temperature >= 10000) {
      return Colors.white;
    } else if (temperature < 10000 && temperature >= 6000) {
      return Colors.yellow[200];
    } else if (temperature < 6000 && temperature <= 4000) {
      return Colors.orange[200];
    } else {
      return Colors.red[300];
    }
  }

  void upd() {
    update();
  }
}

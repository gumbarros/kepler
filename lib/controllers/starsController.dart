import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StarsController extends GetxController {
  static StarsController get to => Get.find();

  final RxString search = "".obs;

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

  ///Returns a bool if the search matches the [name]
  bool find(String name) {
    if (search.value == null)
      return true;
    else if (search.value.isEmpty)
      return true;
    else if (name.toLowerCase().contains(search.value.toLowerCase()))
      return true;
    else {
      return false;
    }
  }

  void upd() {
    update();
  }
}

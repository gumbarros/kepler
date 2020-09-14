import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderController extends GetxController {

  static HeaderController get to => Get.find();

  bool gap = true;
  int gapNumber;
  ScrollController scrollController;
  RxDouble position = 0.0.obs;

  changeMinus() {
    position.value -= 7;
  }

  changePlus() {
    position.value += 7;
  }

  changeZero() {
    position.value = 0;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderController extends GetxController {

  static HeaderController get to => Get.find();

  bool gap = true;
  int gapNumber;
  ScrollController scrollController;
  RxDouble position = 0.0.obs;

  changeMinus() {
    position.value -= 10;
  }

  changePlus() {
    position.value += 10;
  }

  changeZero() {
    position.value = 0;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/views/chartsView.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/settingsView.dart';

class PagesController extends GetxController {
  static PagesController get to => Get.find();
  final int initialIndex;

  PagesController(this.initialIndex);

  int currentIndex;
  Widget pageView;

  @override
  void onInit() {
    currentIndex = initialIndex;
    pageView = _changeView(initialIndex);
  }

  Widget _changeView(int index) {
    switch (index) {
      case 0:
        return StarsView();
        break;
      case 1:
        return ChartsView();
        break;
      case 2:
        return SettingsView();
        break;
      default:
        return StarsView();
    }
  }

  void changeView(Widget view) {
    this.pageView = view;
    update();
  }

  void changeIndex(int index) {
    this.currentIndex = index;
    this.pageView = _changeView(index);
    update();
  }
}

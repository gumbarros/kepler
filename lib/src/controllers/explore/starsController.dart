import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kepler/src/models/enums/starColor.dart';

class StarsController extends GetxController {
  static StarsController get to => Get.find();

  final RxString search = "".obs;

  ///FILTERS
  StarColor colorFilter;

  String ageFrom;
  String ageTo;

  String massFrom;
  String massTo;

  String radiusFrom;
  String radiusTo;

  Color getStarColor(double temperature) {
    temperature = temperature ?? 0;
    if (temperature >= 25000) {
      return Colors.blue[200];
    } else if (temperature < 25000 && temperature >= 10000) {
      return Colors.white;
    } else if (temperature < 10000 && temperature >= 6000) {
      return Colors.yellow[200];
    } else if (temperature < 6000 && temperature >= 4000) {
      return Colors.orange[200];
    } else {
      return Colors.red[300];
    }
  }

  String getStarTemperature(StarColor color){
    if (color == StarColor.BLUE) {
      return "st_teff >= 25000";
    } else if (color == StarColor.WHITE) {
      return "st_teff < 25000 AND st_teff >= 10000";
    } else if (color == StarColor.YELLOW) {
      return "st_teff < 10000 AND st_teff >= 6000";
    } else if (color == StarColor.ORANGE) {
      return "st_teff < 6000 AND st_teff >= 4000";
    } else if(color == StarColor.RED){
      return "st_teff < 4000";
    }
    else{
      return null;
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

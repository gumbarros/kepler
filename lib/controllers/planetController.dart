import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanetController extends GetxController {
  static PlanetController get to => Get.find();

  void upd() {
    update();
  }

  Color getPlanetsColor (double jmk2) {
    jmk2 = jmk2 ?? 0.0;
    double vrc = 0.8625 * jmk2 + 0.0202;
    if(vrc < -0.33) {
      return Colors.black;
    } else if(-0.33 < vrc && vrc < -0.30) {
      return Colors.indigo;
    } else if(-0.30 < vrc && vrc < -0.02) {
      return Colors.blueAccent;
    } else if(-0.02 < vrc && vrc < 0.30) {
      return Colors.blueGrey;
    } else if(0.30 < vrc && vrc < 0.58) {
      return Colors.green[400];
    } else if(0.58 < vrc && vrc < 0.81) {
      return Colors.yellow[100];
    } else if(0.81 < vrc && vrc < 1.40) {
      return Colors.red[500];
    } else if(1.40 < vrc) {
      return Colors.red[900];
    }
    return Colors.black;
  }
}

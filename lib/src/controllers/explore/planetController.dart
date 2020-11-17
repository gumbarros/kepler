import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanetController extends GetxController {
  static PlanetController get to => Get.find();

  void upd() {
    update();
  }

  Color getPlanetsColor (double bmvj) {
    bmvj = bmvj ?? 0.0;
    if(bmvj < -0.33) {
      return Colors.black;
    } else if(-0.33 < bmvj && bmvj < -0.30) {
      return Colors.indigo;
    } else if(-0.30 < bmvj && bmvj < -0.02) {
      return Colors.blueAccent;
    } else if(-0.02 < bmvj && bmvj < 0.30) {
      return Colors.blueGrey;
    } else if(0.30 < bmvj && bmvj < 0.58) {
      return Colors.green[400];
    } else if(0.58 < bmvj && bmvj < 0.81) {
      return Colors.yellow[100];
    } else if(0.81 < bmvj && bmvj < 1.40) {
      return Colors.red[500];
    } else if(1.40 < bmvj) {
      return Colors.red[900];
    }
    return Colors.black;
  }
}

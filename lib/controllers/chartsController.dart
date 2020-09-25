import 'package:get/get.dart';
import 'package:kepler/models/planetData.dart';

class ChartsController extends GetxController {
  static ChartsController get to => Get.find();

  List<PlanetData> orbits;

  void upd() {
    update();
  }
}

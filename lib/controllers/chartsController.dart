import 'package:get/get.dart';
import 'package:kepler/models/planets.dart';

class ChartsController extends GetxController {
  static ChartsController get to => Get.find();

  List<PlanetData> planetData;

  void upd() {
    update();
  }
}

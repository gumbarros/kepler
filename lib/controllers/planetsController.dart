import 'package:get/get.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/models/planets.dart';

class PlanetsController extends GetxController {
  static PlanetsController get to => Get.find();

  Future<List<PlanetData>> getAllPlanets() async {
    List<PlanetData> _planets = await API.getAllPlanets();
    return _planets;
  }

  void upd() {
    update();
  }
}

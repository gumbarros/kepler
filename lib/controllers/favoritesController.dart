import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kepler/models/planetData.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  Box planets;

  @override
  onInit() async {
    planets = await Hive.openBox('planets');
  }

  PlanetData getPlanet(String name) {
    return planets.get(name);
  }

  List getAllPlanets(){
    return planets.values.map((planet) => planet).toList();
  }

  void savePlanet(PlanetData planet) async{
    planets.put(planet.planetName,planet);
  }

  void removePlanet(String name) {
    planets.delete(name);
  }
}

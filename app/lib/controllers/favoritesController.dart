import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  Box planets;

  @override
  onInit() async {
    planets = await Hive.openBox('planets');
  }

  String getPlanet(String name) {
    return planets.get(name);
  }

  List getAllPlanets(){
    return planets.values.map((planet) => planet).toList();
  }

  void savePlanet(String name) async{
    planets.put(name,name);
  }

  void removePlanet(String name) {
    planets.delete(name);
  }
}

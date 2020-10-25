import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/models/universeData.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  Box favorites;

  @override
  void onInit() async {
    favorites = await Hive.openBox('favorites');
  }

  UniverseData getFavorite(String name) {
    return favorites.get(name);
  }

  List<UniverseData> getAllFavorites(){
    return favorites.values.map((favorite) => favorite).toList().cast<UniverseData>();
  }

  void setFavorite(favorite) async{
    if(favorite.runtimeType == PlanetData){
      favorites.put(favorite.planetName,favorite);
    }
    else{
      favorites.put(favorite.name,favorite);
    }
  }

  void removeFavorite(String name) {
    favorites.delete(name);
  }
}

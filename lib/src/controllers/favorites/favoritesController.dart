import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/models/universeData.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  Box favorites;

  @override
  void onInit() async {
    favorites = await Hive.openBox('favorites');
    super.onInit();
  }

  UniverseData getFavorite(String name) {
    return favorites.get(name);
  }

  List<UniverseData> getAllFavorites(){
    print( favorites.values.map((favorite) => favorite).toList().cast<UniverseData>().toString());
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

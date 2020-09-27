import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kepler/models/planetData.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  Box favorites;

  @override
  onInit() async {
    favorites = await Hive.openBox('favorites');
  }

  dynamic getFavorite(String name) {
    return favorites.get(name);
  }

  List getAllFavorites(){
    return favorites.values.map((favorite) => favorite).toList();
  }

  void saveFavorite(favorite) async{
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

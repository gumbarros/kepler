import 'package:get/get.dart';
import 'package:kepler/src/ui/views/dailyImage/dailyImageView.dart';
import 'package:kepler/src/ui/views/explore/planetsView.dart';
import 'package:kepler/src/ui/views/explore/solarSystemView.dart';
import 'package:kepler/src/ui/views/explore/starsView.dart';
import 'package:kepler/src/ui/views/favorites/favoritesView.dart';
import 'package:kepler/src/ui/views/home/homeView.dart';
import 'package:kepler/src/ui/views/mars/marsRoversView.dart';
import 'package:kepler/src/ui/views/settings/secretDeveloperMenuView.dart';
import 'package:kepler/src/ui/views/settings/settingsView.dart';


class Routes {
  static List<GetPage> routes() {
    return [
      GetPage(name:'/home', page: () => HomeView()),
      GetPage(name: '/stars', page: ()=>StarsView()),
      GetPage(name: '/solarSystem', page: () => SolarSystemView()),
      GetPage(name: '/settings', page: ()=>SettingsView()),
      GetPage(name: '/settings/about', page: ()=>SettingsView()),
      GetPage(name: '/settings/secret', page: ()=>SecretDeveloperMenuView()),
      GetPage(name: '/planet', page: ()=> PlanetView()),
      GetPage(name: '/favorites', page: ()=>FavoritesView()),
      GetPage(name: '/dailyImage', page: ()=>DailyImageView()),
      GetPage(name: '/mars/rovers', page: ()=>MarsRoversView())  
    ];
  }
}
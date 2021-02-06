import 'package:get/get.dart';
import 'package:kepler/src/ui/views/dailyImage/daily_image_view.dart';
import 'package:kepler/src/ui/views/explore/planets_view.dart';
import 'package:kepler/src/ui/views/explore/solar_system_view.dart';
import 'package:kepler/src/ui/views/explore/stars_view.dart';
import 'package:kepler/src/ui/views/favorites/favorites_view.dart';
import 'package:kepler/src/ui/views/home/home_view.dart';
import 'package:kepler/src/ui/views/mars/mars_photo_view.dart';
import 'package:kepler/src/ui/views/mars/mars_rover_view.dart';
import 'package:kepler/src/ui/views/mars/mars_view.dart';
import 'package:kepler/src/ui/views/settings/about_view.dart';
import 'package:kepler/src/ui/views/settings/secret_developer_menu_view.dart';
import 'package:kepler/src/ui/views/settings/settings_view.dart';


class Routes {
  static List<GetPage> routes() {
    return [
      GetPage(name:'/home', page: () => HomeView()),
      GetPage(name: '/stars', page: ()=>StarsView()),
      GetPage(name: '/solarSystem', page: () => SolarSystemView()),
      GetPage(name: '/settings', page: ()=>SettingsView()),
      GetPage(name: '/settings/about', page: ()=>AboutView()),
      GetPage(name: '/settings/secret', page: ()=>SecretDeveloperMenuView()),
      GetPage(name: '/planet', page: ()=> PlanetView()),
      GetPage(name: '/favorites', page: ()=>FavoritesView()),
      GetPage(name: '/dailyImage', page: ()=>DailyImageView()),
      GetPage(name: '/mars', page: ()=>MarsView()),
      GetPage(name: '/mars/photo', page: ()=>MarsPhotoView()),
      GetPage(name: '/mars/rovers', page: ()=>MarsRoversView()) 
    ];
  }
}
import 'package:get/get.dart';
import 'package:kepler/views/exploreView.dart';
import 'package:kepler/views/chartsView.dart';
import 'package:kepler/views/homeView.dart';
import 'package:kepler/views/settingsView.dart';

class Routes {
  static List<GetPage> routes() {
    return [
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/settings', page: () => SettingsView()),
      GetPage(name: '/explore', page: () => ExploreView()),
      GetPage(name: '/charts', page: () => ChartsView())
    ];
  }
}

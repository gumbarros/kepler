import 'package:get/get.dart';
import 'package:kepler/views/chartsView.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/homeView.dart';
import 'package:kepler/views/settingsView.dart';
import 'package:kepler/views/views.dart';

class Routes {
  static List<GetPage> routes() {
    return [
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/settings', page: () => SettingsView()),
      GetPage(name: '/charts', page: () => ChartsView()),
      GetPage(
        name: '/stars',
        page: () => StarsView(),
      ),
      GetPage(name: '/views', page: () => Views()),
    ];
  }
}

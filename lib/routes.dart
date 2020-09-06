import 'package:get/get.dart';
import 'package:kepler/views/graphicsView.dart';
import 'package:kepler/views/homeView.dart';
import 'package:kepler/views/settingsView.dart';
import 'package:kepler/views/planetsView.dart';

class Routes {
  static List<GetPage> routes() {
    return [
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/settings', page: () => SettingsView()),
      GetPage(name: '/planets', page: () => PlanetsView()),
      GetPage(name: '/graphics', page: () => GraphicsView())
    ];
  }
}

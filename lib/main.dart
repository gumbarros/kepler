import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kepler/src/controllers/favorites/favoritesController.dart';
import 'package:kepler/src/controllers/settings/settingsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/models/starData.dart';
import 'package:kepler/src/routes.dart';
import 'package:kepler/src/ui/theme.dart';


void main() async {
  await _initializeApp().then((_) {
    runApp(GetMaterialApp(
      title: string.text('app_title'),
      theme: KeplerTheme.theme,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      supportedLocales: string.supportedLocales(),
      initialRoute: '/home',
      getPages: Routes.routes(),
      builder: (context, child) {
        return KeplerTheme.builder(child);
      },
    ));
  });
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  await string.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlareCache.doesPrune = false;
  await _warmupFlare();
  Get.put<FavoritesController>(FavoritesController());
  Get.put<SettingsController>(SettingsController());
  Hive.registerAdapter(PlanetDataAdapter());
  Hive.registerAdapter(StarDataAdapter());
}

final _assetsToWarmup = [
  AssetFlare(bundle: rootBundle, name: "assets/flare/shine.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/clouds.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/land.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/pops.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/holes.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/gas.flr"),
];

Future<void> _warmupFlare() async {
  for (final asset in _assetsToWarmup) {
    await cachedActor(asset);
  }
}

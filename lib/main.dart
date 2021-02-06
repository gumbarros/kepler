import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kepler/src/controllers/favorites/favorites_controller.dart';
import 'package:kepler/src/controllers/settings/settings_controller.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/planet_data.dart';
import 'package:kepler/src/models/star_data.dart';
import 'package:kepler/src/routes.dart';
import 'package:kepler/src/ui/theme.dart';

String locale;

void main() async {
  await _initializeApp().then((_) {
    runApp(GetMaterialApp(
      title: 'app_title'.tr,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: KeplerTheme.theme,
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      supportedLocales: [Locale('pt'), Locale('en'),Locale('vi'),Locale('sv')],
      locale: locale == null ? Get.deviceLocale : Locale(locale),
      fallbackLocale: Locale('en'),
      getPages: Routes.routes(),
      translations: KeplerTranslations(),
      builder: (context, child) {
        return KeplerTheme.builder(child);
      },
    ));
  });
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init().then((_) async{
    //final GetStorage gs = GetStorage();
    //locale = await gs.read("locale");
    //print("pan: " + locale);
  });
  await Hive.initFlutter();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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

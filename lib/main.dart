import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/routes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  Get.put<FavoritesController>(FavoritesController(), permanent: true);
  await string.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmg0JiAnMiU8PjImITowOjw3NjEyISE8IBM0PjI6P30wPD4=");
  runApp(GetMaterialApp(
    title: string.text('app_title'),
    defaultTransition: Transition.cupertino,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFFF20211E),
      dialogBackgroundColor: Color(0xFFF312F31),
      cardColor: Colors.grey[600],
    ),
    debugShowCheckedModeBanner: false,
    supportedLocales: string.supportedLocales(),
    initialRoute: "/home",
    getPages: Routes.routes(),
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: RemoveGlow(),
        child: child,
      );
    },
  ));
}

//Remove Glow OverScroll effect behaviour
class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

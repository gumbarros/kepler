import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kepler/controllers/starHeaderController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/theme/theme.dart';
import 'package:kepler/views/homeView.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'controllers/systemHeaderController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  Get.put<SystemHeaderController>(SystemHeaderController(), permanent: true);
  Get.put<StarHeaderController>(StarHeaderController(), permanent: true);
  await string.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmg0JiAnMiU8PjImITowOjw3NjEyISE8IBM0PjI6P30wPD4=");
  runApp(GetMaterialApp(
    title: string.text('app_title'),
    theme: KeplerTheme.theme,
    debugShowCheckedModeBanner: false,
    supportedLocales: string.supportedLocales(),
    home: HomeView(),
    builder: (context, child) {
      return KeplerTheme.builder(child);
    },
  ));
}



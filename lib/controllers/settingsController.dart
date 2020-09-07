import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/locale/translations.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  Future<void> setLanguage(String code) async {
    await string.setNewLanguage(code).then((_) {
      string.setPreferredLanguage(string.currentLanguage);
    });
    upd();
    HomeController.to.upd();
  }

  void upd() {
    update();
  }
}

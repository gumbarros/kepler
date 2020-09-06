import 'package:get/get.dart';

import 'package:kepler/locale/translations.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  Future<void> setLanguage(String code) async {
    await string.setNewLanguage(code).then((_) {
      string.setPreferredLanguage(string.currentLanguage);
    });
    upd();
  }

  void upd() {
    update();
  }
}

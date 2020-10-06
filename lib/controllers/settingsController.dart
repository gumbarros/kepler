import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/utils/keplerUtils.dart';
import 'package:kepler/widgets/dialogs/syncDialog.dart';
import 'package:kepler/widgets/snackbars/snackbars.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  String lang;
  final RxBool success = false.obs;

  final RxString syncMessage = "".obs;
  final RxDouble syncPercentage = 0.0.obs;

  Future<void> setLanguage(String code) async {
    await string.setNewLanguage(code).then((_) {
      string.setPreferredLanguage(string.currentLanguage);
    });
    upd();
    HomeController.to.upd();
  }

  Future<void> updateData() async {
    success.value = false;
    Get.dialog(SyncDialog(
      success: success,
      syncMessage: syncMessage,
      syncPercentage: syncPercentage,
    ));
    Snackbars.snackbar(
        text: "This may take some time...", title: "Updating data");
    success.value = await KeplerDatabase.db.updateData().then((success) {
      KeplerUtils.syncUpdate("Finished!", 1);
      Get.back();
      if (success) {
        Snackbars.success(title: "Success!", text: "Your data is updated!");
        return true;
      }
      Snackbars.error("Error :(");
      return false;
    });
  }

  void upd() {
    update();
  }
}

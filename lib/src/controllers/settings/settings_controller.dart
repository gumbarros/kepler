import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/src/controllers/home/home_controller.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/ui/widgets/dialogs/sync_dialog.dart';
import 'package:kepler/src/ui/widgets/snackbars/snackbars.dart';
import 'package:kepler/src/utils/kepler_utils.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  String lang;
  final RxBool success = false.obs;

  final RxString syncMessage = "".obs;
  final RxDouble syncPercentage = 0.0.obs;

  final GetStorage gs = GetStorage();

  Future<void> setLanguage(String code) async {
    Get.updateLocale(Locale(code));
    gs.write('locale', code);
    update();
    HomeController.to.update();
  }

  Future<void> updateData(bool welcome) async {
    try {
      success.value = false;

        Get.dialog(SyncDialog(
          success: success,
          syncMessage: syncMessage,
          syncPercentage: syncPercentage,
        ));

      Snackbars.snackbar(text: "this_may_take_some_time".tr, title: "updating_data".tr);

      success.value = await KeplerDatabase.db.updateData().then((success) {
        KeplerUtils.syncUpdate("finished".tr, 1);
        Get.back();
        if (success) {
          Snackbars.success(title: "success".tr, text: "your_data_updated".tr);
          return true;
        } else {
          Snackbars.error("error".tr);
          return false;
        }
      });
    } catch (e) {
      print(e);
      Snackbars.error("error".tr);
    }
  }
}

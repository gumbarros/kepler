import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:kepler/widgets/snackbars/snackbars.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  String lang;
  final RxBool success = false.obs;

  Future<void> setLanguage(String code) async {
    await string.setNewLanguage(code).then((_) {
      string.setPreferredLanguage(string.currentLanguage);
    });
    upd();
    HomeController.to.upd();
  }

  Future<void> updateData() async {
    Get.dialog(

      Obx(
        ()=> Visibility(
          visible: !success.value,
          child: WillPopScope(
            onWillPop: () async => success.value,
            child: Dialog(

              child: Container(
                  width: Get.width / 1.4,
                  height: Get.height / 3,
                  child: Center(
                      child: Loading()),
                ),
            ),
          ),
        ),
      ),
    );
    Snackbars.snackbar(
        text: "This may take some time...", title: "Updating data");
    success.value = await KeplerDatabase.db.updateData().then((success) {
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

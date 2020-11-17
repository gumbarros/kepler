import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';
import 'package:kepler/src/services/api/api.dart';
import 'package:kepler/src/controllers/home/homeController.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/utils/keplerUtils.dart';
import 'package:kepler/src/ui/widgets/dialogs/languageDialog.dart';
import 'package:kepler/src/ui/widgets/dialogs/syncDialog.dart';
import 'package:kepler/src/ui/widgets/snackbars/snackbars.dart';

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

  Future<void> updateData(bool welcome) async {
    try{
      success.value = false;
      if(welcome){
        Get.dialog(LanguageDialog()).then((_){
          Get.dialog(SyncDialog(
            success: success,
            syncMessage: syncMessage,
            syncPercentage: syncPercentage,
          ));
        });
      }
      else{
        Get.dialog(SyncDialog(
          success: success,
          syncMessage: syncMessage,
          syncPercentage: syncPercentage,
        ));
      }

      Snackbars.snackbar(
          text: string.text("this_may_take_some_time"), title: string.text("updating_data"));

      KeplerUtils.syncUpdate(string.text("caching_nasa"), 0.1);
      final cacheDailyImage = await API.getImageOfTheDay();

      new ExtendedImage.network(cacheDailyImage.url);

      success.value = await KeplerDatabase.db.updateData().then((success){
        KeplerUtils.syncUpdate(string.text("finished"), 1);
        Get.back();
        if (success) {
          Snackbars.success(title:string.text("success"), text: string.text("your_data_updated"));
          return true;
        }
        else{
          Snackbars.error(string.text("error"));
          return false;
        }
      });

    }
    catch(e){
      print(e);
      Snackbars.error(string.text("error"));
    }
  }

  void upd() {
    update();
  }
}

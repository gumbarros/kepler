import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/widgets/dialogs/languageDialog.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final GetStorage getStorage = GetStorage();
  @override
  void onReady() {
    if(getStorage.read("welcome") == null){
      SettingsController.to.updateData();
      getStorage.write("welcome", true);
    }
  }

  void upd() {
    update();
  }
}

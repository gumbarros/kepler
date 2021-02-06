import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/src/controllers/settings/settings_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final GetStorage getStorage = GetStorage();
  @override
  void onReady() {
    if(getStorage.read("welcome") == null){
      SettingsController.to.updateData(true);
      getStorage.write("welcome", true);
    }
    super.onReady();
  }

  void upd() {
    update();
  }
}

import 'package:get/get.dart';

class SolarSystemController extends GetxController {
  static SolarSystemController get to => Get.find();

  final RxString search = "".obs;

  bool find(String name) {
    if (search.isNullOrBlank)
      return true;
    else if (name.toLowerCase().contains(search.value.toLowerCase()))
      return true;
    else
      return false;
  }

  void upd() {
    update();
  }
}

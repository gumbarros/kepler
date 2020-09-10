import 'package:get/get.dart';

class HeaderController extends GetxController {
  RxDouble position = 0.0.obs;

  changeminus() {
    position.value -= 10;
  }

  changeplus() {
    position.value += 10;
  }

  changezero() {
    position.value = 0;
  }
}

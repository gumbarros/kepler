import 'package:get/get.dart';
import 'package:kepler/src/models/enums/marsDate.dart';

class MarsController extends GetxController {
  static MarsController get to => Get.find();

  int page = 1;

  Rx<MarsDate> marsDate = MarsDate.SOL.obs;

  void setDate(MarsDate value){
    marsDate.value = value;
  }
}

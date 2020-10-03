import 'package:get/get.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/models/dailyImageData.dart';


class DailyImageController extends GetxController {
  static DailyImageController get to => Get.find();

  Future<DailyImageData> getImageOfTheDay()async{
    return await API.getImageOfTheDay();
  }
}

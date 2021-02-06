import 'package:get/get.dart';
import 'package:kepler/src/services/api/api.dart';
import 'package:kepler/src/models/daily_image_data.dart';


class DailyImageController extends GetxController {
  static DailyImageController get to => Get.find();

  Future<DailyImageData> getImageOfTheDay()async{
    return await API.getImageOfTheDay();
  }
}

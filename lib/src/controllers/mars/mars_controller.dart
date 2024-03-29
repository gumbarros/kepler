import 'package:date_format/date_format.dart' as format;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/models/enums/mars_date.dart';
import 'package:kepler/src/models/mars_data.dart';
import 'package:kepler/src/models/rover_data.dart';
import 'package:kepler/src/services/api/api.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class MarsController extends GetxController {
  static MarsController get to => Get.find();

  int page = 1;

  final Rx<MarsDate> marsDate = MarsDate.NONE.obs;
  final Rx<TextEditingController> earthDate = TextEditingController().obs;
  final RxString solDate = "".obs;
  final RxString apiDate = "".obs;

  void setEarthDate(BuildContext context, RoverData rover) async {
    DateTime date = await PlatformDatePicker.showDate(
      context: context,
      firstDate: rover.landingDate,
      initialDate: rover.landingDate,
      lastDate: rover.maxDate,
    );
    //Date format varies by locale
    if (Get.locale != Locale('pt')) {
      earthDate.value.text = format
          .formatDate(date, [format.mm, '/', format.dd, '/', format.yyyy]);
    } else {
      earthDate.value.text = format
          .formatDate(date, [format.dd, '/', format.mm, '/', format.yyyy]);
    }

    apiDate.value = format
          .formatDate(date, [format.yyyy, '-', format.mm, '-', format.dd]);

  }

  String getTitle() {
    if (marsDate.value == MarsDate.SOL) {
      return solDate.value;
    } else if (marsDate.value == MarsDate.EARTH) {
      return earthDate.value.text;
    }

    return 'latest_photos'.tr;
  }

  void setDate(MarsDate value) {
    marsDate.value = value;
  }

  List<String> getItems(int lastSol) {
    final List<String> items = [];
    for (int i = 0; i <= lastSol; i++) {
      items.add("SOL $i");
    }
    return items;
  }

  Future<List<MarsData>> getMarsData(String rover, int page,) async {
    List<MarsData> mars;
    if (marsDate.value == MarsDate.SOL) {
      mars = await API.getMarsImagesBySol(rover, page, solDate.value.substring(solDate.value.indexOf(" ")+1));
    } else if (marsDate.value == MarsDate.EARTH) {
      mars = await API.getMarsImagesByEarthDate(rover, page, apiDate.value);
    } else {
      mars = await API.getLatestMarsImages(rover, page);
    }
    return mars;
  }
}

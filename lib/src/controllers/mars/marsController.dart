import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/enums/marsDate.dart';
import 'package:kepler/src/models/roverData.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:date_format/date_format.dart' as format;

class MarsController extends GetxController {
  static MarsController get to => Get.find();

  int page = 1;

  Rx<MarsDate> marsDate = MarsDate.SOL.obs;
  Rx<TextEditingController> earthDate = TextEditingController().obs;
  RxString solDate = "".obs;

  void setEarthDate(BuildContext context, RoverData rover) async {
    DateTime date = await PlatformDatePicker.showDate(
      context: context,
      firstDate: rover.landingDate,
      initialDate: rover.landingDate,
      lastDate: rover.maxDate,
    );
    //Date format varies by locale
    if (string.locale != Locale('br')) {
      earthDate.value.text = format
          .formatDate(date, [format.mm, '/', format.dd, '/', format.yyyy]);
    } else {
      earthDate.value.text = UtilData.obterDataDDMMAAAA(date).toString();
    }
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
}

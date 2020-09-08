import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/settingsController.dart';

class LanguageEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (_) => Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[600],
              ),
              width: Get.height - 30,
              child: FlatButton(
                child: Text("English"),
                onPressed: () async {
                  _.setLanguage("en");
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[600],
              ),
              width: Get.height - 30,
              child: FlatButton(
                child: Text("Brazilian Portuguese"),
                onPressed: () async {
                  _.setLanguage("br");
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[600],
              ),
              width: Get.height - 30,
              child: FlatButton(
                child: Text("Vietnamese"),
                onPressed: () async {
                  _.setLanguage("vn");
                },
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/translations.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (_) => Scaffold(
        body: SafeArea(
            child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: Get.height / 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      string.text("settings"),
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 7,
              ),
              Row(
                children: [
                  Container(
                      width: Get.width / 3,
                      child: FlatButton(
                        child: Text("Brazilian Portuguese"),
                        onPressed: () async {
                          await _.setLanguage("br");
                        },
                      )),
                  Container(
                      width: Get.width / 3,
                      child: FlatButton(
                        child: Text("Vietnamese"),
                        onPressed: () async {},
                      )),
                  Container(
                      width: Get.width / 3,
                      child: FlatButton(
                        child: Text("English"),
                        onPressed: () async {
                          _.setLanguage("en");
                        },
                      )),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/languageEntry.dart';
import 'package:kepler/locale/translations.dart';
import 'package:expansion_card/expansion_card.dart';

class SettingsView extends StatelessWidget {
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
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
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ExpansionCard(
                  title: Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline4.color,
                    ),
                  ),
                  children: [
                    LanguageEntry(),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 17,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/settings/settingsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/menuCard.dart';
import 'package:kepler/src/ui/widgets/dialogs/languageDialog.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';


class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: () =>
         Get.toNamed('/settings/secret'),
      child: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (conf) => Stack(
          children: [
            Background(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  child: Stack(
                children: [
                  Header(string.text("settings"), () {
                    Get.back(canPop: true);
                  }),
                  Container(
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  width: Get.width / 2.8,
                                  child: MenuCard(
                                    text: string.text("current_language"),
                                    onTap: () async {
                                      return Get.dialog(LanguageDialog());
                                    },
                                    icon: Icons.language,
                                  )),
                              Container(
                                width: Get.width / 2.8,
                                child: Container(
                                    width: Get.width / 2.8,
                                    child: MenuCard(
                                      text: string.text("about"),
                                      onTap: () async {
                                        Get.toNamed('/settings/about');
                                      },
                                      icon: Icons.assignment_ind,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: Get.width / 1.4,
                            child: MenuCard(
                              text: string.text("update_data"),
                              onTap: () {
                                conf.updateData(false);
                              },
                              icon: Icons.system_update_alt,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

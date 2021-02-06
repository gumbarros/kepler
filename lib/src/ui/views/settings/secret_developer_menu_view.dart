import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:kepler/src/controllers/settings/settings_controller.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/menu_card.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/snackbars/snackbars.dart';
import 'package:url_launcher/url_launcher.dart';

class SecretDeveloperMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (conf) => Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Header("secret_developer_menu".tr, () {
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
                                      text: "clear_app_data".tr,
                                      onTap: () async {
                                        final GetStorage getStorage = GetStorage();
                                        await getStorage.erase();
                                        Hive.deleteFromDisk();
                                        await KeplerDatabase.db.dropTable().then((_){
                                          Snackbars.snackbar(title: "data_cleared".tr, text: "all_data_deleted".tr);
                                        });

                                      },
                                      icon: Icons.delete_forever,
                                    )),
                                Container(
                                  width: Get.width / 2.8,
                                  child: Container(
                                      width: Get.width / 2.8,
                                      child: MenuCard(
                                        text: "nice_easter_egg_here".tr,
                                        onTap: () async {
                                         launch("https://steamcommunity.com/id/beachthanos");
                                        },
                                        icon: Icons.android,
                                      )),
                                )
                              ],
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
    );
  }
}

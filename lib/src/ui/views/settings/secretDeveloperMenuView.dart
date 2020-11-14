import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/src/controllers/settingsController.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/menuCard.dart';
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
                    Header(string.text("secret_developer_menu"), () {
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
                                      text: string.text("clear_app_data"),
                                      onTap: () async {
                                        final GetStorage getStorage = GetStorage();
                                        await getStorage.erase();
                                        await KeplerDatabase.db.dropTable().then((_){
                                          Snackbars.snackbar(title: string.text("data_cleared"), text: string.text("all_data_deleted"));
                                        });

                                      },
                                      icon: Icons.delete_forever,
                                    )),
                                Container(
                                  width: Get.width / 2.8,
                                  child: Container(
                                      width: Get.width / 2.8,
                                      child: MenuCard(
                                        text: string.text("nice_easter_egg_here"),
                                        onTap: () async {
                                         launch("https://www.youtube.com/watch?v=Wl959QnD3lM");
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

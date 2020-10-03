import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/widgets/cards/menuCard.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/snackbars/snackbars.dart';

class SecretDeveloperMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (conf) => Scaffold(
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Header("Secret Developer Menu", () {
                  Navigator.of(context).pop(context);
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
                                  text: "Clear App Data",
                                  onTap: () async {
                                    final GetStorage getStorage = GetStorage();
                                    await getStorage.erase();
                                    await KeplerDatabase.db.dropTable().then((_){
                                      Snackbars.snackbar(title: "Data cleared", text: "All app data is deleted");
                                    });

                                  },
                                  icon: Icons.delete_forever,
                                )),
                            Container(
                              width: Get.width / 2.8,
                              child: Container(
                                  width: Get.width / 2.8,
                                  child: MenuCard(
                                    text: "Nice Easter Egg Here",
                                    onTap: () async {
                                     Snackbars.development();
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
    );
  }
}

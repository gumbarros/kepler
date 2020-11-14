import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/homeController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/imageCard.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (home) => Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                         Get.toNamed('/settings');
                        }),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                string.text("app_title"),
                                style: TextStyle(fontSize: 60),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                string.text("discover_the_universe"),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 15,
                      ),
                      ColorsCard(
                        onTap: () =>
                            Get.toNamed('/stars'),
                        text: string.text("explore"),
                        colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // ColorsCard(
                      //   onTap: () =>
                      //       Navigator.of(context).push(route(ChartsView())),
                      //   text: string.text("charts"),
                      //   colorList: [Color(0XFFFFDA085), Color(0xFFFF6D365)],
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () =>
                       Get.toNamed('/favorites'),
                        text: string.text("favourites"),
                        colorList: [Color(0xFFFA18CD1), Color(0XFFFFBC2EB)],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () =>
                            Get.toNamed('/dailyImage'),
                        text: string.text("nasa_image"),
                        colorList: [
                          Colors.lightGreen,
                          Colors.green,
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

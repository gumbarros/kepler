import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/home/home_controller.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/image_card.dart';

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
                                "app_title".tr,
                                style: TextStyle(fontSize: 60),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "discover_the_universe".tr,
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
                        onTap: () => Get.toNamed('/stars'),
                        text: "explore".tr,
                        colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // ColorsCard(
                      //   onTap: () =>
                      //       Navigator.of(context).push(route(ChartsView())),
                      //   text: "charts".tr,
                      //   colorList: [Color(0XFFFFDA085), Color(0xFFFF6D365)],
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () => Get.toNamed('/favorites'),
                        text: "favourites".tr,
                        colorList: [Color(0xFFFA18CD1), Color(0XFFFFBC2EB)],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () => Get.toNamed('/mars/rovers'),
                        text: "mars".tr,
                        colorList: [
                          Colors.redAccent,
                          Colors.deepOrangeAccent,
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () => Get.toNamed('/dailyImage'),
                        text: "nasa_image".tr,
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

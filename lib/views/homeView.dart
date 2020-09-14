import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/testView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/cards/menuCard.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.toNamed('/views', arguments: 2);
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          string.text("app_title"),
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Cabin',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 7,
                  ),
                  Column(
                    children: [
                      MenuCard(
                        onTap: () => Get.toNamed('/views', arguments: 0),
                        text: string.text("explore"),
                        colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                        child: SizedBox(),
                        height: Get.height / 8,
                        width: Get.width - 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MenuCard(
                        onTap: () => Get.toNamed('/views', arguments: 1),
                        text: string.text("charts"),
                        colorList: [Color(0XFFFFDA085), Color(0xFFFF6D365)],
                        child: SizedBox(),
                        height: Get.height / 8,
                        width: Get.width - 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MenuCard(
                        onTap: () => Get.to(TestView()),
                        text: "Test View",
                        colorList: [Color(0xFFFA18CD1), Color(0XFFFFBC2EB)],
                        child: SizedBox(),
                        height: Get.height / 8,
                        width: Get.width - 20,
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}

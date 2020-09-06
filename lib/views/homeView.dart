import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/widgets/cards/menuCard.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      Get.toNamed('/settings');
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
                        string.text("app_title"),
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
                Column(
                  children: [
                    MenuCard(
                      onTap: () => Get.toNamed('/planets'),
                      text: string.text("planets"),
                      colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MenuCard(
                        onTap: () => Get.toNamed('/graphics'),
                        text: string.text("graphics"), //Explore Data?
                        colorList: [Color(0xFFF30CFD0), Color(0XFFF330867)]),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ],
    );
  }
}

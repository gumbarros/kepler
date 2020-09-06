import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/backgrounds/homeBackground.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/graphicsView.dart';
import 'package:kepler/views/planetsView.dart';
import 'package:kepler/widgets/cards/menuCard.dart';

class Home extends StatelessWidget {
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
                          fontSize: 60,
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
                      onTap: () =>
                          Navigator.of(context).push(_planetPageRoute(PlanetView())),
                      text: string.text("planets"),
                      colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MenuCard(
                        onTap: () =>
                            Navigator.of(context).push(_planetPageRoute(GraphicsView())),
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

Route _planetPageRoute(Widget child) {
  return CupertinoPageRoute(builder: (context) => child);
}

class Something extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: Get.height / 5,
            width: Get.width / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(360),
            )),
          )
        ],
      ),
    );
  }
}

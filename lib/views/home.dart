import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/views/planetView.dart';
import 'package:kepler/widgets/cards/menuCard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
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
                        'Kepler',
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
                        onTap: () => Navigator.of(context).push(_planetPageRoute()),
                        text: "Planet View"),
                    SizedBox(
                      height: 30,
                    ),
                    MenuCard(
                        onTap: () => Navigator.of(context).push(_planetPageRoute()),
                        text: "Graphics View"),
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

Route _planetPageRoute() {
  return CupertinoPageRoute(builder: (context) => PlanetView());
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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

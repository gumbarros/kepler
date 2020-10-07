import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/utils/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/dailyImage/dailyImageView.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/favorites/favoritesView.dart';
import 'package:kepler/views/settings/settingsView.dart';
import 'package:kepler/widgets/backgrounds/background.dart';
import 'package:kepler/widgets/cards/imageCard.dart';
import '../charts/chartsView.dart';

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
                          Navigator.of(context).push(route(SettingsView()));
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
                            Navigator.of(context).push(route(StarsView())),
                        text: string.text("explore"),
                        colorList: [Color(0xFFF667EEA), Color(0xFFF764BA2)],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () =>
                            Navigator.of(context).push(route(ChartsView())),
                        text: string.text("charts"),
                        colorList: [Color(0XFFFFDA085), Color(0xFFFF6D365)],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () =>
                            Navigator.of(context).push(route(FavoritesView())),
                        text: string.text("favourites"),
                        colorList: [Color(0xFFFA18CD1), Color(0XFFFFBC2EB)],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ColorsCard(
                        onTap: () =>
                            Navigator.of(context).push(route(DailyImageView())),
                        text: "Nasa Image of The Day",
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

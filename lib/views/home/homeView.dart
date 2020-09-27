import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/favorites/favoritesView.dart';
import 'package:kepler/views/settings/settingsView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/cards/imageCard.dart';
import '../charts/chartsView.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (home) => Stack(
        children: [
          HomeBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: ListView(
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
                      ImageCard(
                        onTap: () {
                          Navigator.of(context).push(route(StarsView()));
                        },
                        text: string.text("explore"),
                        image: 'assets/images/explorebg.png',
                      ),
                      SizedBox(
                        height: Get.height / 20,
                      ),
                      ImageCard(
                        onTap: () {
                          Navigator.of(context).push(route(ChartsView()));
                        },
                        text: string.text("charts"),
                        image: 'assets/images/chartsbg.png',
                      ),
                      SizedBox(
                        height: Get.height / 20,
                      ),
                      ImageCard(
                        onTap: () {
                          Navigator.of(context).push(route(FavoritesView()));
                        },
                        text: string.text("favourites"),
                        image: 'assets/images/favouritesbg.jpg',
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

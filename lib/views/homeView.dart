import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/homeController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/views/favoritesView.dart';
import 'package:kepler/views/settingsView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/cards/imageCard.dart';
import 'package:kepler/widgets/snackbars/snackbars.dart';

import 'chartsView.dart';

class HomeView extends StatelessWidget {
  // Animation _scaleanimation;
  // AnimationController _scalecontroller;
  //
  // void initState() {
  //   _scalecontroller =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  //   _scaleanimation = Tween<double>(
  //     begin: 1,
  //     end: 0.97,
  //   ).animate(
  //     _scalecontroller,
  //   );
  //   super.initState();
  // }

  // If animation it's not used, let's use Stateless Widgets for better performance

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
                          Snackbars.development();
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

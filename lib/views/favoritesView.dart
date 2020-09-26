import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/header/header.dart';


class FavoritesView extends StatelessWidget{

  final RxDouble position = 0.0.obs;

  final List<PlanetData> planets = FavoritesController.to.getAllPlanets();

  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      initState: (state){
        scrollController.addListener(() {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
              position.value >= -Get.height / 2) {
            position.value -= 30;


          } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
              position.value <= -10) {
            position.value += 30;
            if (scrollController.offset == 0) {
              position.value = 0;
            }
          }
        });
      },
      dispose: (state) {
        scrollController.dispose();
      },
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  child: Header(
                      string.text("favourites"), () => Navigator.pop(context)),
                ),
              ],
            ),
            Container(
              width: Get.width,
              height: Get.height,
              child: ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: planets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Visibility(
                        visible: !index.isEqual(0),
                        replacement: Column(
                          children: [
                            Center(
                              child: PlanetCard(
                                  width: Get.width - 20,
                                  height: Get.height / 5,
                                  text: planets[index].planetName,
                                  onTap: () => Navigator.of(context)
                                          .push(route(PlanetView(
                                        planets[index],
                                      ))),
                                  child: SizedBox()),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: PlanetCard(
                                  width: Get.width - 20,
                                  height: Get.height / 5,
                                  text: planets[index].planetName,
                                  onTap: () => Navigator.of(context)
                                          .push(route(PlanetView(
                                        PlanetData(),
                                      ))),
                                  child: SizedBox()),
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

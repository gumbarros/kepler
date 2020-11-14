import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/favoritesController.dart';
import 'package:kepler/src/controllers/planetController.dart';
import 'package:kepler/src/controllers/solarSystemController.dart';
import 'package:kepler/src/models/starData.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/planetCard.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/universe/gasPlanet.dart';
import 'package:kepler/src/ui/widgets/universe/smallPlanet.dart';
import 'package:kepler/src/ui/widgets/universe/star.dart';
import 'package:kepler/src/ui/widgets/progress/loading.dart';

class SolarSystemView extends StatelessWidget {

  final ScrollController scrollController = new ScrollController();
  final RxDouble position = 0.0.obs;

  final StarData star = Get.arguments[1];
  final int index = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    Get.put(PlanetController());
    return Container(
      width: Get.width,
      child: GetBuilder<SolarSystemController>(
        init: new SolarSystemController(),
        dispose: (state) {
          scrollController.dispose();
        },
        initState: (state) {
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
        builder: (_) => Stack(
          children: [
            Background(),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomPadding: false,
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Header(string.currentLanguage == "br" /*Add your language here if system sounds strange with the star name*/? star.name :  star.name + string.text("system"),
                            () => Get.back(canPop: true)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Hero(
                          tag: 'star$index',
                          child: Star(
                            temperature: star.temperature,
                            size: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${string.text("temperature")}: ${star.temperature.isNull || star.temperature == 0.0 ? string.text("unknown") : star.temperature.toString() + " K"}",
                          style: KeplerTheme.theme.textTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${string.text("mass")}: ${star.mass.isNull || star.mass == 0.0 ? string.text("unknown") : star.mass.toString() + string.text("solar_mass")}",
                          style: KeplerTheme.theme.textTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${string.text("radius")}: ${star.radius.isNull || star.radius == 0.0 ? string.text("unknown") : star.radius.toString() + string.text("solar_radius")}",
                          style: KeplerTheme.theme.textTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${string.text("age")}: ${star.age.isNull || star.age == 0.0 ? string.text("unknown") : star.age.toString() + string.text("million_years")}",
                          style: KeplerTheme.theme.textTheme.caption,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  GetBuilder<FavoritesController>(
                      init: FavoritesController(),
                      builder: (_) => Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              iconSize: 32.0,
                              icon: _.getFavorite(star.name).isNull
                                  ? Icon(Icons.star_border)
                                  : Icon(Icons.star),
                              onPressed: () {
                                if (_.getFavorite(star.name).isNull) {
                                  _.setFavorite(star);
                                } else {
                                  _.removeFavorite(star.name);
                                }
                                _.update();
                              },
                            ),
                          )),
                  FutureBuilder<List<PlanetData>>(
                    future: KeplerDatabase.db.getSolarSystemPlanets(star.name),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PlanetData>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return Center(child: Loading());
                        default:
                          if (snapshot.data.isNull) {
                            return Column(
                              children: [
                                Center(
                                  child: Text(
                                    string.text("no_planet"),
                                    style: KeplerTheme.theme.textTheme.caption,
                                  ),
                                ),
                              ],
                            );
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        child: PlanetCard(
                                          width: Get.width - Get.width / 4,
                                          height: Get.height / 5,
                                          text:
                                              "${snapshot.data[index].planetName}",
                                          onTap: () => Get.toNamed('/planet',arguments:[index,snapshot.data[index]]),
                                          child: PlanetController.to
                                                      .getPlanetsColor(snapshot
                                                          .data[index].bmvj) ==
                                                  Colors.yellow[100]
                                              ? GasPlanet(
                                            snapshot.data[index].id,
                                                  index: index,
                                                  color: PlanetController.to
                                                      .getPlanetsColor(snapshot
                                                          .data[index].bmvj),
                                                  size: 100,
                                                )
                                              : SmallPlanet(
                                                  snapshot.data[index].id,
                                                  index: index,
                                                  color: PlanetController.to
                                                      .getPlanetsColor(snapshot
                                                          .data[index].bmvj),
                                                  size: 100,
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                  ],
                                );
                              });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

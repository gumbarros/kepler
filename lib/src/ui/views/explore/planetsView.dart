import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/src/controllers/favorites/favoritesController.dart';
import 'package:kepler/src/controllers/explore/planetController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/universe/gasPlanet.dart';
import 'package:kepler/src/ui/widgets/universe/smallPlanet.dart';

class PlanetView extends StatelessWidget {
  final PlanetData planet = Get.arguments[1];
  final int index = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanetController>(
        init: new PlanetController(),
        builder: (_) => Stack(
          children: [
            Background(),
            Scaffold(
              backgroundColor: Colors.transparent,
                  resizeToAvoidBottomPadding: false,
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Column(children: [
                        Column(
                          children: [
                            Container(
                                color: Colors.transparent,
                                child: Header(
                                  planet.planetName ?? "",
                                  () => Get.back(canPop: true),
                                )),
                          ],
                        ),
                        PlanetController.to
                            .getPlanetsColor(planet.bmvj) ==
                            Colors.yellow[100]
                            ? GasPlanet(
                          planet.planetName,
                          index: index,
                          color: PlanetController.to
                              .getPlanetsColor(planet.bmvj),
                          size: 200,
                        )
                            : SmallPlanet(
                          planet.planetName,
                          index: index,
                          color: PlanetController.to
                              .getPlanetsColor(planet.bmvj),
                          size: 200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${string.text("star")}: ${planet.star}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${string.text("orbital_period")}: ${planet.orbitalPeriod.isNullOrBlank || planet.orbitalPeriod == 0.0 ? "Unknown" : planet.orbitalPeriod.truncate().toString() + string.text("days")}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${string.text("mass")}: ${planet.jupiterMass.isNull ? string.text("unknown") : planet.jupiterMass.toString() + string.text("jupiter")} ",
                                      style: KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${string.text("density")}: ${planet.density.isNull ? string.text("unknown") : planet.density.toString() + ' g/cm³'}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${string.text("radius")}: ${planet.radius.isNull ? string.text("unknown") : planet.radius.toString() + string.text("jupiter_radius")} ",
                                      style: KeplerTheme.theme.textTheme.caption),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<FavoritesController>(
                            init: FavoritesController(),
                            builder: (_) => Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    iconSize: 32.0,
                                    icon: _.getFavorite(planet.planetName).isNull
                                        ? Icon(Icons.star_border)
                                        : Icon(Icons.star),
                                    onPressed: () {
                                      if (_.getFavorite(planet.planetName).isNull) {
                                        _.setFavorite(planet);
                                      } else {
                                        _.removeFavorite(planet.planetName);
                                      }
                                      _.update();
                                    },
                                  ),
                                )),
                      ]),
                    ],
                  ),
                ),
          ],
        ));
  }
}

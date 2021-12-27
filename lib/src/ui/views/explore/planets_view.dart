import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/src/controllers/explore/planet_controller.dart';
import 'package:kepler/src/controllers/favorites/favorites_controller.dart';
import 'package:kepler/src/models/planet_data.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/universe/gas_planet.dart';
import 'package:kepler/src/ui/widgets/universe/small_planet.dart';

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
                  resizeToAvoidBottomInset: false,
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
                                  Text("${"star".tr}: ${planet.star}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${"orbital_period".tr}: ${planet.orbitalPeriod == null || planet.orbitalPeriod == 0.0 ? "Unknown" : planet.orbitalPeriod.truncate().toString() + "days".tr}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${"mass".tr}: ${planet.jupiterMass == null ? "unknown".tr : planet.jupiterMass.toString() + "jupiter".tr} ",
                                      style: KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${"density".tr}: ${planet.density == null ? "unknown".tr : planet.density.toString() + ' g/cm³'}",
                                      style:  KeplerTheme.theme.textTheme.caption),
                                  Text(
                                      "${"radius".tr}: ${planet.radius == null ? "unknown".tr : planet.radius.toString() +"jupiter_radius".tr} ",
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

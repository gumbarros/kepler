import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/header/header.dart';

import 'package:kepler/widgets/planets/smallPlanet.dart';

class PlanetView extends StatelessWidget {
  final PlanetData planet;

  PlanetView(this.planet);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanetController>(
        init: new PlanetController(),
        builder: (_) => Scaffold(
            resizeToAvoidBottomPadding: false,
            body: //Stack(children: [
                ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        //Using temporary color
                        Container(
                            color: Theme.of(context).dialogBackgroundColor,
                            child: Header(
                              planet.planetName,
                              () => Navigator.pop(context),
                            )),
                      ],
                    ),
                    SmallPlanet(
                      color: PlanetController.to.getPlanetsColor(planet.jmk2),
                    ),
                    // MediumPlanet(
                    //   color: PlanetController.to.getPlanetsColor(planet.jmk2),
                    // ),
                    //Why 2 planets?
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
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 18.5)),
                              Text(
                                  "${string.text("orbital_period")}: ${planet.orbitalPeriod.isNull ? "Unknown" : planet.orbitalPeriod.truncate()} ${string.text("days")}",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 18.5)),
                              Text(
                                  "${string.text("mass")}: ${planet.jupiterMass.isNull ? string.text("unknown") : planet.jupiterMass.toString() + string.text("jupiter")} ",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 18.5)),
                              Text(
                                  "${string.text("density")}: ${planet.density.isNull ? string.text("unknown") : planet.density.toString() + ' g/cm³'}",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 18.5)),
                              Text(
                                  "${string.text("radius")}: ${planet.radius.isNull ? string.text("unknown") : planet.radius.toString() + string.text("jupiter_radius")} ",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 18.5)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}

// GetBuilder<FavoritesController>(
//   builder: (_) => Align(
//     alignment: Alignment.bottomRight,
//     child: IconButton(
//       iconSize: 32.0,
//       icon: _.getPlanet(planetName).isNull
//           ? Icon(Icons.star_border)
//           : Icon(Icons.star),
//       onPressed: () {
//         if (_.getPlanet(planetName).isNull) {
//           _.savePlanet(planetName);
//         } else {
//           _.removePlanet(planetName);
//         }
//         _.update();
//         print(_.getPlanet(planetName));
//       },
//     ),
//   ),
// ),
//]),

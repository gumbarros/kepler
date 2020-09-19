import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:kepler/widgets/planets/smallPlanet.dart';

class PlanetView extends StatelessWidget {
  final String planetName;

  PlanetView({@required this.planetName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanetController>(
      init: new PlanetController(),
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: //Stack(children: [
          FutureBuilder<PlanetData>(
            future: API.getPlanetByName(planetName),
            builder:
                (BuildContext context, AsyncSnapshot<PlanetData> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return ListView(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              //Using temporary color
                              Container(
                                  color: Theme.of(context).dialogBackgroundColor,
                                  child: Header(
                                    planetName, //TODO: i18n
                                        () => Navigator.pop(context),
                                  )),
                            ],
                          ),
                          SmallPlanet(
                            color: PlanetController.to
                                .getPlanetsColor(snapshot.data.jmk2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey.withOpacity(0.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${string.text("star")}: ${snapshot.data.star}",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 18.5)),
                                    Text(
                                        "${string.text("orbital_period")}: ${snapshot.data.orbitalPeriod.isNull ? "Unknown" : snapshot.data.orbitalPeriod.truncate()} ${string.text("days")}",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 18.5)),
                                    Text(
                                        "${string.text("mass")}: ${snapshot.data.jupiterMass.isNull ? string.text("unknown") : snapshot.data.jupiterMass.toString() + string.text("jupiter")} ",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 18.5)),
                                    Text(
                                        "${string.text("density")}: ${snapshot.data.density.isNull ? string.text("unknown") : snapshot.data.density.toString() + ' g/cm³'}",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 18.5)),
                                    Text(
                                        "${string.text("radius")}: ${snapshot.data.radius.isNull ?
                                        string.text("unknown"): snapshot.data.radius.toString() + string.text("jupiter_radius")} ",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 18.5)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                default:
                  return Center(child: Loading());
              }
            },
          ),



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
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/pagesController.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class PlanetView extends StatelessWidget {
  final String planetName;
  PlanetView({@required this.planetName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanetController>(
      init: new PlanetController(),
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<PlanetData>(
              future: API.getPlanetByName(planetName),
              builder: (BuildContext context, AsyncSnapshot<PlanetData> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Container(
                      width: Get.width,
                      height: Get.height / 1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${string.text("star")}: ${snapshot.data.star}",
                              style: TextStyle(fontFamily: "Roboto", fontSize: 18.5)),
                          Text(
                              "${string.text("orbital_period")}: ${snapshot.data.orbitalPeriod.isNull ? "Unknown" : snapshot.data.orbitalPeriod.truncate()} ${string.text("days")}",
                              style: TextStyle(fontFamily: "Roboto", fontSize: 18.5)),
                          Text(
                              "${string.text("mass")}: ${snapshot.data.jupiterMass.isNull ? 'Unknown' : snapshot.data.jupiterMass.toString() + ' Jupiter'} ",
                              style: TextStyle(fontFamily: "Roboto", fontSize: 18.5)),
                          Text(
                              "${string.text("density")}: ${snapshot.data.density.isNull ? 'Unknown' : snapshot.data.density.toString() + '  g/cm³'}",
                              style: TextStyle(fontFamily: "Roboto", fontSize: 18.5)),
                          Text(
                              "${string.text("radius")}: ${snapshot.data.radius.isNull ? 'Unknown' : snapshot.data.radius.toString() + string.text("jupiter_radius")} ",
                              style: TextStyle(fontFamily: "Roboto", fontSize: 18.5)),
                        ],
                      ),
                    );
                  default:
                    return Center(child: Loading());
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height / 10,
              width: Get.width,
              child: Column(
                children: [
                  //Using temporary color
                  Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Header(
                        planetName, //TODO: i18n
                        () => PagesController.to.changeView(StarsView())),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<FavoritesController>(
            builder: (_) => Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                iconSize: 32.0,
                icon: _.getPlanet(planetName).isNull
                    ? Icon(Icons.star_border)
                    : Icon(Icons.star),
                onPressed: () {
                  if (_.getPlanet(planetName).isNull) {
                    _.savePlanet(planetName);
                    print('ei');
                  } else {
                    _.removePlanet(planetName);
                  }
                  _.update();
                  print(_.getPlanet(planetName));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

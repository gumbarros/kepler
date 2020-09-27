import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/controllers/solarSystemController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/universe/smallPlanet.dart';
import 'package:kepler/widgets/universe/star.dart';
import 'package:kepler/widgets/progress/loading.dart';

class SolarSystemView extends StatelessWidget {
  final StarData star;
  final int index;

  SolarSystemView({@required this.star, @required this.index});

  final ScrollController scrollController = new ScrollController();
  final RxDouble position = 0.0.obs;

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
        builder: (_) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Header(star.name + string.text("system"),
                        () => Navigator.pop(context)),
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
                        "Mass: ${star.mass.isNullOrBlank || star.mass == 0.0 ? "Unknown" : star.mass.toString() + " Solar Mass"}",
                        style: TextStyle(fontFamily: "Roboto", fontSize: 18.5), textAlign: TextAlign.center,),
                    Text(
                      "Radius: ${star.radius.isNullOrBlank || star.radius == 0.0 ? "Unknown" : star.radius.toString() + " Solar Radius"}",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 18.5), textAlign: TextAlign.center,),
                    Text(
                      "Age: ${star.age.isNullOrBlank || star.age == 0.0 ? "Unknown" : star.age.toString() + " Milion Years"}",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 18.5), textAlign: TextAlign.center,)
                  ],
                ),
              ),
              GetBuilder<FavoritesController>(
                  init: FavoritesController(),
                  builder: (_) => Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      iconSize: 32.0,
                      icon: _.getFavorite(star.name) == null
                          ? Icon(Icons.star_border)
                          : Icon(Icons.star),
                      onPressed: () {
                        if (_.getFavorite(star.name) == null) {
                          _.saveFavorite(star);
                        } else {
                          _.removeFavorite(star.name);
                        }
                        _.update();
                      },
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 30.0),
                width: Get.width,
                height: Get.height,
                child: FutureBuilder<List<PlanetData>>(
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
                                  style: TextStyle(fontFamily: "Roboto"),
                                ),
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Visibility(
                                  visible: !index.isEqual(0),
                                  replacement: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: PlanetCard(
                                            width: Get.width - Get.width / 4,
                                            height: Get.height / 5,
                                            text:
                                                "${snapshot.data[index].planetName}",
                                            onTap: () => Navigator.of(context)
                                                .push(route(PlanetView(
                                              snapshot.data[index],
                                              index: index,
                                            ))),
                                            child: SmallPlanet(
                                              index: index,
                                              color: PlanetController.to
                                                  .getPlanetsColor(
                                                      snapshot.data[index].bmvj),
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: PlanetCard(
                                              width: Get.width - Get.width / 4,
                                              height: Get.height / 5,
                                              text:
                                                  "${snapshot.data[index].planetName}",
                                              onTap: () => Navigator.of(context)
                                                      .push(route(PlanetView(
                                                    snapshot.data[index],
                                                    index: index,
                                                  ))),
                                              child: SmallPlanet(
                                                index: index,
                                                color: PlanetController.to
                                                    .getPlanetsColor(snapshot
                                                        .data[index].bmvj),
                                                size: 100,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

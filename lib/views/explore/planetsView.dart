import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/models/planetData.dart';
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
              builder:
                  (BuildContext context, AsyncSnapshot<PlanetData> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.data.isNull) {
                      return Center(
                        child: Text(
                          "No data found", //TODO: i18n
                          style: TextStyle(fontFamily: "Roboto"),
                        ),
                      );
                    }
                    Color color =
                        PlanetController.to.getPlanetsColor(snapshot.data.jmk2);
                    print(snapshot.data.jmk2);
                    return Column(
                      children: [
                        SizedBox(
                          height: Get.height / 4,
                        ),
                        PlanetsCard(
                          color: color,
                        ),
                      ],
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
                        Get.back),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class PlanetsCard extends StatelessWidget {
  final Color color;

  PlanetsCard({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(360),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 65,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  right: 15,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 70,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 40,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

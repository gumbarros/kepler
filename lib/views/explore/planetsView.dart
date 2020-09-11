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
              builder: (BuildContext context, AsyncSnapshot<PlanetData> snapshot) {
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
                    return Center(
                      child: Text(
                        snapshot.data.planetName + " data is inside this object",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                      Get.back
                    ),
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

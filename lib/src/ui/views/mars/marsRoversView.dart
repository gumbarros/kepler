import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/mars/marsRoversController.dart';
import 'package:kepler/src/controllers/starsController.dart';
import 'package:kepler/src/locale/translations.dart';
import 'package:kepler/src/models/roverData.dart';
import 'package:kepler/src/services/api/api.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/imageCard.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';
import 'package:kepler/src/ui/widgets/progress/loading.dart';

class MarsRoversView extends StatelessWidget {
  final position = 0.0.obs;
  final ScrollController scrollController = new ScrollController();

  Widget build(BuildContext context) {
    return GetBuilder<MarsRoversController>(
      init: new MarsRoversController(),
      builder: (_) => Stack(children: [
        Background(),
        Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: [
                Container(
                    color: Colors.transparent,
                    child: Header(string.text("rovers"), () {
                      Get.back(canPop: true);
                    })),
                FutureBuilder(
                    future: API.getMarsRovers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<RoverData>> snapshot) {
                      switch (snapshot.connectionState) {
                        case (ConnectionState.waiting):
                        case (ConnectionState.active):
                          return Center(
                            child: Loading(),
                          );
                        default:
                          if (snapshot.data.isNull) {
                            return Center(
                              child: Text(
                                string.text("no_stars"),
                                style: TextStyle(fontFamily: "Roboto"),
                              ),
                            );
                          }
                          if (snapshot.data.length.isEqual(0)) {
                            return Center(
                              child: Text(
                                string.text("no_stars"),
                                style: TextStyle(fontFamily: "Roboto"),
                              ),
                            );
                          }
                          return ListView.builder(
                              controller: scrollController,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                                                          margin: index.isEqual(0)
                                            ? EdgeInsets.only(
                                                top: Get.height / 3.5)
                                            : null,
                                    child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ColorsCard(
                                            text: snapshot.data[index].name,
                                            colorList: [
                                              Colors.grey,
                                              Colors.blueGrey
                                            ],
                                            onTap: () => Get.toNamed(
                                                    '/solarSystem',
                                                    arguments: [
                                                      index,
                                                      snapshot.data[index]
                                                    ]))));
                              });
                      }
                    })
              ],
            ))
      ]),
    );
  }
}

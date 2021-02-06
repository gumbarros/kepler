import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/mars/mars_rovers_controller.dart';
import 'package:kepler/src/models/rover_data.dart';
import 'package:kepler/src/services/api/api.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/image_card.dart';
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
                    child: Header("rovers".tr, (){
                      Get.toNamed('/home');
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
                                "server_error".tr,
                                style: KeplerTheme.theme.textTheme.caption,
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
                                                    '/mars',
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

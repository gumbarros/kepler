import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/controllers/solarSystemController.dart';
import 'package:kepler/cupertinopageroute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/planetCard.dart';

import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/planets/star.dart';
import 'package:kepler/widgets/progress/loading.dart';

class SolarSystemView extends StatefulWidget {
  final String star;
  final double starTemp;
  final int index;

  SolarSystemView(
      {@required this.star, @required this.starTemp, @required this.index});

  @override
  _SolarSystemViewState createState() => _SolarSystemViewState();
}

class _SolarSystemViewState extends State<SolarSystemView> {
  ScrollController _scrollController;
  bool gap = true;
  int gapNumber;
  ScrollController scrollController;
  RxDouble position = 0.0.obs;

  changeMinus() {
    position.value -= 7;
  }

  changePlus() {
    position.value += 7;
  }

  changeZero() {
    position.value = 0;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          position.value >= -Get.height / 2) {
        changeMinus();
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          position.value <= -10) {
        changePlus();
        if (_scrollController.offset == 0) {
          changeZero();
        }
      }
    });
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.star);
    return GetBuilder<SolarSystemController>(
      init: new SolarSystemController(),
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<List<PlanetData>>(
              future: API.getSolarSystemPlanets(widget.star),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PlanetData>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
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
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Visibility(
                              visible: !index.isEqual(0),
                              replacement: Column(
                                children: [
                                  SizedBox(height: Get.height / 2 + 20),
                                  Center(
                                    child: PlanetCard(
                                        width: Get.width - 20,
                                        height: Get.height / 5,
                                        text:
                                            "${snapshot.data[index].planetName}",
                                        onTap: () => Navigator.of(context)
                                                .push(route(PlanetView(
                                              planetName: snapshot
                                                  .data[index].planetName,
                                            ))),
                                        child: SizedBox()),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: PlanetCard(
                                          width: Get.width - 20,
                                          height: Get.height / 5,
                                          text:
                                              "${snapshot.data[index].planetName}",
                                          onTap: () => Navigator.of(context)
                                                  .push(route(PlanetView(
                                                planetName: snapshot
                                                    .data[index].planetName,
                                              ))),
                                          child: SizedBox()),

                                  ),
                                ],
                              ));
                        });
                  default:
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Loading(),
                    ));
                }
              },
            ),
          ),
          Obx(
            () => Positioned(
              top: position.value,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Get.height / 10,
                width: Get.width,
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).dialogBackgroundColor,
                      child: Header(
                          widget.star + string.text("system"),
                          //TODO: i18n
                          () => Navigator.pop(context)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Hero(
                            tag: '${widget.index}',
                            child: Star(temperature: widget.starTemp))),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

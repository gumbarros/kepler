import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/solarSystemController.dart';
import 'package:kepler/controllers/systemHeaderController.dart';
import 'package:kepler/cupertinopageroute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/imageCard.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class SolarSystemView extends StatefulWidget {
  final String star;

  SolarSystemView({@required this.star});

  @override
  _SolarSystemViewState createState() => _SolarSystemViewState();
}

class _SolarSystemViewState extends State<SolarSystemView> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          SystemHeaderController.to.position.value >= -Get.height / 2) {
        SystemHeaderController.to.changeMinus();
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          SystemHeaderController.to.position.value <= -10) {
        SystemHeaderController.to.changePlus();
        if (_scrollController.offset == 0) {
          SystemHeaderController.to.changeZero();
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
                      return Center(
                        child: Text(
                          string.text("no_planet"),
                          style: TextStyle(fontFamily: "Roboto"),
                        ),
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
                                  SizedBox(height: Get.height / 3 + 20),
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
                    return Center(child: Loading());
                }
              },
            ),
          ),
          Obx(
            () => Positioned(
              top: SystemHeaderController.to.position.value,
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
                      //TODO: Change the colour accordingly to the theme
                      child: Header(
                          widget.star + " System", //TODO: i18n
                          () => Navigator.pop(context)),
                    ),
                    Container(
                      color: Theme.of(context).dialogBackgroundColor,
                      //TODO: Change the colour accordingly to the theme
                      width: Get.width,
                      child: SearchBar(
                        searchFunc: (String value) {
                          _.search.value = value;
                          _.upd();
                        },
                      ),
                    ),
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

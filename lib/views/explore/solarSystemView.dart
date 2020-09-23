import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/solarSystemController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/planets/star.dart';
import 'package:kepler/widgets/progress/loading.dart';
import '../../database/database.dart';
import '../../database/database.dart';

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
  ScrollController scrollController;
  RxDouble position = 0.0.obs;


  void changeMinus() {
    position.value -= 30;
  }

  void changePlus() {
    position.value += 30;
  }

  void changeZero() {
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
    print(KeplerDatabase.db.getSolarSystemPlanets(widget.star));
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
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
                    child: Star(
                      temperature: widget.starTemp,
                      size: 200,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: Get.width,
              height: Get.height,
              child: FutureBuilder<List<PlanetData>>(
                future: KeplerDatabase.db.getSolarSystemPlanets(widget.star),
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
                                    Center(
                                      child: PlanetCard(
                                          width: Get.width - 20,
                                          height: Get.height / 5,
                                          text:
                                              "${snapshot.data[index].planetName}",
                                          onTap: () => Navigator.of(context)
                                                  .push(route(PlanetView(
                                                snapshot.data[index],
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
                                                snapshot
                                                    .data[index],
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
                                )
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

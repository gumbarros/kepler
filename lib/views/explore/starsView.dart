import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/starHeaderController.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/cupertinopageroute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/views/explore/solarSystemView.dart';
import 'package:kepler/widgets/cards/starCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class StarsView extends StatefulWidget {
  @override
  _StarsViewState createState() => _StarsViewState();
}

class _StarsViewState extends State<StarsView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController fadeController;
  Animation fadeAnimation;
  AnimationController scaleController;
  Animation scaleAnimation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(fadeController);
    fadeController.forward();
    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(scaleController);
    scaleController.forward();
    StarHeaderController.to.scrollController = ScrollController();
    StarHeaderController.to.scrollController.addListener(() {
      if (StarHeaderController
                  .to.scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          StarHeaderController.to.position.value >= -Get.height / 2) {
        StarHeaderController.to.changeMinus();
      } else if (StarHeaderController
                  .to.scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          StarHeaderController.to.position.value <= -10) {
        StarHeaderController.to.changePlus();
        if (StarHeaderController.to.scrollController.offset == 0) {
          StarHeaderController.to.changeZero();
        }
      }
    });
    super.initState();
  }

  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    StarHeaderController.to.scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: GetBuilder<StarsController>(
          init: new StarsController(),
          builder: (_) => Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(children: [
              Container(
                width: Get.width,
                height: Get.height,
                child: FutureBuilder<List<StarData>>(
                  future: API.getAllStars(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<StarData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.data.isNull) {
                          return Center(
                            child: Text(
                              "No stars found", //TODO: i18n
                              style: TextStyle(fontFamily: "Roboto"),
                            ),
                          );
                        }
                        return LiquidPullToRefresh(
                          onRefresh: () async => _.update(),
                          color: Theme.of(context).dialogBackgroundColor,
                          child: ListView.builder(
                              controller:
                                  StarHeaderController.to.scrollController,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  visible: !index.isEqual(0),
                                  replacement: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height / 3.5 - 10,
                                      ),
                                      Hero(
                                        tag: "$index",
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: StarCard(
                                            text: snapshot.data[index].name,
                                            temperature: snapshot
                                                .data[index].temperature,
                                            onTap: () => Navigator.of(context)
                                                .push(route(SolarSystemView(
                                              index: index,
                                              starTemp: snapshot
                                                  .data[index].temperature,
                                              star: snapshot.data[index].name,
                                            ))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Hero(
                                    tag: "$index",
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: StarCard(
                                        text: snapshot.data[index].name,
                                        temperature:
                                            snapshot.data[index].temperature,
                                        onTap: () => Navigator.of(context)
                                            .push(route(SolarSystemView(
                                          index: index,
                                          starTemp:
                                              snapshot.data[index].temperature,
                                          star: snapshot.data[index].name,
                                        ))),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      default:
                        return Center(child: Loading());
                    }
                  },
                ),
              ),
              Obx(
                () => Positioned(
                  top: StarHeaderController.to.position.value,
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
                          child: Column(
                            children: [
                              Header("Stars", () => Navigator.pop(context)),
                            ],
                          ),
                        ),
                        Container(
                          color: Theme.of(context).dialogBackgroundColor,
                          width: Get.width,
                          child: SearchBar(
                            searchFunc: (String value) {
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
        ),
      ),
    );
  }
}

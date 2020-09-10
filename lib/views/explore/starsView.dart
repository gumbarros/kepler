import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/solarSystemView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

import '../../headerController.dart';

class StarsView extends StatefulWidget {
  @override
  _StarsViewState createState() => _StarsViewState();
}

class _StarsViewState extends State<StarsView> with TickerProviderStateMixin {
  ScrollController _scrollController;
  final HeaderController controller = Get.put(HeaderController());
  AnimationController fadeController;
  Animation fadeAnimation;
  AnimationController scaleController;
  Animation scaleAnimation;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          controller.position.value >= -Get.height / 2) {
        controller.changeminus();
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          controller.position.value <= -10) {
        controller.changeplus();
        if (_scrollController.offset == 0) {
          controller.changezero();
        }
      }
    });
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
    super.initState();
  }

  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: GetBuilder<StarsController>(
          init: new StarsController(),
          builder: (_) => Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(children: [
              Background(),
              Container(
                width: Get.width,
                height: Get.height,
                child: FutureBuilder<List<PlanetData>>(
                  future: API.getAllStars(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PlanetData>> snapshot) {
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
                        return GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            //We can dynamic change this depending on the screen size
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return SizedBox(
                                  height: Get.height * 0.3,
                                );
                              }
                              if (index == 1) {
                                return SizedBox(
                                  height: Get.height * 0.3,
                                );
                              }
                              return GestureDetector(
                                onTap: () => Get.to(SolarSystemView(
                                    star: snapshot.data[index].star)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: Get.width / 4,
                                    height: Get.height / 4,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(16.0)),
                                    ),
                                    child: Center(
                                      child: Text(snapshot.data[index].star),
                                    ),
                                  ),
                                ),
                              );
                            });
                      default:
                        return Center(child: Loading());
                    }
                  },
                ),
              ),
              Obx(
                () => Positioned(
                  top: controller.position.value,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height / 10,
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height / 28),
                        Container(
                          color: Theme.of(context).dialogBackgroundColor,
                          child: Header(
                            "Stars", //TODO: i18n
                          ),
                        ),
                        Container(
                          width: Get.width,
                          child: SearchBar(
                            searchFunc: (String value) {
                              _.upd();
                            },
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).dialogBackgroundColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
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

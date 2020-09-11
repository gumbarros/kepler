import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/headerController.dart';
import 'package:kepler/controllers/pagesController.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/views/explore/solarSystemView.dart';
import 'package:kepler/widgets/cards/starCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class StarsView extends StatefulWidget {
  @override
  _StarsViewState createState() => _StarsViewState();
}

class _StarsViewState extends State<StarsView> with TickerProviderStateMixin {
  final HeaderController controller = Get.put(HeaderController());

  AnimationController fadeController;
  Animation fadeAnimation;
  AnimationController scaleController;
  Animation scaleAnimation;

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
    HeaderController.to.scrollController = ScrollController();
    HeaderController.to.scrollController.addListener(() {
      if (HeaderController.to.scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          controller.position.value >= -Get.height / 2) {
        controller.changeMinus();
      } else if (HeaderController.to.scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          controller.position.value <= -10) {
        controller.changePlus();
        if (HeaderController.to.scrollController.offset == 0) {
          controller.changeZero();
        }
      }
    });
    super.initState();
  }

  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    HeaderController.to.scrollController.dispose();
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
              Container(
                width: Get.width,
                height: Get.height,
                child: FutureBuilder<List<StarData>>(
                  future: API.getAllStars(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<StarData>> snapshot) {
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
                        return ListView.builder(
                            controller: HeaderController.to.scrollController,
                            //We can dynamic change this depending on the screen size
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return SizedBox(
                                  height: Get.height / 4,
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: StarCard(
                                  text: snapshot.data[index - 1].name,
                                  temperature: snapshot.data[index - 1].temperature,
                                  onTap: () => PagesController.to.changeView(
                                      SolarSystemView(
                                          star: snapshot.data[index - 1].name)),
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
                        //Using temporary color
                        Container(
                          color: Theme.of(context).dialogBackgroundColor,
                          child: Header("Stars", Get.back),
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

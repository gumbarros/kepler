import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/cupertinopageroute.dart';
import 'package:kepler/locale/translations.dart';
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

class _StarsViewState extends State<StarsView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController fadeController;
  Animation fadeAnimation;
  AnimationController scaleController;
  Animation scaleAnimation;
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
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (                 scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          position.value >= -Get.height / 2) {
        changeMinus();
      } else if (
                  scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          position.value <= -10) {
        changePlus();
        if (scrollController.offset == 0) {
          changeZero();
        }
      }
    });
    super.initState();
  }

  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print('rebuilt');
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
                              string.text("no_stars"), //TODO: i18n
                              style: TextStyle(fontFamily: "Roboto"),
                            ),
                          );
                        }
                        return ListView.builder(
                            controller:
                                scrollController,
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
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: StarCard(
                                            text: snapshot.data[index].name,
                                            temperature: snapshot
                                                .data[index].temperature,
                                            onTap: () =>
                                                Navigator.of(context).push(
                                              route(
                                                SolarSystemView(
                                                  index: index,
                                                  starTemp: snapshot
                                                      .data[index].temperature,
                                                  star:
                                                      snapshot.data[index].name,
                                                ),
                                              ),
                                            ),
                                          ),
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
                            });
                      default:
                        return Center(child: Loading());
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
                        //Using temporary color
                        Container(
                          color: Theme.of(context).dialogBackgroundColor,
                          child: Column(
                            children: [
                              Header(string.text("stars"),
                                  () => Navigator.pop(context)),
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

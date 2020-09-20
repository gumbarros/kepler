import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
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

class _StarsViewState extends State<StarsView> {
  ScrollController scrollController;
  RxDouble position = 0.0.obs;
  Function _future;
  changeMinus() {
    position.value -= 30;
  }

  changePlus() {
    position.value += 30;
  }

  changeZero() {
    position.value = 0;
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          position.value >= -Get.height / 2) {
        changeMinus();
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          position.value <= -10) {
        changePlus();
        if (scrollController.offset == 0) {
          changeZero();
        }
      }
    });
    _future = API.getAllStars;
    super.initState();
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      autoRemove: false,
      init: new StarsController(),
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<List<StarData>>(
              future: _future(),
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
                        controller: scrollController,
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
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: StarCard(
                                    size: Get.width / 3.3,
                                    index: index,
                                    text: snapshot.data[index].name,
                                    temperature:
                                        snapshot.data[index].temperature,
                                    onTap: () => Navigator.of(context).push(
                                      route(
                                        SolarSystemView(
                                          index: index,
                                          starTemp:
                                              snapshot.data[index].temperature,
                                          star: snapshot.data[index].name,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: StarCard(
                                size: Get.width / 3.3,
                                index: index,
                                text: snapshot.data[index].name,
                                temperature: snapshot.data[index].temperature,
                                onTap: () => Navigator.of(context)
                                    .push(route(SolarSystemView(
                                  index: index,
                                  starTemp: snapshot.data[index].temperature,
                                  star: snapshot.data[index].name,
                                ))),
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
    );
  }
}

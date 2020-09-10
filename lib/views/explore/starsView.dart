import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/views/explore/solarSystemView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class HeaderControllerS extends GetxController {
  RxDouble position = 0.0.obs;

  changeminus() {
    position.value -= 10;
  }

  changeplus() {
    position.value += 10;
  }

  changezero() {
    position.value = 0;
  }
}

class StarsView extends StatefulWidget {
  @override
  _StarsViewState createState() => _StarsViewState();
}

class _StarsViewState extends State<StarsView> {
  bool gap = true;
  int gapnumber;
  ScrollController _scrollController;
  final HeaderControllerS controller = Get.put(HeaderControllerS());

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
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      init: new StarsController(),
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: [
          Background(),
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
                    return GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        //We can dynamic change this depending on the screen size
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length + 2,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return SizedBox();
                          }
                          if (index == 1) {
                            return SizedBox();
                          }
                          return GestureDetector(
                            onTap: () => Get.to(SolarSystemView(
                                star: snapshot.data[index].name)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: Get.width / 4,
                                height: Get.height / 4,
                                decoration: BoxDecoration(
                                  color: _.getStarColor(
                                      snapshot.data[index - 2].temperature),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(16.0)),
                                ),
                                child: Center(
                                  child: Text(snapshot.data[index - 2].name),
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
                    //Using temporary color
                    Container(
                      color: Theme.of(context).dialogBackgroundColor,
                      //TODO: Change the colour accordingly to the theme
                      child: Header(
                        "Stars", //TODO: i18n
                      ),
                    ),
                    Container(
                      color: Theme.of(context).dialogBackgroundColor,
                      //TODO: Change the colour accordingly to the theme
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

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
import 'package:kepler/widgets/backgrounds/homeBackground.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class StarsView extends StatelessWidget{

  final HeaderController controller = Get.put(HeaderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      initState: (state){
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
      },
      dispose: (state){
        HeaderController.to.scrollController.dispose();
      },
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
                    return GridView.builder(
                        controller: HeaderController.to.scrollController,
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
                            onTap: () {
                              PagesController.to.changeView(SolarSystemView(star: snapshot.data[index-2].name));
                            },
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

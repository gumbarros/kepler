import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/starData.dart';

import 'package:kepler/utils/cupertinoPageRoute.dart';
import 'package:kepler/views/explore/solarSystemView.dart';
import 'package:kepler/widgets/backgrounds/background.dart';
import 'package:kepler/widgets/cards/starCard.dart';

import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class StarsView extends StatelessWidget{


  final position = 0.0.obs;
  final ScrollController scrollController = new ScrollController();

  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      autoRemove: false,
      init: new StarsController(),
      dispose: (state){
        scrollController.dispose();
      },
      initState: (state){
       scrollController.addListener(() {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
              position.value >= -Get.height / 2) {
            position.value -= 30;

          } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
              position.value <= -10) {
            position.value += 30;
            if (scrollController.offset == 0) {
              position.value = 0;
            }
          }
        });
      },
      builder: (_) => Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: false,
            body: Stack(children: [
              Container(
                width: Get.width,
                height: Get.height,
                child: FutureBuilder<List<StarData>>(
                  future: KeplerDatabase.db.getAllStars(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<StarData>> snapshot) {
                    switch(snapshot.connectionState) {
                      case(ConnectionState.waiting):
                      case(ConnectionState.active):
                        return Center(child: Loading(),);
                      default:
                    if (snapshot.data.isNull) {
                      return Center(
                        child: Text(
                          string.text("no_stars"),
                          style: TextStyle(fontFamily: "Roboto"),
                        ),
                      );
                    }
                    return ListView.builder(
                        controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => Visibility(
                                  visible: _.find(snapshot.data[index].name),
                                  child: Container(
                                    margin: index.isEqual(0) ? EdgeInsets.only(top: Get.height / 3.5) : null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: StarCard(
                                        snapshot.data[index].id,
                                        size: Get.width / 3.3,
                                        index: index,
                                        text: snapshot.data[index].name,
                                        temperature:
                                            snapshot.data[index].temperature,
                                        onTap: () => Navigator.of(context)
                                            .push(route(SolarSystemView(
                                          index: index,
                                          star: snapshot.data[index],
                                        ))),
                                      ),
                            ),
                                  ),
                          ),
                          );
                        });
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
                          color: Colors.transparent,
                          child: Column(
                            children: [

                              Header(string.text("stars"),
                                  () => Navigator.pop(context)),
                            ],
                          ),
                        ),
                        Container(
                          color:Colors.transparent,
                          width: Get.width,
                          child: SearchBar(_.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            // floatingActionButton: Obx(() => Visibility(
            //       child: FloatingActionButton(
            //         child: Icon(Icons.filter_list),
            //         backgroundColor: KeplerTheme.theme.dialogBackgroundColor,
            //         foregroundColor: Colors.white,
            //         onPressed: (){
            //             Get.dialog(FilterDialog());
            //         },
            //       ),
            //       visible: position.value.isEqual(0),
            //     )),
          ),
        ],
      ),
    );
  }
}

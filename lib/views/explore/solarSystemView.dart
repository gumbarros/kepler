import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/solarSystemController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/views/explore/planetsView.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class HeaderController extends GetxController {
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

class SolarSystemView extends StatefulWidget {
  final String star;

  SolarSystemView({@required this.star});
  @override
  _SolarSystemViewState createState() => _SolarSystemViewState();
}

class _SolarSystemViewState extends State<SolarSystemView> {
  ScrollController _scrollController;
  final HeaderController controller = Get.put(HeaderController());

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
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    //I removed the transitions because it causes a crash - Gustavo 09/06/2020
                    return ListView.builder(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
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
                                child: GestureDetector(
                                  onTap: () => Get.to(PlanetView(
                                    planetName: snapshot.data[index].planetName,
                                  )),
                                  child: Center(
                                    child:
                                        Text(snapshot.data[index].planetName),
                                  ),
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
                        widget.star + " System", //TODO: i18n
                      ),
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

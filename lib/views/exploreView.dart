import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/controllers/exploreController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planets.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> with TickerProviderStateMixin {
  AnimationController _fadecontroller;

  AnimationController _scalecontroller;

  @override
  void initState() {
    _fadecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _scalecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //Animation on Route Pop from back button
      onWillPop: () async {
        _fadecontroller.reverse();
        await _scalecontroller.reverse();
        return true;
      },
      child: GetBuilder<ExploreController>(
        init: new ExploreController(),
        builder: (_) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: ListView(children: [
            Header(string.text('explore'),
                fadeController: _fadecontroller, scaleController: _scalecontroller),
            Column(
              children: [
                SearchBar(
                  searchFunc: (String value) {
                    _.search.value = value;
                    _.upd();
                  },
                ),
                Container(
                  width: Get.width,
                  height: Get.height / 1.55,
                  child: FutureBuilder<List<PlanetData>>(
                    future: _.getAllPlanets(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List<PlanetData>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.data.isNull) {
                            return Center(
                              child: Text(
                                string.text("no_planet"),
                                style: GoogleFonts.roboto(),
                              ),
                            );
                          }
                          //I removed the transitions because it causes a crash - Gustavo 09/06/2020
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  visible: _.find(snapshot.data[index].planetName),
                                  child: PlanetCard(
                                    index: index,
                                    planets: snapshot.data,
                                  ),
                                );
                              });
                        default:
                          return Center(child: Loading());
                      }
                    },
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

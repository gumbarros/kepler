import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/controllers/planetsController.dart';
import 'package:kepler/models/planets.dart';
import 'package:kepler/widgets/cards/planetCard.dart';
import 'package:kepler/widgets/forms/searchBar.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class PlanetView extends StatefulWidget {
  @override
  _PlanetViewState createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> with TickerProviderStateMixin {
  Animation _fadeanimation;

  Animation _scaleanimation;

  AnimationController _fadecontroller;

  AnimationController _scalecontroller;

  @override
  void initState() {
    _fadecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _fadeanimation = Tween<double>(begin: 0, end: 1).animate(_fadecontroller);

    _scalecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleanimation = Tween<double>(begin: 0.85, end: 1).animate(_scalecontroller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put<PlanetsController>(PlanetsController());
    return WillPopScope(
      //Animation on Route Pop from back button
      onWillPop: () async {
        _fadecontroller.reverse();
        await _scalecontroller.reverse();
        return true;
      },
      child: GetBuilder<PlanetsController>(
        builder: (_) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: ListView(children: [
            Header('Planets',
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
                    future: PlanetsController.to.getAllPlanets(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List<PlanetData>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          _fadecontroller.forward();
                          _scalecontroller.forward();
                          if (snapshot.data.isNull) {
                            return Center(
                              child: Text(
                                "No planets were found.",
                                style: GoogleFonts.roboto(),
                              ),
                            );
                          }
                          return FadeTransition(
                            opacity: _fadeanimation,
                            child: ScaleTransition(
                              scale: _scaleanimation,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Visibility(
                                      visible: PlanetsController.to
                                          .find(snapshot.data[index].planetName),
                                      child: PlanetCard(
                                        index: index,
                                        planets: snapshot.data,
                                      ),
                                    );
                                  }),
                            ),
                          );
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

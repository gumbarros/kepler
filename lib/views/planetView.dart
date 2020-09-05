import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/controllers/planetsController.dart';
import 'package:kepler/models/planets.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:kepler/widgets/cards/planetCard.dart';

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
    return GetBuilder<PlanetsController>(
      init: PlanetsController(),
      builder: (_) => WillPopScope(
        //Animation on Route Pop from back button
        onWillPop: () async {
          _fadecontroller.reverse();
          await _scalecontroller.reverse();
          return true;
        },
        child: Scaffold(
          body: Container(
            width: Get.width,
            height: Get.height,
            child: FutureBuilder<List<PlanetData>>(
              future: _.getAllPlanets(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    _fadecontroller.forward();
                    _scalecontroller.forward();
                    return FadeTransition(
                      opacity: _fadeanimation,
                      child: ScaleTransition(
                        scale: _scaleanimation,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text('Planet View',
                                                style: GoogleFonts.josefinSans(
                                                    fontSize: 50)),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            onPressed: () async {
                                              _fadecontroller.reverse();
                                              await _scalecontroller.reverse();
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height / 7,
                                    ),
                                  ],
                                );
                              }
                              return PlanetCard(
                                index: index,
                                planets: snapshot.data,
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
        ),
      ),
    );
  }
}

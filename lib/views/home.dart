import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/planetsController.dart';
import 'package:kepler/models/planets.dart';
import 'package:kepler/widgets/planetCard.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<PlanetsController>(PlanetsController());
    return GetBuilder<PlanetsController>(
      init: PlanetsController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kepler"),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: FutureBuilder<List<PlanetData>>(
            future: API.getAllPlanets(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PlanetCard(
                          index: index,
                          planets: snapshot.data,
                        );
                      });
                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/planetsController.dart';
import 'package:kepler/models/planets.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:kepler/widgets/cards/planetCard.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<PlanetsController>(PlanetsController());
    return GetBuilder<PlanetsController>(
      init: PlanetsController(),
      builder: (_) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {},
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            currentIndex: 1,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                title: Text("Graphics"),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 0,
                  ),
                  title: Text("")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.filter_list), title: Text("Filters"))
            ],
          ),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: FutureBuilder<List<PlanetData>>(
            future: _.getAllPlanets(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PlanetCard(
                          index: index,
                          planets: snapshot.data,
                        );
                      });
                default:
                  return Center(child: Loading());
              }
            },
          ),
        ),
      ),
    );
  }
}

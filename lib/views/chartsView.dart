import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      init: ChartsController(),
      builder: (_) => Scaffold(
          body: Container(
              width: Get.width,
              height: Get.height,
              child: ListView(
                children: [
                  Header(
                    "Charts View",
                  ),
                  //TODO: Sort data & fix labels
                  FutureBuilder<List<PlanetData>>(
                      future: API.getAllPlanets(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return Container(
                                width: Get.width,
                                height: Get.height / 1.55,
                                child: SfCartesianChart(
                                  title: ChartTitle(text: "Heaviest Planets"),
                                  series: <ColumnSeries<PlanetData, dynamic>>[
                                    ColumnSeries<PlanetData, dynamic>(
                                        enableTooltip: true,
                                        dataSource: snapshot.data.sublist(0, 3),
                                        color: Colors.purple,
                                        xValueMapper: (PlanetData data, _) =>
                                            data.planetName,
                                        yValueMapper: (PlanetData data, _) =>
                                            data.jupiterMass),
                                  ],
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(),
                                ));
                            break;
                          default:
                            return Center(child: Loading());
                        }
                      }),
                ],
              ))),
    );
  }
}

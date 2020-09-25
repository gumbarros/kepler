import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrbitChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
        init: ChartsController(),
        builder: (controller) {
          return Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(
                  "Orbit Comparison", //TODO - LOCALIZE - ORBIT COMPARISON
                  () => Navigator.of(
                    context,
                  ).pop(
                    context,
                  ),
                ),
                Container(
                  height: Get.width,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      // Renders radial bar chart
                      RadialBarSeries<PlanetData, String>(
                        dataSource: [
                          PlanetData(
                            planetName: "Earth",
                            orbitalPeriod: 1,
                          ),
                          PlanetData(
                            planetName: "Mars",
                            orbitalPeriod: 2,
                          ),
                          PlanetData(
                            planetName: "Jupiter",
                            orbitalPeriod: 3,
                          ),
                          PlanetData(
                            planetName: "Venus",
                            orbitalPeriod: .5,
                          ),
                        ],
                        xValueMapper: (data, _) => data.planetName,
                        yValueMapper: (data, _) => data.orbitalPeriod,
                        dataLabelMapper: (data, _) => data.planetName,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

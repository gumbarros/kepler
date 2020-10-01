import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';
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
                    child: FutureBuilder<List<PlanetData>>(
                      future: KeplerDatabase.db.getSmallestOrbits(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PlanetData>> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                              child: Loading(),
                            );
                          default:
                            return SfCircularChart(
                              title: ChartTitle(text: "Smallest Planet Orbits"),
                              borderColor: Theme.of(context).primaryColor,
                              legend: Legend(
                                  isVisible: true,
                                  iconHeight: 20,
                                  iconWidth: 20,
                                  position: LegendPosition.bottom,
                                  overflowMode: LegendItemOverflowMode.wrap),
                              series: <CircularSeries>[
                                // Renders radial bar chart
                                DoughnutSeries<PlanetData, String>(
                                  dataSource: snapshot.data,
                                  xValueMapper: (data, _) => data.planetName,
                                  yValueMapper: (data, _) => data.orbitalPeriod,
                                  legendIconType: LegendIconType.circle,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false),
                                ),
                              ],
                            );
                        }
                      },
                    )),
              ],
            ),
          );
        });
  }
}

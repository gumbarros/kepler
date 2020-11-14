import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/services/database/database.dart';
import 'package:kepler/src/models/planetData.dart';
import 'package:kepler/src/ui/widgets/progress/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrbitChart extends StatelessWidget {

  final String title;
  final String orderBy;

  OrbitChart({@required this.title, @required this.orderBy});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.width,
        child: FutureBuilder<List<PlanetData>>(
          future: KeplerDatabase.db.getPlanetsOrbits(orderBy),
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
                  title: ChartTitle(text: title),
                  borderColor: Theme.of(context).primaryColor,
                  legend: Legend(
                      isVisible: true,
                      iconHeight: 20,
                      iconWidth: 20,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: TooltipBehavior(enable: true, ),
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
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/widgets/backgrounds/background.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrbitChartView extends StatelessWidget {
  final Future<List<PlanetData>> planetsOrbits;
  final String title;

  OrbitChartView.subChart(this.title, this.planetsOrbits, {Key key})
      : super(key: key);

  OrbitChartView({Key key})
      : title = "Orbit Comparison",
        planetsOrbits = KeplerDatabase.db.getAllPlanetsOrbits(),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
        init: ChartsController(),
        builder: (controller) {
          return Stack(
            children: [
              Background(),
              Scaffold(
                backgroundColor: Colors.transparent,
                //TODO - make this a custom scroll view with a sliver header and a sliver view
                body: ListView(
                  children: [
                    Header(
                      this.title,
                      () => Navigator.of(
                        context,
                      ).pop(
                        context,
                      ),
                    ),
                    OrbitBuilder(
                      future: planetsOrbits,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class OrbitBuilder extends StatelessWidget {
  final Future<List<PlanetData>> future;

  OrbitBuilder({
    Key key,
    @required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      init:ChartsController(),
      builder:(_)=> FutureBuilder<List<Cluster>>(
        future: this.future.then(
              (List<PlanetData> planetData) async => (planetData.length > 10)
                  ? await _.getClusters(planetData, 10)
                  : await _.getClusters(planetData, 1),
            ),
        builder: (BuildContext context, AsyncSnapshot<List<Cluster>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Loading(),
              );
            default:
              List<Cluster> clusterData = snapshot.data;
              final bool isDoughnut = _.isDoughnut(clusterData);

              return Container(
                width: Get.width,
                height: Get.height,
                child: SfCircularChart(
                  onLegendTapped: (isDoughnut)
                      ? (pointData) => Navigator.of(context).push(
                            route(
                              OrbitChartView.subChart(
                                _.getTitle(
                                  clusterData[pointData.pointIndex],
                                ),
                                KeplerDatabase.db.getPlanetsOrbitsBetween(
                                _.getMinForCluster(
                                    clusterData[pointData.pointIndex],
                                  ),
                                  _.getMaxForCluster(
                                    clusterData[pointData.pointIndex],
                                  ),
                                ),
                              ),
                            ),
                          )
                      : (_) {},
                  onPointTapped: (isDoughnut)
                      ? (pointData) => Navigator.of(context).push(
                            route(
                              OrbitChartView.subChart(
                                _.getTitle(
                                  clusterData[pointData.pointIndex],
                                ),
                                KeplerDatabase.db.getPlanetsOrbitsBetween(
                                  _.getMinForCluster(
                                    clusterData[pointData.pointIndex],
                                  ),
                                  _.getMaxForCluster(
                                    clusterData[pointData.pointIndex],
                                  ),
                                ),
                              ),
                            ),
                          )
                      : (_) {},
                  legend: Legend(
                      isVisible: true,
                      iconHeight: 10,
                      width: Get.width.toString(),
                      height: (Get.height / 2).toString(),
                      iconWidth: 10,
                      position: LegendPosition.bottom,
                      toggleSeriesVisibility: false,
                      overflowMode: LegendItemOverflowMode.wrap),
                  series: (isDoughnut)
                      ? <CircularSeries>[
                          // Renders radial bar chart
                          DoughnutSeries<Cluster, String>(
                            innerRadius: '50%',
                            radius: '80%',
                            dataSource: clusterData,
                            xValueMapper: (data, __) => _.getTitle(data),

                            // yValueMapper: (data, _) => data.location.first,
                            yValueMapper: (data, __) => data.instances.length,
                            legendIconType: LegendIconType.circle,

                            dataLabelSettings:
                                DataLabelSettings(isVisible: false),
                          ),
                        ]
                      : <CircularSeries>[
                          RadialBarSeries<Instance, String>(
                            gap: '9%',
                            innerRadius: '0%',
                            radius: '100%',
                            pointRadiusMapper: (data, __) =>
                                "${data.location[0] / _.getMaxForClusterList(clusterData) * 100}%",
                            dataSource: clusterData[0].instances,
                            maximumValue: 100,
                            xValueMapper: (data, __) =>
                                "${data.id} - ${data.location[0]} days",
                            yValueMapper: (data, _) => 100,
                            dataLabelMapper: (data, _) => data.id,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: false,
                                labelPosition: ChartDataLabelPosition.inside),
                          )
                        ],
                ),
              );
          }
        },
      ),
    );
  }
}

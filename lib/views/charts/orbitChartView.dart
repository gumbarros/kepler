import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/utils/cupertinoPageRoute.dart';
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

  getClusters(List<PlanetData> planets, int clusterCount) async {
    // Set the distance measure; this can be any function of the form
    // num f(List<num> a, List<num> b): a and b contain the coordinates
    // of two instances; f returns a numerical distance between the
    // points.
    distanceMeasure = DistanceType.squaredEuclidian;

    // Create the list of instances.
    List<Instance> instances = planets
        .map((PlanetData planet) => Instance(
              [planet.orbitalPeriod, 0],
              id: planet.planetName,
            ))
        .toList();

    // Randomly create the initial clusters.
    List<Cluster> clusters = initialClusters(clusterCount, instances, seed: 0);

    ///TODO: Dont comment this out it does the clustering inplace the info variable just is for error information or other information from the algorithm
    var _ = kmeans(clusters: clusters, instances: instances);

    ///TODO: Dont comment this out either, this sorts the clusters in order of their orbital size.
    clusters.sort(
      (a, b) => getMaxForCluster(
        a,
      ).compareTo(
        getMaxForCluster(
          b,
        ),
      ),
    );
    return clusters;
  }

  num getMaxForClusterList(List<Cluster> clusterlist) => clusterlist
      .map(
        (cluster) => getMaxForCluster(cluster),
      )
      .reduce(
        max,
      );
  num getMinForClusterList(List<Cluster> clusterlist) => clusterlist
      .map(
        (cluster) => getMinForCluster(cluster),
      )
      .reduce(
        min,
      );
  num getMaxForCluster(Cluster cluster) => cluster.instances
      .map(
        (planet) => planet.location.first,
      )
      .reduce(
        max,
      );
  num getMinForCluster(Cluster cluster) => cluster.instances
      .map(
        (planet) => planet.location.first,
      )
      .reduce(
        min,
      );

  String getTitle(Cluster data) => (getMaxForCluster(data) < 365 ||
          (getMinForCluster(data) / 365).truncate() == 0)
      ? "${getMinForCluster(data).toStringAsFixed(2)} - ${getMaxForCluster(data).toStringAsFixed(2)} days: ${data.instances.length} planets"
      : "${(getMinForCluster(data) / 365).toStringAsFixed(0)} - ${(getMaxForCluster(data) / 365).toStringAsFixed(0)} years: ${data.instances.length} planets";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cluster>>(
      future: this.future.then(
            (List<PlanetData> planetData) async => (planetData.length > 10)
                ? await this.getClusters(planetData, 10)
                : await this.getClusters(planetData, 1),
          ),
      builder: (BuildContext context, AsyncSnapshot<List<Cluster>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: Loading(),
            );
          default:
            var clusterData = snapshot.data;
            final isDoughnut = clusterData.length > 1;
            return Container(
              width: Get.width,
              height: Get.height,
              child: SfCircularChart(
                onLegendTapped: (isDoughnut)
                    ? (pointData) => Navigator.of(context).push(
                          route(
                            OrbitChartView.subChart(
                              this.getTitle(
                                clusterData[pointData.pointIndex],
                              ),
                              KeplerDatabase.db.getPlanetsOrbitsBetween(
                                getMinForCluster(
                                  clusterData[pointData.pointIndex],
                                ),
                                getMaxForCluster(
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
                              this.getTitle(
                                clusterData[pointData.pointIndex],
                              ),
                              KeplerDatabase.db.getPlanetsOrbitsBetween(
                                getMinForCluster(
                                  clusterData[pointData.pointIndex],
                                ),
                                getMaxForCluster(
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
                          xValueMapper: (data, _) => getTitle(data),

                          // yValueMapper: (data, _) => data.location.first,
                          yValueMapper: (data, _) => data.instances.length,
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
                          pointRadiusMapper: (data, _) =>
                              "${data.location[0] / getMaxForClusterList(clusterData) * 100}%",
                          dataSource: clusterData[0].instances,
                          maximumValue: 100,
                          xValueMapper: (data, _) =>
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
    );
  }
}

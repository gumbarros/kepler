import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class ClusteredChartView<CHART_DATA> extends StatelessWidget {
  final Future<List<CHART_DATA>> data;
  final Function(CHART_DATA) locationFunction;
  final Function(CHART_DATA) identifierFunction;

  final Future<List<CHART_DATA>> Function(double, double) subdataFunction;
  final Future<CHART_DATA> Function(String) leafOnClickData;

  final Widget Function(
          List<Cluster>, Future<List<CHART_DATA>> Function(double, double))
      clusteredChartBuilder;
  final Widget Function(Cluster, Future<CHART_DATA> Function(String))
      leafChartBuilder;

  final String title;
  const ClusteredChartView({
    this.title,
    this.data,
    this.locationFunction,
    Key key,
    this.identifierFunction,
    this.subdataFunction,
    this.clusteredChartBuilder,
    this.leafChartBuilder,
    this.leafOnClickData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
        init: ChartsController(),
        builder: (controller) {
          return Scaffold(
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
                ClusterChart<CHART_DATA>(
                  data: data,
                  locationFunction: locationFunction,
                  identifierFunction: identifierFunction,
                  subdataFunction: subdataFunction,
                  clusteredChartBuilder: clusteredChartBuilder,
                ),
              ],
            ),
          );
        });
  }
}

class ClusterChart<CHART_DATA> extends StatelessWidget {
  final Future<List<CHART_DATA>> data;
  final double Function(CHART_DATA) locationFunction;
  final String Function(CHART_DATA) identifierFunction;
  final Future<List<CHART_DATA>> Function(double, double) subdataFunction;
  final Widget Function(
          List<Cluster>, Future<List<CHART_DATA>> Function(double, double))
      clusteredChartBuilder;
  final Widget Function(
          Cluster, Future<List<CHART_DATA>> Function(double, double))
      leafChartBuilder;

  const ClusterChart({
    Key key,
    this.data,
    this.locationFunction,
    this.identifierFunction,
    this.clusteredChartBuilder,
    this.subdataFunction,
    this.leafChartBuilder,
  }) : super(key: key);

  getClusters(List<CHART_DATA> planets, int clusterCount) async {
    // Set the distance measure; this can be any function of the form
    // num f(List<num> a, List<num> b): a and b contain the coordinates
    // of two instances; f returns a numerical distance between the
    // points.
    distanceMeasure = DistanceType.squaredEuclidian;

    // Create the list of instances.
    List<Instance> instances = planets
        .map((CHART_DATA planet) => Instance(
              [this.locationFunction(planet), 0],
              id: this.identifierFunction(planet),
            ))
        .toList();

    // Randomly create the initial clusters.
    List<Cluster> clusters = initialClusters(clusterCount, instances, seed: 0);

    ///TODO: Dont comment this out it does the clustering inplace the info variable just is for error information or other information from the algorithm
    var _ = kmeans(clusters: clusters, instances: instances);

    ///TODO: Dont comment this out either, this sorts the clusters in order of their data location size.
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

  @override
  Widget build(BuildContext context) => FutureBuilder<List<Cluster>>(
      future: this.data.then(
            (List<CHART_DATA> planetData) async => (planetData.length > 10)
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
            final clusterData = snapshot.data;
            final isClusterChart = clusterData.length > 1;
            return Container(
              width: Get.width,
              height: Get.height,
              child: isClusterChart
                  ? clusteredChartBuilder(clusterData, subdataFunction)
                  : leafChartBuilder(clusterData.first, subdataFunction),
            );
        }
      });
}

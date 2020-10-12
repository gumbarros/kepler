import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class ClusteredChartView<CHART_DATA> extends StatelessWidget {
  final Future<List<CHART_DATA>> data;
  final Function(CHART_DATA) locationFunction;
  final Function(CHART_DATA) identifierFunction;

  final Future<List<CHART_DATA>> Function(double, double) subdataFunction;
  final Future<CHART_DATA> Function(String) leafOnClickData;

  final Widget Function(BuildContext, List<Cluster>,
      Future<List<CHART_DATA>> Function(double, double)) clusteredChartBuilder;
  final Widget Function(
          BuildContext, Cluster, Future<CHART_DATA> Function(String))
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
            leafChartBuilder: leafChartBuilder,
            leafOnClickData: leafOnClickData,
          ),
        ],
      ),
    );
  }
}

class ClusterChart<CHART_DATA> extends StatefulWidget {
  final Future<List<CHART_DATA>> data;
  final double Function(CHART_DATA) locationFunction;
  final String Function(CHART_DATA) identifierFunction;
  final Future<List<CHART_DATA>> Function(
    double,
    double,
  ) subdataFunction;
  final Widget Function(
    BuildContext,
    List<Cluster>,
    Future<List<CHART_DATA>> Function(
      double,
      double,
    ),
  ) clusteredChartBuilder;
  final Widget Function(
    BuildContext,
    Cluster,
    Future<CHART_DATA> Function(String),
  ) leafChartBuilder;
  final Future<CHART_DATA> Function(String) leafOnClickData;

  const ClusterChart({
    Key key,
    this.data,
    this.locationFunction,
    this.identifierFunction,
    this.clusteredChartBuilder,
    this.subdataFunction,
    this.leafChartBuilder,
    this.leafOnClickData,
  }) : super(key: key);

  static num getMaxForClusterList(List<Cluster> clusterlist) =>
      (clusterlist.length == 1)
          ? getMaxForCluster(clusterlist.first)
          : clusterlist
              .map(
                (cluster) => getMaxForCluster(cluster),
              )
              .reduce(
                max,
              );
  static num getMinForClusterList(List<Cluster> clusterlist) =>
      (clusterlist.length == 1)
          ? getMinForCluster(clusterlist.first)
          : clusterlist
              .map(
                (cluster) => getMinForCluster(cluster),
              )
              .reduce(
                min,
              );
  static num getMaxForCluster(Cluster cluster) =>
      (cluster.instances.length == 1)
          ? cluster.instances.first.location.first
          : cluster.instances
              .map(
                (planet) => planet.location.first,
              )
              .reduce(
                max,
              );
  static num getMinForCluster(Cluster cluster) =>
      (cluster.instances.length == 1)
          ? cluster.instances.first.location.first
          : cluster.instances
              .map(
                (planet) => planet.location.first,
              )
              .reduce(
                min,
              );

  @override
  _ClusterChartState<CHART_DATA> createState() =>
      _ClusterChartState<CHART_DATA>();
}

class _ClusterChartState<CHART_DATA> extends State<ClusterChart<CHART_DATA>> {
  getClusters(List<CHART_DATA> planets, int clusterCount) {
    // Set the distance measure; this can be any function of the form
    // num f(List<num> a, List<num> b): a and b contain the coordinates
    // of two instances; f returns a numerical distance between the
    // points.
    distanceMeasure = DistanceType.squaredEuclidian;
    // Create the list of instances.
    List<Instance> instances = planets
        .map((CHART_DATA planet) => Instance(
              [this.widget.locationFunction(planet), 0],
              id: this.widget.identifierFunction(planet),
            ))
        .toList();

    // Randomly create the initial clusters.
    List<Cluster> clusters = initialClusters(clusterCount, instances, seed: 0);

    ///TODO: Dont comment this out it does the clustering inplace the info variable just is for error information or other information from the algorithm
    var _ = kmeans(clusters: clusters, instances: instances);

    ///TODO: Dont comment this out either, this sorts the clusters in order of their data location size.
    clusters.sort(
      (a, b) => ClusterChart.getMaxForCluster(
        a,
      ).compareTo(
        ClusterChart.getMaxForCluster(
          b,
        ),
      ),
    );

    return clusters;
  }

  bool vis = false;
  @override
  Widget build(BuildContext context) => FutureBuilder<List<Cluster>>(
        future: this.widget.data.then(
          (planetData) {
            // final c = Completer<List<Cluster>>();

            final List<CHART_DATA> d = planetData;
            if (d.length > 10) {
              return getClusters(d, 10);
            } else {
              return getClusters(d, 1);
            }
            // return await c.future;
          },
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Cluster>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Loading(),
              );
            default:
              print(snapshot.hasData);
              print(snapshot.hasError);
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return Visibility(
                visible: snapshot.hasData,
                replacement: Center(
                  child: Loading(),
                ),
                child: ClusterChartContainer<CHART_DATA>(
                    clusteredChartBuilder: widget.clusteredChartBuilder,
                    clusterData: snapshot.data,
                    subdataFunction: widget.subdataFunction,
                    leafChartBuilder: widget.leafChartBuilder,
                    leafOnClickData: widget.leafOnClickData),
              );
          }
        },
      );
}

class ClusterChartContainer<CHART_DATA> extends StatelessWidget {
  const ClusterChartContainer({
    Key key,
    @required this.clusteredChartBuilder,
    @required this.clusterData,
    @required this.subdataFunction,
    @required this.leafChartBuilder,
    @required this.leafOnClickData,
  }) : super(key: key);

  final Widget Function(BuildContext p1, List<Cluster> p2,
          Future<List<CHART_DATA>> Function(double p1, double p2) p3)
      clusteredChartBuilder;
  final List<Cluster> clusterData;
  final Future<List<CHART_DATA>> Function(double p1, double p2) subdataFunction;
  final Widget Function(BuildContext p1, Cluster p2,
      Future<CHART_DATA> Function(String p1) p3) leafChartBuilder;
  final Future<CHART_DATA> Function(String p1) leafOnClickData;

  @override
  Widget build(BuildContext context) {
    print(clusterData.length);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: clusterData.length > 1
          ? clusteredChartBuilder(
              context,
              clusterData,
              subdataFunction,
            )
          : leafChartBuilder(
              context,
              clusterData.first,
              leafOnClickData,
            ),
    );
  }
}

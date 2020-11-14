import 'dart:math';

import 'package:get/get.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/src/models/planetData.dart';

class ChartsController extends GetxController {
  static ChartsController get to => Get.find();

  List<PlanetData> orbits;

  bool isDoughnut(List<Cluster> data){
    if(data.isNull){
      return false;
    }
    if(data.length > 1){
      return true;
    }
    return false;
  }


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

  void upd() {
    update();
  }
}

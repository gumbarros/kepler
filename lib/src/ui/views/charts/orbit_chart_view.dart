// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:k_means_cluster/k_means_cluster.dart';
// import 'package:kepler/src/services/database/database.dart';
// import 'package:kepler/src/models/planet_data.dart';
// import 'package:kepler/src/ui/views/charts/clustered_chart_view.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class OrbitChartView extends ClusteredChartView<PlanetData> {
//   static String getTitle(Cluster data) =>
//       (ClusterChart.getMaxForCluster(data) <
//           365 ||
//           (ClusterChart.getMinForCluster(data) / 365).truncate() == 0)
//           ? "${ClusterChart.getMinForCluster(data).toStringAsFixed(
//           2)} - ${ClusterChart.getMaxForCluster(data).toStringAsFixed(
//           2)} days: ${data.instances.length} planets"
//           : "${(ClusterChart.getMinForCluster(data) / 365).toStringAsFixed(
//           0)} - ${(ClusterChart.getMaxForCluster(data) / 365).toStringAsFixed(
//           0)} years: ${data.instances.length} planets";

//   OrbitChartView(String title,Future<List<PlanetData>> data)
//       : super(
//     title: title,
//     data: data,
//     locationFunction: (PlanetData planet) => planet.orbitalPeriod,
//     identifierFunction: (PlanetData planet) => planet.planetName,
//     subdataFunction: (low, high) =>
//         KeplerDatabase.db.getPlanetsOrbitsBetween(low, high),
//     clusteredChartBuilder:
//         (context, clusterData, subDataFutureFunction) =>
//         SfCircularChart(
//             onLegendTapped: (pointData) =>
//                 Navigator.of(context).push(
//                   route(
//                     OrbitChartView(
//                       getTitle(
//                         clusterData[pointData.pointIndex],
//                       ),
//                       subDataFutureFunction(
//                         ClusterChart.getMinForCluster(
//                           clusterData[pointData.pointIndex],
//                         ),
//                         ClusterChart.getMaxForCluster(
//                           clusterData[pointData.pointIndex],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             onPointTapped: (pointData) =>
//                 Navigator.of(context).push(
//                   route(
//                     OrbitChartView(
//                       getTitle(
//                         clusterData[pointData.pointIndex],
//                       ),
//                       subDataFutureFunction(
//                         ClusterChart.getMinForCluster(
//                           clusterData[pointData.pointIndex],
//                         ),
//                         ClusterChart.getMaxForCluster(
//                           clusterData[pointData.pointIndex],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             legend: Legend(
//               isVisible: true,
//               iconHeight: 10,
//               width: Get.width.toString(),
//               height: (Get.height / 2).toString(),
//               iconWidth: 10,
//               position: LegendPosition.bottom,
//               toggleSeriesVisibility: false,
//               overflowMode: LegendItemOverflowMode.wrap,
//             ),
//             series: <CircularSeries>[
//               // Renders radial bar chart
//               DoughnutSeries<Cluster, String>(
//                 innerRadius: '50%',
//                 radius: '80%',
//                 dataSource: clusterData,
//                 xValueMapper: (data, _) => getTitle(data),

//                 // yValueMapper: (data, _) => data.location.first,
//                 yValueMapper: (data, _) => data.instances.length,
//                 legendIconType: LegendIconType.circle,

//                 dataLabelSettings: DataLabelSettings(isVisible: false),
//               ),
//             ]),
//     leafOnClickData: (identifier) =>
//         KeplerDatabase.db.getPlanetByName(identifier),
//     leafChartBuilder: (context, cluster, leafDataFutureFunction) =>
//         SfCircularChart(
//             legend: Legend(
//               isVisible: true,
//               iconHeight: 10,
//               width: Get.width.toString(),
//               height: (Get.height / 2).toString(),
//               iconWidth: 10,
//               position: LegendPosition.bottom,
//               toggleSeriesVisibility: false,
//               overflowMode: LegendItemOverflowMode.wrap,
//             ),
//             series: <CircularSeries>[
//               RadialBarSeries<Instance, String>(
//                 gap: '9%',
//                 innerRadius: '0%',
//                 radius: '100%',
//                 pointRadiusMapper: (data, _) =>
//                 "${data.location[0] / ClusterChart.getMaxForCluster(cluster) *
//                     100}%",
//                 dataSource: cluster.instances,
//                 maximumValue: 100,
//                 xValueMapper: (data, _) =>
//                 "${data.id} - ${data.location[0]} days",
//                 yValueMapper: (data, _) => 100,
//                 dataLabelMapper: (data, _) => data.id,
//                 dataLabelSettings: DataLabelSettings(
//                     isVisible: false,
//                     labelPosition: ChartDataLabelPosition.inside),
//               )
//             ]),
//   );
// }

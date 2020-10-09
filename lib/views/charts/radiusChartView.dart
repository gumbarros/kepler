import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:k_means_cluster/k_means_cluster.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/utils/cupertinoPageRoute.dart';
import 'package:kepler/views/charts/clustered_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadiusChartView extends ClusteredChartView<PlanetData> {
  static String getTitle(Cluster data) =>
      "${ClusterChart.getMinForCluster(data).toStringAsFixed(2)} - ${ClusterChart.getMaxForCluster(data).toStringAsFixed(2)} Jupiter Radius: ${data.instances.length} planets";

  RadiusChartView(String title, Future<List<PlanetData>> data)
      : super(
          title: title,
          data: data,
          locationFunction: (PlanetData planet) => planet.radius,
          identifierFunction: (PlanetData planet) => planet.planetName,
          subdataFunction: (low, high) =>
              KeplerDatabase.db.getPlanetsRadiusBetween(low, high),
          clusteredChartBuilder:
              (context, clusterData, subDataFutureFunction) => SfCircularChart(
                  onLegendTapped: (pointData) => Navigator.of(context).push(
                        route(
                          RadiusChartView(
                            getTitle(
                              clusterData[pointData.pointIndex],
                            ),
                            subDataFutureFunction(
                              ClusterChart.getMinForCluster(
                                clusterData[pointData.pointIndex],
                              ),
                              ClusterChart.getMaxForCluster(
                                clusterData[pointData.pointIndex],
                              ),
                            ),
                          ),
                        ),
                      ),
                  onPointTapped: (pointData) => Navigator.of(context).push(
                        route(
                          RadiusChartView(
                            getTitle(
                              clusterData[pointData.pointIndex],
                            ),
                            subDataFutureFunction(
                              ClusterChart.getMinForCluster(
                                clusterData[pointData.pointIndex],
                              ),
                              ClusterChart.getMaxForCluster(
                                clusterData[pointData.pointIndex],
                              ),
                            ),
                          ),
                        ),
                      ),
                  legend: Legend(
                    isVisible: true,
                    iconHeight: 10,
                    width: Get.width.toString(),
                    height: (Get.height / 2).toString(),
                    iconWidth: 10,
                    position: LegendPosition.bottom,
                    toggleSeriesVisibility: false,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                // Renders radial bar chart
                DoughnutSeries<Cluster, String>(
                  innerRadius: '50%',
                  radius: '80%',
                  dataSource: clusterData,
                  xValueMapper: (data, _) => getTitle(data),

                  // yValueMapper: (data, _) => data.location.first,
                  yValueMapper: (data, _) => data.instances.length,
                  legendIconType: LegendIconType.circle,

                  dataLabelSettings: DataLabelSettings(isVisible: false),
                ),
              ]),
          leafOnClickData: (identifier) =>
              KeplerDatabase.db.getPlanetByName(identifier),
          leafChartBuilder: (context, cluster, leafDataFutureFunction) =>
              SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    iconHeight: 10,
                    width: Get.width.toString(),
                    height: (Get.height / 2).toString(),
                    iconWidth: 10,
                    position: LegendPosition.bottom,
                    toggleSeriesVisibility: false,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                RadialBarSeries<Instance, String>(
                  gap: '9%',
                  innerRadius: '0%',
                  radius: '100%',
                  pointRadiusMapper: (data, _) =>
                      "${data.location[0] / ClusterChart.getMaxForCluster(cluster) * 100}%",
                  dataSource: cluster.instances,
                  maximumValue: 100,
                  xValueMapper: (data, _) =>
                      "${data.id} - ${data.location[0]} days",
                  yValueMapper: (data, _) => 100,
                  dataLabelMapper: (data, _) => data.id,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: false,
                      labelPosition: ChartDataLabelPosition.inside),
                )
              ]),
        );
}

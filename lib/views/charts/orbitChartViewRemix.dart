import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/chartsController.dart';
import 'package:kepler/widgets/charts/orbitChart.dart';
import 'package:kepler/widgets/header/header.dart';

class OrbitChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
        init: ChartsController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
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
                  OrbitChart(title: "Smallest Planet Orbits (Days)", orderBy: "asc",),
                  OrbitChart(title: "Largest Planet Orbits (Years)", orderBy: "desc")
                ],
              ),
            ),
          );
        });
  }
}

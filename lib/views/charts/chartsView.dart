import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/utils/cupertinoPageRoute.dart';
import 'package:kepler/views/charts/orbitChartView.dart';
import 'package:kepler/views/charts/radiusChartView.dart';
import 'package:kepler/widgets/backgrounds/background.dart';
import 'package:kepler/widgets/cards/imageCard.dart';
import 'package:kepler/widgets/header/header.dart';

class ChartsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: ScreenHeader(
                  'Charts',
                  () => Navigator.of(context).pop(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                      ),
                      child: ColorsCard(
                        colorList: [Colors.blue[100], Colors.green[100]],
                        text:
                            "Orbit Size Ranking", //TODO - LOCALIZE - ORBIT SIZE RANKING
                        onTap: () {
                          Navigator.of(context).push(
                            route(
                              OrbitChartView(
                                "Orbit Size Ranking",
                                KeplerDatabase.db.getAllPlanetsOrbits(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                      ),
                      child: ColorsCard(
                        colorList: [Colors.blue[100], Colors.green[100]],
                        text:
                            "Radius Size Ranking", //TODO - LOCALIZE - ORBIT SIZE RANKING
                        onTap: () {
                          Navigator.of(context).push(
                            route(
                              RadiusChartView(
                                "Radius Size Ranking",
                                KeplerDatabase.db.getAllPlanetsRadius(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ScreenHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final Function onBack;

  ScreenHeader(this.title, this.onBack);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Header(title, onBack);
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant ScreenHeader oldDelegate) {
    return oldDelegate.title != this.title || oldDelegate.onBack != this.onBack;
  }
}

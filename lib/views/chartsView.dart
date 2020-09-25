import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/cupertinoPageRoute.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/views/charts/orbitChartView.dart';
import 'package:kepler/widgets/cards/imageCard.dart';

class ChartsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ///TODO: Refactor -  Using a SliverAppBar right now but I think this should be a SliverPersistent Header wrapped in MediaQuery.removePadding with a custom SliverPersistentHeaderDelegate see https://medium.com/flutter-community/flutter-increase-the-power-of-your-appbar-sliverappbar-c4f67c4e076f
          SliverAppBar(
            expandedHeight: Get.height / 5,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                string.text(
                  "charts",
                ),
                style: TextStyle(
                    fontFamily: "JosefinSans",
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                ),
                child: ImageCard(
                  image: 'assets/images/chartsbg.png',
                  text:
                      "Orbit Size Ranking", //TODO - LOCALIZE - ORBIT SIZE RANKING
                  onTap: () {
                    Navigator.of(context).push(
                      route(
                        OrbitChartView(),
                      ),
                    );
                  },
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

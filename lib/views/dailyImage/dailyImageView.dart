import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/dailyImageController.dart';
import 'package:kepler/controllers/planetController.dart';
import 'package:kepler/models/dailyImageData.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class DailyImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(PlanetController());
    return Container(
      width: Get.width,
      child: GetBuilder<DailyImageController>(
        init: new DailyImageController(),
        builder: (_) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: FutureBuilder<DailyImageData>(
              future: _.getImageOfTheDay(),
              builder: (BuildContext context,
                  AsyncSnapshot<DailyImageData> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Loading();
                  default:
                    if (snapshot.data.isNull) {
                      return Loading();
                    }
                    return CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40))),
                          automaticallyImplyLeading: false,
                          actions: [
                            IconButton(
                                icon: Icon(Icons.arrow_back), onPressed: null)
                          ],
                          stretch: true,
                          expandedHeight: 250,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: EdgeInsets.only(
                                top: 10.0, left: 10, right: 40, bottom: 10),
                            background: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Image.network(snapshot.data.url)),
                            title: Text(snapshot.data.title),
                            stretchModes: [
                              StretchMode.blurBackground,
                              StretchMode.fadeTitle,
                              StretchMode.zoomBackground
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(snapshot.data.explanation,
                                    style: TextStyle(
                                        fontFamily: "Roboto", fontSize: 20)),
                              ),
                            ),
                          ]),
                        )
                      ],
                    );
                }
              }),
        ),
      ),
    );
  }
}

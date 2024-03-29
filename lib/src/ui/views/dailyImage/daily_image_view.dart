import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/src/controllers/daily/daily_image_controller.dart';
import 'package:kepler/src/models/daily_image_data.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/progress/loading.dart';

class DailyImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: GetBuilder<DailyImageController>(
        init: new DailyImageController(),
        builder: (_) => Stack(
          children: [
            Background(),
            Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
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
                                    icon: Icon(Icons.arrow_back), onPressed: () => Get.back(canPop:true), color: Colors.white,)
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
                                    child: Image.network(snapshot.data.hdurl)),
                                title: Text(snapshot.data.title),
                                stretchModes: [
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
          ],
        ),
      ),
    );
  }
}

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
              builder: (BuildContext context,AsyncSnapshot<DailyImageData> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Loading();
                  default:
                    if(snapshot.data.isNull){
                      return Loading();
                    }
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            Container(
                              color: Theme.of(context).dialogBackgroundColor,
                              child: Header(snapshot.data.title,
                                  () => Navigator.pop(context)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child:Container(
                                height: Get.height / 2.5,
                                width: Get.width / 1.1,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(snapshot.data.hdurl))
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(20.0),
                            child: Text(snapshot.data.explanation,style:TextStyle(fontFamily: "Roboto", fontSize: 24.5))),
                      ],
                    );
                }
              }),
        ),
      ),
    );
  }
}

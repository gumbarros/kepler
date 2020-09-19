import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/starsController.dart';

class Star extends StatelessWidget {
  final double temperature;

  Star({@required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2.7,
      height: Get.width / 2.7,
      child: Stack(
        children: [
          FlareActor(
            "assets/flare/shine.flr",
            animation: "start",
            fit: BoxFit.fitHeight,
            color: StarsController.to.getStarColor(temperature).withOpacity(0.5),
          ),
          Center(
            child: Container(
              width: Get.width / 3.5,
              height: Get.width / 3.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(360)),
                shape: BoxShape.rectangle,
                color: StarsController.to.getStarColor(temperature),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

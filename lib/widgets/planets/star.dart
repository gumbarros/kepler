import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/starsController.dart';

class Star extends StatelessWidget {
  final double temperature;

  Star({@required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3.3,
      height: Get.width / 3.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(360)),
        shape: BoxShape.rectangle,
        color: StarsController.to.getStarColor(temperature),
      ),
    );
  }
}

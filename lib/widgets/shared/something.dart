import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Something extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: Get.height / 5,
            width: Get.width / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(360),
            )),
          )
        ],
      ),
    );
  }
}

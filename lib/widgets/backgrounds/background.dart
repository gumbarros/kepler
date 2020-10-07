import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Get.height * 0.14,
            left: Get.width * 0.56,
            child: Container(
              height: Get.height * 0.14,
              width: Get.width * 0.14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black45,
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.29,
            left: Get.width * 0.41,
            child: Container(
              height: Get.height * 0.12,
              width: Get.width * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.3,
            left: Get.width * 0.72,
            child: Container(
              height: Get.height * 0.09,
              width: Get.width * 0.09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: Get.height / 2.5,
                    width: Get.width / 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black26,
                          Colors.black12,
                        ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(360),
                          topRight: Radius.zero,
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: Get.height / 3,
                width: Get.width / 2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black12, Colors.black26]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(360),
                    )),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

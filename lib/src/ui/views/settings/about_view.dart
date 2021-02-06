import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
import 'package:kepler/src/ui/widgets/cards/about_card.dart';
import 'package:kepler/src/ui/widgets/header/header.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              children: [
                Header("about".tr,() {
                  Get.back(canPop:true);
                }),
                Container(
                  width: Get.width,
                  height: Get.height / 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AboutCard(
                        image: "assets/images/github.png",
                        title: "Developed at",
                        url: "https://www.github.com/gumbarros/kepler",
                      ),
                      AboutCard(
                        title: "Data by",
                        image: "assets/images/nasa.png",
                        url: "https://exoplanetarchive.ipac.caltech.edu/",
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

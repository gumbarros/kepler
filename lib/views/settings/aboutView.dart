import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/widgets/cards/aboutCard.dart';
import 'package:kepler/widgets/header/header.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Header(string.text("about"), () {
              Navigator.of(context).pop(context);
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
    );
  }
}

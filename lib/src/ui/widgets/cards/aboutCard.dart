import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutCard extends StatelessWidget {

  final String title;
  final String image;
  final String url;

  AboutCard({@required this.title,@required this.image, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async=>await launch(url),
      child: Column(children: [
        Text(
          title,
          style: TextStyle(fontFamily: "Roboto", fontSize: 22.5,),
          textAlign: TextAlign.center,
        ),
        Container(
          width: Get.width / 1.3,
          height: Get.height / 5,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image))),
        ),
      ],),
    );
  }
}

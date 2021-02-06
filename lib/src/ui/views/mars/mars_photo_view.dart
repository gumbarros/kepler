import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/models/mars_data.dart';
import 'package:kepler/src/models/rover_data.dart';
import 'package:kepler/src/ui/theme.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

class MarsPhotoView extends StatelessWidget {
  final MarsData photo = Get.arguments[0];
  final RoverData rover = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "${rover.name} - SOL ${photo.sol}",
            style: KeplerTheme.theme.textTheme.caption,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(Icons.share_outlined),
                onPressed: () {
                  Share.share(photo.imgSrc,
                      subject: "share_text_one".tr +
                          photo.sol.toString() + "of".tr + rover.name +
                          "share_text_two".tr);
                })
          ],
        ),
        body: Container(
          child: PhotoView(imageProvider: NetworkImage(photo.imgSrc)),
        ),
      ),
    );
  }
}

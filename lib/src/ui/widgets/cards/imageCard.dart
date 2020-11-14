import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ColorsCard extends StatelessWidget {
  final Function onTap;
  final String text;
  final List<Color> colorList;
  final Widget child;

  ColorsCard(
      {@required this.onTap, @required this.text, this.colorList, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            height: Get.height / 8,
            width: Get.width - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(colors: colorList)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontFamily: "JosefinSans",
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}

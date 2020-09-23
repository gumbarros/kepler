import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  MenuCard({@required this.icon, @required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4,
      width: Get.width / 3,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: Colors.white, size: 50),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

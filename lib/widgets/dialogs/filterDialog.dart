import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/starsController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/utils/keplerUtils.dart';
import 'package:kepler/widgets/forms/textField.dart';

class FilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StarsController>(
      init: StarsController(),
      builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: Get.height / 1,
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            margin: EdgeInsets.only(top: 66),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height / 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Column(children: [
                      Text(string.text("color")),
                      DropdownButton(
                          value: _.colorFilter,
                          style: TextStyle(),
                          onChanged: (value) {
                            _.colorFilter = value;
                            _.update();
                          },
                          items: KeplerUtils.colorDropdownItems)
                      ,
                    ],),
                    Column(children: [
                      Text(string.text("temperature") + " (K)"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                          Text(string.text("to")),
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                        ],
                      ),
                    ],),
                    Column(children: [
                      Text(string.text("age") + " (${string.text("million_years")})"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                          Text(string.text("to")),
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                        ],
                      ),
                    ],),
                    Column(children: [
                      Text(string.text("mass") + " (${string.text("solar_mass")})"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                          Text(string.text("to")),
                          Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                        ],
                      ),
                    ],),
                      Column(children: [
                        Text(string.text("radius") + " (${string.text("solar_radius")})"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                            Text(string.text("to")),
                            Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                          ],
                        ),
                      ],)
                  ],)
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(string.text('filter')),
                  onPressed: () {
                    _.update();
                    Get.back();
                  },
                ),
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/widgets/forms/textField.dart';

class FilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (conf) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: Get.height / 2,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height / 7,
                  child: Column(children: [
                    Text(string.text("temperature") + " (K)"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                        Text(string.text("to")),
                        Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),
                        Text(string.text("to")),
                        Container(width: Get.width / 4, child: KeplerTextField(textAlign: TextAlign.center,)),

                      ],
                    ),
                  ],)
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(string.text('save')),
                  onPressed: () {
                    conf.setLanguage(conf.lang);
                    Get.back();
                  },
                ),
              ],
            ),
          )),
    );
  }
}

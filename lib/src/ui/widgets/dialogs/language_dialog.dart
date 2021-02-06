import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/src/controllers/settings/settings_controller.dart';
import 'package:kepler/src/utils/kepler_utils.dart';

class LanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (conf)=> Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: Get.height / 4,
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
              borderRadius:
              BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: Get.height / 10,
                  width: Get.width / 1,
                  child: Center(
                    child:
                    DropdownButton(
                      value: conf.lang,
                      hint: Text("language".tr),
                      style: TextStyle(),
                      onChanged: (value) {
                        conf.lang = value;
                        conf.update();
                      },
                      items: KeplerUtils.languageDropdownItems,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('save'.tr),
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

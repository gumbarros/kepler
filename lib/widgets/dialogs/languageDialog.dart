import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/translations.dart';

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
            height: Get.height / 4.5,
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
                      hint: Text(string
                          .text("language")),
                      style: TextStyle(),
                      onChanged: (value) {
                        conf.lang = value;
                        conf.upd();
                      },
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          child: Text("English"),
                          value: "en",
                        ),
                        DropdownMenuItem(
                          child: Text(
                              "Brazilian Portuguese"),
                          value: "br",
                        ),
                        DropdownMenuItem(
                          child:
                          Text("Vietnamese"),
                          value: "vt",
                        ),
                        DropdownMenuItem(
                          child: Text("Hindi"),
                          value: "hi",
                        ),
                        DropdownMenuItem(
                          child: Text("German"),
                          value: "de",
                        ),
                        DropdownMenuItem(
                          child: Text("Polish"),
                          value: "pl",
                        ),
                      ],
                    ),
                  ),
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

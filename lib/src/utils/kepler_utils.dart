import 'package:flutter/material.dart';
import 'package:kepler/src/controllers/settings/settings_controller.dart';
import 'package:get/get.dart';
import 'package:kepler/src/models/enums/star_color.dart';

class KeplerUtils{

  ///Current languages: Brazilian Portuguese & English. We need to help to finish the others translations.
  static get languageDropdownItems => <DropdownMenuItem<String>>[
    DropdownMenuItem(
      child: Text("English"),
      value: "en",
    ),
    DropdownMenuItem(
      child: Text(
          "Brazilian Portuguese"),
      value: "pt",
    ),
    DropdownMenuItem(
      child: Text(
          "Swedish"),
      value: "sv",
    ),
     DropdownMenuItem(
       child:
       Text("Vietnamese"),
       value: "vi",
     ),
    // DropdownMenuItem(
    //   child: Text("Hindi"),
    //   value: "hi",
    // ),
    // DropdownMenuItem(
    //   child: Text("Telugu"),
    //   value: "te",
    // ),
    // DropdownMenuItem(
    //   child: Text("German"),
    //   value: "de",
    // ),
    // DropdownMenuItem(
    //   child: Text("Polish"),
    //   value: "pl",
    // ),
    // DropdownMenuItem(
    //   child: Text("Svenska"),
    //   value: "sv",
    // ),
  ];
  static get colorDropdownItems => <DropdownMenuItem<StarColor>>[
    DropdownMenuItem(
      child: Text("blue".tr),
      value: StarColor.BLUE,
    ),
    DropdownMenuItem(
      child: Text(
          "white".tr),
      value: StarColor.WHITE,
    ),
    DropdownMenuItem(
      child:
      Text("yellow".tr),
      value: StarColor.YELLOW,
    ),
    DropdownMenuItem(
      child: Text("orange".tr),
      value: StarColor.ORANGE,
    ),
    DropdownMenuItem(
      child: Text("red".tr),
      value: StarColor.RED,
    ),
  ];

  static void syncUpdate(String syncMessage, double percentage){
    SettingsController.to.syncMessage.value = syncMessage;
    SettingsController.to.syncPercentage.value = percentage;
  }
}


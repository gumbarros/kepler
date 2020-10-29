import 'package:flutter/material.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/enums/starColor.dart';

class KeplerUtils{
  static get languageDropdownItems => <DropdownMenuItem<String>>[
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
      value: "vn",
    ),
    DropdownMenuItem(
      child: Text("Hindi"),
      value: "hi",
    ),
    DropdownMenuItem(
      child: Text("Telugu"),
      value: "te",
    ),
    DropdownMenuItem(
      child: Text("German"),
      value: "de",
    ),
    DropdownMenuItem(
      child: Text("Polish"),
      value: "pl",
    ),
    DropdownMenuItem(
      child: Text("Svenska"),
      value: "sv",
    ),
  ];
  static get colorDropdownItems => <DropdownMenuItem<StarColor>>[
    DropdownMenuItem(
      child: Text(string.text("blue")),
      value: StarColor.BLUE,
    ),
    DropdownMenuItem(
      child: Text(
          string.text("white")),
      value: StarColor.WHITE,
    ),
    DropdownMenuItem(
      child:
      Text(string.text("yellow")),
      value: StarColor.YELLOW,
    ),
    DropdownMenuItem(
      child: Text(string.text("orange")),
      value: StarColor.ORANGE,
    ),
    DropdownMenuItem(
      child: Text(string.text("red")),
      value: StarColor.RED,
    ),
  ];

  static syncUpdate(String syncMessage, double percentage){
    print("${percentage*100}% - $syncMessage");
    SettingsController.to.syncMessage.value = syncMessage;
    SettingsController.to.syncPercentage.value = percentage;
  }
}

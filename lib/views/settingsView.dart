import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/pagesController.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/languageEntry.dart';
import 'package:kepler/widgets/header/header.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation fadeAnimation;
  AnimationController scaleController;
  Animation scaleAnimation;

  @override
  void initState() {
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(fadeController);
    fadeController.forward();
    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(scaleController);
    scaleController.forward();
    super.initState();
  }

  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (_) => Scaffold(
            body: SafeArea(
                child: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: Get.height / 400,
                  ),
                  Header("Settings", ()=>
                    PagesController.to.changeIndex(1)
                  ),
                  SizedBox(
                    height: Get.height / 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: ExpansionCard(
                      title: Text(
                        'Languages',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline4.color,
                        ),
                      ),
                      children: [
                        LanguageEntry(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 17,
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

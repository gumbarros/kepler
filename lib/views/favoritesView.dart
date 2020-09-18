import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/pagesController.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/languageEntry.dart';
import 'package:kepler/widgets/header/header.dart';

class FavoritesView extends StatefulWidget {
  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
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
        child: GetBuilder<FavoritesController>(
          init: FavoritesController(),
          builder: (_) => Scaffold(
            body: Center(
              child: Text(_.getAllPlanets().toString()),
            ),
          ),
        ),
      ),
    );
  }
}

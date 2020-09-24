import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kepler/controllers/chartsController.dart';

class ChartsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(
      init: ChartsController(),
      builder: (conf) => Scaffold(
        body: Container()
      ),
    );
  }
}

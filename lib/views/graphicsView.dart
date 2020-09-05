import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/widgets/header/header.dart';

class GraphicsView extends StatefulWidget {
  @override
  _GraphicsViewState createState() => _GraphicsViewState();
}

class _GraphicsViewState extends State<GraphicsView> with TickerProviderStateMixin {
  // ignore: unused_field
  Animation _fadeanimation;

  // ignore: unused_field
  Animation _scaleanimation;

  AnimationController _fadecontroller;

  AnimationController _scalecontroller;

  @override
  void initState() {
    _fadecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _fadeanimation = Tween<double>(begin: 0, end: 1).animate(_fadecontroller);

    _scalecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleanimation = Tween<double>(begin: 0.85, end: 1).animate(_scalecontroller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //Animation on Route Pop from back button
      onWillPop: () async {
        _fadecontroller.reverse();
        await _scalecontroller.reverse();
        return true;
      },
      child: Scaffold(
        body: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                Header("Graphics",
                    fadeController: _fadecontroller, scaleController: _scalecontroller)
              ],
            )),
      ),
    );
  }
}

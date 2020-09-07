import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/widgets/header/header.dart';

class GraphicsView extends StatefulWidget {
  @override
  _GraphicsViewState createState() => _GraphicsViewState();
}

class _GraphicsViewState extends State<GraphicsView>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          child: ListView(
            children: [
              Header(
                "Graphics",
              ),
              Text('Dummy'),
            ],
          )),
    );
  }
}

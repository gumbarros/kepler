import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/widgets/header/header.dart';
import 'package:kepler/widgets/progress/loading.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> with TickerProviderStateMixin {
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
    _scaleanimation =
        Tween<double>(begin: 0.85, end: 1).animate(_scalecontroller);
    _fadecontroller.forward();
    _scalecontroller.forward();
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
                "Test View",
              ),
              Container(
                width: Get.width,
                height: Get.height / 1.55,
                child: FutureBuilder(
                  future: API.getTestData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        print(snapshot.data);
                        if (snapshot.data == null) {
                          return Center(
                            child: Text(
                              string.text("no_planet"),
                              style: GoogleFonts.roboto(),
                            ),
                          );
                        }
                        return Text(snapshot.data.toString());
                      default:
                        return Center(child: Loading());
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphicsView extends StatefulWidget {
  @override
  _GraphicsViewState createState() => _GraphicsViewState();
}

class _GraphicsViewState extends State<GraphicsView>
    with TickerProviderStateMixin {
  Animation _fadeanimation;

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
      child: FadeTransition(
        opacity: _fadeanimation,
        child: ScaleTransition(
          scale: _scaleanimation,
          child: Scaffold(
            body: Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Graphics View',
                                style: GoogleFonts.josefinSans(fontSize: 50)),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () async {
                              _fadecontroller.reverse();
                              await _scalecontroller.reverse();
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 7,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

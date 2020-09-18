import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kepler/cupertinopageroute.dart';
import 'package:kepler/views/explore/starsView.dart';
import 'package:kepler/widgets/backgrounds/homeBackground.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation _scaleanimation;
  AnimationController _scalecontroller;

  void initState() {
    _scalecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _scaleanimation = Tween<double>(
      begin: 1,
      end: 0.97,
    ).animate(
      _scalecontroller,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.height / 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Kepler',
                                style: TextStyle(fontSize: 60),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Discover the universe',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _scalecontroller.forward();
                        await _scalecontroller.reverse();
                        Navigator.of(context).push(route(StarsView()));
                      },
                      child: ScaleTransition(
                        scale: _scaleanimation,
                        child: Container(
                          height: Get.height / 7,
                          width: Get.width - 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.darken),
                                  fit: BoxFit.fitWidth,
                                  image:
                                      AssetImage('assets/images/cardbg.jpg'))),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Stars',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'JosefinSans'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

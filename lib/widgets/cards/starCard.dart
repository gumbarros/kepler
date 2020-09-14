import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/controllers/starsController.dart';

class StarCard extends StatefulWidget {
  final Function onTap;
  final String text;
  final double temperature;
  StarCard({@required this.onTap, @required this.text, @required this.temperature});

  @override
  _StarCardState createState() => _StarCardState();
}

class _StarCardState extends State<StarCard> with TickerProviderStateMixin {
  Animation _scaleanimation;
  AnimationController _scalecontroller;

  @override
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
    return GestureDetector(
      onTap: () async {
        await _scalecontroller.forward();
        await _scalecontroller.reverse();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleanimation,
        child: Stack(
          children: [
            Container(
              height: Get.height / 8,
              width: Get.width - 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).primaryColor),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(alignment: Alignment.centerLeft, child: SizedBox()),
                ),
              ),
            ),
            Row(children: [
              Container(
                width: Get.width / 4.5,
                height: Get.width / 4.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360)),
                  boxShadow: [
                    BoxShadow(
                        color: StarsController.to.getStarColor(widget.temperature),
                        spreadRadius: 12.0,
                        offset: Offset(0, 0)),
                  ],
                  shape: BoxShape.rectangle,
                  color: StarsController.to.getStarColor(widget.temperature),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(widget.text),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

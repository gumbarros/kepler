import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kepler/widgets/universe/star.dart';

class StarCard extends StatefulWidget {
  final Function onTap;
  final String text;
  final int index;
  final double temperature;
  final double size;

  StarCard(
      {@required this.onTap,
      @required this.text,
      @required this.temperature,
      @required this.index,
      @required this.size});

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
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: Get.height / 8 + 50,
                width: Get.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                        alignment: Alignment.centerLeft, child: SizedBox()),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Hero(
                      tag: "star${widget.index}",
                      child: Star(
                          size: widget.size, temperature: widget.temperature)),
                  Expanded(child: SizedBox()),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          widget.text + "\n",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JosefinSans'),
                        ),
                      ),
                  ),

                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

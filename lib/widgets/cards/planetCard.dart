import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanetCard extends StatefulWidget {
  final Function onTap;
  final String text;
  final Widget child;
  final double width;
  final double height;

  PlanetCard(
      {@required this.onTap,
      @required this.text,
      this.child,
      this.height,
      this.width});

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<PlanetCard> with TickerProviderStateMixin {
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
        child: Container(
          height: widget.height,
          width: Get.width,
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${widget.text}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'JosefinSans'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

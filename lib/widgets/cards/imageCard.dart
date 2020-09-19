import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCard extends StatefulWidget {
  final Function onTap;
  final String text;
  final List<Color> colorList;
  final Widget child;
  final double width;
  final double height;
  final String image;

  ImageCard(
      {@required this.onTap,
      @required this.text,
        this.image,
      this.colorList,
      this.child,
      this.height,
      this.width});

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with TickerProviderStateMixin {
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
                  AssetImage('${widget.image}'))),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.text}',
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
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kepler/src/controllers/explore/starsController.dart';

class Star extends StatelessWidget {
  final double temperature;
  final double size;

  Star({@required this.temperature, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 1.3,
      height: size * 1.3,
      child: Stack(
        children: [
          FlareActor(
            "assets/flare/shine.flr",
            animation: "start",
            fit: BoxFit.fitHeight,
            color: StarsController.to.getStarColor(temperature).withOpacity(0.5),
          ),
          Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(360)),
                shape: BoxShape.rectangle,
                color: StarsController.to.getStarColor(temperature),
              ),
            ),
          ),
          FlareActor(
            "assets/flare/pops.flr",
            animation: "start",
            fit: BoxFit.fitHeight,
            color: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}

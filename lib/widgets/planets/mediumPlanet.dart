import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class MediumPlanet extends StatelessWidget {
  final Color color;

  MediumPlanet({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(360),
        ),
      ),
      child: Stack(
        children: [
          Container(
            child: FlareActor(
              'assets/flare/land.flr',
              color: color.withGreen(255),
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: FlareActor(
              'assets/flare/clouds.flr',
              animation: 'start',
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}

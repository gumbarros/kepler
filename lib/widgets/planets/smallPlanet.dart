import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SmallPlanet extends StatelessWidget {
  final Color color;
  final double size;
  final int index;

  SmallPlanet({@required this.color, @required this.size, @required this.index});

  @override
  Widget build(BuildContext context) {
    print('main smallPlanet$index');
    return Container(
      child: Hero(
        tag: 'smallPlanet$index',
        child: Container(
          height: size,
          width: size,
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
                  'assets/flare/holes.flr',
                  fit: BoxFit.fitHeight,
                  color: color.withGreen(255),
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
        ),
      ),
    );
  }
}

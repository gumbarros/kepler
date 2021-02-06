import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class GasPlanet extends StatelessWidget {
  final String name;
  final Color color;
  final double size;
  final int index;

  GasPlanet(this.name,{@required this.color, @required this.size, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: name,
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
                'assets/flare/gas.flr',
                color: Colors.brown[300],
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SmallPlanet extends StatelessWidget {
  final Color color;

  SmallPlanet({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
            Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 65,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  right: 15,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 70,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 40,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(360),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 20,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(360),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 55,
              left: 50,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(360),
                    topLeft: Radius.circular(360),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(360),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 25,
              child: Container(
                height: 20,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    topLeft: Radius.circular(360),
                    bottomLeft: Radius.circular(360),
                    bottomRight: Radius.circular(360),
                  ),
                ),
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
    );
  }
}

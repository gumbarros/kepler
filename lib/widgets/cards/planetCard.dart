import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/models/planets.dart';
import 'package:slimy_card/slimy_card.dart';

class PlanetCard extends StatelessWidget {
  final List<PlanetData> planets;
  final int index;
  PlanetCard({@required this.planets, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SlimyCard(
        width: Get.width / 1.3,
        topCardHeight: Get.height / 3,
        color: Theme.of(context).primaryColor,
        bottomCardHeight: 200,
        borderRadius: 15,
        topCardWidget: Text(
          planets[index].planetName,
          style: GoogleFonts.roboto(fontSize: 26.5),
        ),
        // To prevent overflow, use wrap
        bottomCardWidget: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Star: ${planets[index].star}",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "Orbital Period: ${planets[index].orbitalPeriod.truncate()} days",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "Mass: ${planets[index].jupiterMass.isNull ? 'Unknown' : planets[index].jupiterMass.toString() + ' Jupiter'} ",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "Density: ${planets[index].density.isNull ? 'Unknown' : planets[index].density.toString() + '  g/cm³'}",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "Radius: ${planets[index].radius.isNull ? 'Unknown' : planets[index].radius.toString() + '  Jupiter Radius'} ",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
          ],
        ),
      ),
    );
  }
}

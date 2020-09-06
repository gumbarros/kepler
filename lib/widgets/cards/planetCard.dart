import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kepler/locale/translations.dart';
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
          style: GoogleFonts.robotoCondensed(fontSize: 26.5),
        ),
        // To prevent overflow, use wrap
        bottomCardWidget: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "${string.text("star")}: ${planets[index].star.isNull ? 'Unknown' : planets[index].star}",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "${string.text("orbital_period")}: ${planets[index].orbitalPeriod.isNull ? "Unknown" : planets[index].orbitalPeriod.truncate()} ${string.text("days")}",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "${string.text("mass")}: ${planets[index].jupiterMass.isNull ? 'Unknown' : planets[index].jupiterMass.toString() + ' Jupiter'} ",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "${string.text("density")}: ${planets[index].density.isNull ? 'Unknown' : planets[index].density.toString() + '  g/cm³'}",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
            Text(
              "${string.text("radius")}: ${planets[index].radius.isNull ? 'Unknown' : planets[index].radius.toString() + string.text("jupiter_radius")} ",
              style: GoogleFonts.roboto(fontSize: 18.5),
            ),
          ],
        ),
      ),
    );
  }
}

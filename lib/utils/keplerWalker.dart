import 'package:flutter/material.dart';
import 'package:kepler/database/database.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/utils/cupertinoPageRoute.dart';
import 'package:kepler/views/explore/planetsView.dart';

class KeplerWalker {
  static goToPlanetScreenForPlanetNamed(BuildContext context, String planetName) async {
      final PlanetData planet =  await KeplerDatabase.db.getPlanetByName(planetName);
      Navigator.of(context).push(route(PlanetView(planet, index: planet.hashCode,),),);
  }
}
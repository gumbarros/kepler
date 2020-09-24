import 'package:get/get.dart';

class PlanetData {
  String planetName;
  double orbitalPeriod;
  String star;
  double jupiterMass;
  double density;
  double radius;
  int discoveryMethod;
  String telescope;
  int numOfPlanetsSystem;
  double bband;
  double vband;
  double bmvj;

  PlanetData(
      {this.planetName,
      this.orbitalPeriod,
      this.star,
      this.jupiterMass,
      this.density,
      this.radius,
      this.discoveryMethod,
      this.telescope,
      this.numOfPlanetsSystem});

  PlanetData.fromMap(Map<String, dynamic> map) {
    planetName = map['pl_name'];
    orbitalPeriod = map['pl_orbper'].toString().isNullOrBlank ? 0.0 : map['pl_orbper'];
    star = map['hostname'];
    jupiterMass = map['pl_bmassj'].toString().isNullOrBlank ? 0.0 : map['pl_bmassj'];
    density = map['pl_dens'].toString().isNullOrBlank ? 0.0 : map['pl_dens'];
    radius = map['pl_radj'].toString().isNullOrBlank ? 0.0 : map['pl_radj'];
    discoveryMethod = map['pl_disc'];
    telescope = map['pl_telescope'];
    bband = map['sy_jmag'].toString().isNullOrBlank ? 0.0 : map['sy_bmag'];
    vband = map['sy_kmag'].toString().isNullOrBlank ? 0.0 : map['sy_vmag'];
    bmvj = (bband - vband).abs();
  }
}

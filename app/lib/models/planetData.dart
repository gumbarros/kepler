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
  double jmk2;

  PlanetData(
      {this.planetName,
      this.orbitalPeriod,
      this.star,
      this.jupiterMass,
      this.density,
      this.radius,
      this.discoveryMethod,
      this.telescope,
      this.numOfPlanetsSystem, this.jmk2});

  PlanetData.fromMap(Map<String, dynamic> map) {
    planetName = map['pl_name'];
    orbitalPeriod = map['pl_orbper'];
    star = map['pl_hostname'];
    jupiterMass = map['pl_bmassj'];
    density = map['pl_dens'];
    radius = map['pl_rads'];
    discoveryMethod = map['pl_disc'];
    telescope = map['pl_telescope'];
    numOfPlanetsSystem = map['pl_pnum'];
    jmk2 = map['st_jmk2'] ?? 0.0;
  }
}

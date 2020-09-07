class PlanetData {
  String planetName;
  double orbitalPeriod;
  String star;
  double jupiterMass;
  double density;
  double radius;
  int discoveryMethod;
  String telescope;

  PlanetData({
    this.planetName,
    this.orbitalPeriod,
    this.star,
    this.jupiterMass,
    this.density,
    this.radius,
    this.discoveryMethod,
    this.telescope,
  });

  PlanetData.fromMap(Map<String, dynamic> json) {
    planetName = json['pl_name'];
    orbitalPeriod = json['pl_orbper'];
    star = json['pl_hostname'];
    jupiterMass = json['pl_bmassj'];
    density = json['pl_dens'];
    radius = json['pl_radj'];
    discoveryMethod = json['pl_disc'];
    telescope = json['pl_telescope'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pl_name'] = this.planetName;
    data['pl_orbper'] = this.orbitalPeriod;
    data['pl_hostname'] = this.star;
    data['pl_bmassj'] = this.jupiterMass;
    data['pl_dens'] = this.density;
    data['pl_radj'] = this.radius;
    data['pl_disc'] = this.discoveryMethod;
    data['pl_telescope'] = this.telescope;
    return data;
  }
}

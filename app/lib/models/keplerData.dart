class KeplerData {
  String plName;
  String hostname;
  String discYear;
  String plOrbper;
  String plRadj;
  String plMassj;
  String plDens;
  String stTeff;
  String stRad;
  String syKmag;

  KeplerData(
      {this.plName,
        this.hostname,
        this.discYear,
        this.plOrbper,
        this.plRadj,
        this.plMassj,
        this.plDens,
        this.stTeff,
        this.stRad,
        this.syKmag});

  KeplerData.fromJson(Map<String, dynamic> json) {
    plName = json['pl_name'];
    hostname = json['hostname'];
    discYear = json['disc_year'];
    plOrbper = json['pl_orbper'];
    plRadj = json['pl_radj'];
    plMassj = json['pl_massj'];
    plDens = json['pl_dens'];
    stTeff = json['st_teff'];
    stRad = json['st_rad'];
    syKmag = json['sy_kmag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pl_name'] = this.plName;
    data['hostname'] = this.hostname;
    data['disc_year'] = this.discYear;
    data['pl_orbper'] = this.plOrbper;
    data['pl_radj'] = this.plRadj;
    data['pl_massj'] = this.plMassj;
    data['pl_dens'] = this.plDens;
    data['st_teff'] = this.stTeff;
    data['st_rad'] = this.stRad;
    data['sy_kmag'] = this.syKmag;
    return data;
  }
}
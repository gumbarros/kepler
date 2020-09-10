class StarData {
  String name;
  double temperature;
  double radius;
  double jmk2;

  StarData.fromMap(Map<String, dynamic> map) {
    name = map['pl_hostname'];
    temperature = map['st_teff'];
    radius = map['st_rad'] ?? 1.0;
    jmk2 = map['jmk2'] ?? 0.0;
  }
}

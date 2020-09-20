class StarData {
  String name;
  double temperature;
  double radius;


  StarData({this.name, this.temperature, this.radius});

  StarData.fromMap(Map<String, dynamic> map) {
    name = map['pl_hostname'];
    temperature = map['st_teff'];
    radius = map['st_rad'] ?? 1.0;
  }
}

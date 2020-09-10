class StarData {
  String name;
  double temperature;

  StarData.fromMap(Map<String, dynamic> map) {
    name = map['pl_hostname'];
    temperature = map['st_teff'];
  }
}

import 'package:get/get.dart';

class StarData {
  String name;
  double temperature;
  double radius;

  StarData({this.name, this.temperature, this.radius});

  StarData.fromMap(Map<String, dynamic> map) {
    this.name = map['hostname'];
    this.temperature =  map['st_teff'].toString().isNullOrBlank ? 0.0 : map['st_teff'];
    this.radius = map['st_rad'].toString().isNullOrBlank ? 0.0 : map['st_rad'];
  }
}

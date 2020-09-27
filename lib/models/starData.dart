import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'hive/starData.g.dart';

@HiveType(typeId:1)
class StarData {
  @HiveField(0)
  String name;
  @HiveField(1)
  double temperature;
  @HiveField(2)
  double radius;
  @HiveField(3)
  double mass;
  @HiveField(4)
  double age;

  StarData();

  StarData.fromMap(Map<String, dynamic> map) {
    this.name = map['hostname'];
    this.temperature =  map['st_teff'].toString().isNullOrBlank ? 0.0 : map['st_teff'];
    this.radius = map['st_rad'].toString().isNullOrBlank ? 0.0 : map['st_rad'];
    this.mass = map['st_mass'].toString().isNullOrBlank ? 0.0 : map['st_mass'];
    this.age = map['st_age'].toString().isNullOrBlank ? 0.0 : map['st_age'];
  }
}

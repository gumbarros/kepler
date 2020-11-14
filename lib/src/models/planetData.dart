import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kepler/src/models/universeData.dart';
part 'hive/planetData.g.dart';

@HiveType(typeId: 0)
class PlanetData extends UniverseData{
  @HiveField(0)
  String planetName;
  @HiveField(1)
  double orbitalPeriod;
  @HiveField(2)
  String star;
  @HiveField(3)
  double jupiterMass;
  @HiveField(4)
  double density;
  @HiveField(5)
  double radius;
  @HiveField(6)
  int discoveryMethod;
  @HiveField(7)
  String telescope;
  @HiveField(8)
  int numOfPlanetsSystem;
  @HiveField(9)
  double bband;
  @HiveField(10)
  double vband;
  @HiveField(11)
  double bmvj;
  @HiveField(12)
  int id;
  @override
  PlanetData();

  @override
  PlanetData.fromMap(Map<String, dynamic> map) {
    id=map['id'];
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
    bmvj = ((bband.isNullOrBlank ? 0.0 : bband) - (vband.isNullOrBlank ? 0.0 : vband)).abs();
  }
}

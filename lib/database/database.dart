import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/utils/keplerUtils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/planetData.dart';

class KeplerDatabase {
  KeplerDatabase._();
  static final KeplerDatabase db = KeplerDatabase._();

  final String _table = "tb_kepler";
  final String _createTable = """CREATE TABLE tb_kepler(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  pl_name TEXT,
                  hostname TEXT,
                  disc_year INT,
                  pl_orbper REAL,
                  pl_radj REAL,
                  pl_bmassj REAL,
                  pl_dens REAL,
                  st_teff REAL,
                  st_rad REAL,
                  st_mass REAL,
                  st_age REAL,
                  sy_bmag REAL,
                  sy_vmag REAL
                  )""";

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "kepler.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
    });
  }

  Future<void> dropTable() async{
    Database db = await database;
    db.execute("DROP TABLE IF EXISTS $_table");
  }

  Future<bool> updateData() async {
    try {
      Database db = await database;
      await API.getAllData().then((data) async {
        final Batch batch = db.batch();
        batch.execute("DROP TABLE IF EXISTS $_table");
        KeplerUtils.syncUpdate(string.text("creating_table"), 0.50);
        batch.execute(_createTable);
        KeplerUtils.syncUpdate(string.text("inserting_data"), 0.60);
        data.forEach((item) {
          batch.insert(_table, item);
        });
        KeplerUtils.syncUpdate(string.text("commit_data"), 0.7);
        await batch.commit(noResult: true);
        KeplerUtils.syncUpdate(string.text("finishing"), 0.9);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<PlanetData> getPlanetByName(String name)async{
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      "tb_kepler",
      where:
      "pl_name like '%$name%'",
    );
    final planets = data
        .map((Map<String, dynamic> planet) => PlanetData.fromMap(planet))
        .toList();
    return planets[0];
  }

  Future<List<StarData>> getAllStars({
    @required String temperature,

    @required String ageFrom,
    @required String ageTo,

    @required String massFrom,
    @required String massTo,

    @required String radiusFrom,
    @required String radiusTo,
  }) async {
    Database db = await database;

    ///Here we will develop the where logic with a .NET like StringBuilder
    final StringBuffer where = new StringBuffer();

    if(!temperature.isNullOrBlank || !ageFrom.isNullOrBlank || !ageTo.isNullOrBlank || !massFrom.isNullOrBlank || !massTo.isNullOrBlank || !radiusFrom.isNullOrBlank || !radiusTo.isNullOrBlank){

      ///Color / Temperature
      if(!temperature.isNullOrBlank){
        where.writeln(temperature + " AND st_teff != '' AND ");
      }

      ///AGE
      if(!ageFrom.isNullOrBlank && !ageTo.isNullOrBlank){
        where.writeln("st_age >=" + ageFrom + " AND st_age <=" + ageTo + " AND st_age != '' AND ");
      }

      else if(!ageFrom.isNullOrBlank && ageTo.isNullOrBlank){
        where.writeln("st_age >=" + ageFrom+ " AND st_age != '' AND ");
      }

      else if(ageFrom.isNullOrBlank && !ageTo.isNullOrBlank){
        where.writeln("st_age <=" + ageTo+ " AND st_age != '' AND ");
      }

      ///MASS
      if(!massFrom.isNullOrBlank && !massTo.isNullOrBlank){
        where.writeln("st_mass >=" + massFrom + " AND st_mass <=" + massTo+ " AND st_mass != '' AND ");
      }

      else if(!massFrom.isNullOrBlank && massTo.isNullOrBlank){
        where.writeln("st_mass >=" + massFrom+ " AND st_mass != '' AND ");
      }

      else if(massFrom.isNullOrBlank && !massTo.isNullOrBlank){
        where.writeln("st_mass <=" + massTo+ " AND st_mass != '' AND ");
      }

      ///RADIUS
      if(!radiusFrom.isNullOrBlank && !radiusTo.isNullOrBlank){
        where.writeln("st_rad >=" + radiusFrom + " AND st_rad <=" + radiusTo+ " AND st_rad != '' AND ");
      }

      else if(!radiusFrom.isNullOrBlank && radiusTo.isNullOrBlank){
        where.writeln("st_rad >=" + radiusFrom+ " AND st_rad != '' AND ");
      }

      else if(radiusFrom.isNullOrBlank && !radiusTo.isNullOrBlank){
        where.writeln("st_rad <=" + radiusTo+ " AND st_rad != '' AND ");
      }

      where.writeln("1=1");
    }

    print("-=- Query Where -=-");
    print(where.toString());

    final List<Map<String, dynamic>> data = await db.query(_table,
        columns: ["id","hostname", "st_teff", "st_rad", "st_mass", "st_age"],
        where: where.isEmpty ? null : where.toString(),
        groupBy: "hostname",
                distinct: true);
    final stars = data
        .map((Map<String, dynamic> star) => StarData.fromMap(star))
        .toList();
    return stars.cast<StarData>();
  }

  Future<List<PlanetData>> getPlanetsOrbitsBetween(lower, upper) async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      _table,
      columns: ["pl_name", "pl_orbper"],
      orderBy: "pl_orbper desc",
      where:
          "pl_orbper IS NOT NULL and pl_orbper != '' and pl_orbper >= $lower and pl_orbper <= $upper",
    );
    final planets = data
        .map((Map<String, dynamic> planet) => PlanetData.fromMap(planet))
        .toList();
    return planets;
  }

  Future<List<PlanetData>> getAllPlanetsOrbits() async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      "tb_kepler",
      columns: ["pl_name", "pl_orbper"],
      orderBy: "pl_orbper desc",
      where: "pl_orbper IS NOT NULL and pl_orbper != ''",
    );
    final planets = data
        .map((Map<String, dynamic> planet) => PlanetData.fromMap(planet))
        .toList();
    // planets.forEach((PlanetData planet) {
    //   if(planet)
    // });
    return planets;
  }

  Future<List<PlanetData>> getPlanetsOrbits(
    String orderBy, {
    int limit = 6,
  }) async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query("tb_kepler",
        columns: ["pl_name", "pl_orbper"],
        orderBy: "pl_orbper " + orderBy,
        where: "pl_orbper IS NOT NULL and pl_orbper != ''",
        limit: limit);
    final planets = data
        .map((Map<String, dynamic> planet) => PlanetData.fromMap(planet))
        .toList();
    // planets.forEach((PlanetData planet) {
    //   if(planet)
    // });
    return planets;
  }

  Future<List<PlanetData>> getSolarSystemPlanets(String star) async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query("tb_kepler",
        columns: [
          "id",
          "hostname",
          "pl_name",
          "disc_year",
          "pl_orbper",
          "pl_radj",
          "pl_bmassj",
          "pl_dens",
          "sy_bmag",
          "sy_vmag"
        ],
        where: "hostname='$star'");
    final planets = data
        .map((Map<String, dynamic> star) => PlanetData.fromMap(star))
        .toList();
    return planets.cast<PlanetData>();
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}

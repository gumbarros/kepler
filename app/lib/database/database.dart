import 'package:json_async/json_async.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/models/starData.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

class KeplerDatabase {
  KeplerDatabase._();
  static final KeplerDatabase db = KeplerDatabase._();

  final String starTable = "TB_STARS";

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
          await db.execute(
              """CREATE TABLE tb_kepler("
                  id INTEGER PRIMARY KEY,
                  pl_name TEXT,
                  hostname TEXT,
                  disc_year INT,
                  pl_orbper REAL,
                  pl_radj REAL,
                  pl_massj REAL,
                  pl_dens REAL,
                  st_teff REAL,
                  st_rad REAL,
                  sy_kmag REAL
                  )""");
        });
  }

  // Future<List<StarData>> getAllStars() async {
  //   Database db = await database;
  //   List<Map<String, dynamic>> data = await db.query(starTable);
  //   List<StarData> stars = data.map((star) => StarData.fromMap(star));
  //   return stars;
  // }

  Future<void> updateData()async{
    Database db = await database;
    final List data = await API.getAllData();
    data.forEach((item) async {
      await db.insert(starTable, item);
    });
    close();
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
import 'package:json_async/json_async.dart';
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
          "CREATE TABLE tb_star(st_id INTEGER PRIMARY KEY, pl_hostname TEXT, "
          "st_teff REAL, st_rad REAL)");
      final String data = await rootBundle.loadString('database/data.json');
      final List<Map<String, dynamic>> starsData = await jsonDecodeAsync(data);
      starsData.forEach((Map<String, dynamic> star) async {
        await db.insert(starTable, star);
      });
    });
  }

  Future<List<StarData>> getAllStars() async {
    Database db = await database;
    List<Map<String, dynamic>> data = await db.query(starTable);
    List<StarData> stars = data.map((star) => StarData.fromMap(star));
    return stars;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}

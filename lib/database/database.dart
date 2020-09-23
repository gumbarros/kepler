import 'package:json_async/json_async.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/models/starData.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

class KeplerDatabase {
  KeplerDatabase._();
  static final KeplerDatabase db = KeplerDatabase._();

  final String starTable = "tb_kepler";

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
      await db.execute("""CREATE TABLE tb_kepler(
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

  Future<bool> updateData() async {
    try{
      Database db = await database;
      await API.getAllData().then((data) async{
        final batch = db.batch();
        batch.rawDelete("delete from tb_kepler");
        data.forEach((item) async {
          print(item);
          batch.insert("tb_kepler", item);
        });
        await batch.commit(noResult: true).then((value)=>print("AEEEEEEE"));
      });
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<List<StarData>> getAllStars() async{
    Database db = await database;
    final List<Map<String, dynamic>>data = await db.query("tb_kepler", columns: ["hostname","st_teff","st_rad"]);
    final stars = data.map(( Map<String, dynamic>star) => StarData.fromMap(star)).toList();
    print(stars); //Prints nothing :(
    return stars.cast<StarData>();
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}

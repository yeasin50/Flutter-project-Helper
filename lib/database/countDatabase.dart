import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'count_model.dart';

class CDatabase {
  static const tableCount = "sampleCount1";
  static Database _database;
  static int get _version => 1;

  static final String counter = 'counter';

  static Future<void> init1() async {
    if (_database != null) {
      log("Dba found");
      return;
    }
    try {
      var database = await getDatabasesPath();
      String _path = p.join(database, "sampleCount");
      _database =
          await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {}
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableCount (id INTEGER PRIMARY KEY AUTOINCREMENT, $counter STRING)');
    log("onCreat DB");
  }

  static Future<int> insert(Count model1) async {
    int result = await _database.insert(tableCount, model1.toMap());

    return result;
  }

  static Future<List<Count>> getCounts() async {
    var mapDB = await _database.query(tableCount, columns: ["id", "$counter"]);

    List<Count> counters = List<Count>();

    if (mapDB.isEmpty) {
      log("Empty DB");
      return counters;
    } else {
      // await mapDB.forEach((item) {
      //   Count c = Count.fromMapObject(item);
      //   counters.add(c);
      // });
      counters = mapDB.map((data) => Count.fromMapObject(data)).toList();
      return counters;
    }
  }
}

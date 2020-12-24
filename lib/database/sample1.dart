import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

final String ID = "_id";
final String Item = "_item";
final String Value = "_value";

class Model1 {
  int id;
  String item;
  String value;

  Model1(this.id, this.item, this.value);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ID: id,
      Item: item,
      Value: value,
    };
    return map;
  }
}

abstract class DB1 {
  static const TableSample1 = "sample1";
  static Database _database;
  static int get _version => 1;

  static Future<void> init1() async {
    if (_database != null) {
      log("Dba found");
      return;
    }
    try {
      var database = await getDatabasesPath();
      String _path = p.join(database, "sample1");
      _database =
          await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TableSample1 ($ID INTEGER PRIMARY KEY, $Item STRING, $Value STRING)');
    log("onCreat DB");
  }

  static Future<void> insert(Model1 model1) async {
    int result = await _database.insert(TableSample1, model1.toMap());
    print(result);
  }
}

main(List<String> args) {
  DB1.init1();

  Model1 model = Model1(1, "banana", "123");
  print(DB1.insert(model));
}

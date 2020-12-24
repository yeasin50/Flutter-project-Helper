import 'dart:core';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../jsonFormating/radiojsonC.dart';
import 'package:path/path.dart' as path;

abstract class DatabaseHelper {
  static const String ID = 'id';
  static const String RadioName = 'radioName';
  static const String RadioUrl = 'radioUrl';
  static const String RadioDesc = 'radioDesc';
  static const String RadioShortDesc = 'radioShortDesc';
  static const String RadioWebsite = 'radioWebsite';
  static const String RadioPic = 'radioPic';

  static const String RadioTable = "radioTable";

  static Database _database;
  static int get _version => 1;

  //init DataBase
  static Future<void> init() async {
    log("initial Database");
    if (_database != null) {
      log("returning Existing DataBase");
      return;
    }

    //create new DataBase
    try {
      var databasePath = await getDatabasesPath();
      String _path = path.join(databasePath, "radioData");
      _database =
          await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex.toString());
    }
  }

// onCreate Database, single database for app
  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $RadioTable ($ID INTEGER PRIMARY KEY, $RadioName STRING, $RadioUrl STRING, $RadioDesc STRING, $RadioWebsite STRING, $RadioPic STRING)');
    log("DB created..");
  }
}

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final _databaseName = "zhao.calculator.db";
  static final _databaseVersion = 1;
  static final _maxCount = 10;

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableHistory (
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnExpression TEXT NOT NULL,
                $columnResult TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(HistoryData data) async {
    getCount().then((count) {
      if (count == _maxCount) {
        deleteOldestData();
      }
    });

    Database db = await database;
    int id = await db.insert(tableHistory, data.toMap());
    return id;
  }

  Future<List> queryAll() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM $tableHistory");
    return maps.toList();
  }

  Future<int> getCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableHistory'));
  }

  Future<int> deleteOldestData() async {
    Database db = await database;
    return db.rawDelete(
        "DELETE FROM $tableHistory WHERE $columnId IN (SELECT $columnId FROM $tableHistory ORDER BY $columnId ASC LIMIT 1)");
  }

  Future close() async {
    Database db = await database;
    return db.close();
  }
}

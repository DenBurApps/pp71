import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:sqflite/sqflite.dart';

class CleintDatabaseHelper {
  static final CleintDatabaseHelper _instance = CleintDatabaseHelper._internal();

  factory CleintDatabaseHelper() {
    return _instance;
  }

  CleintDatabaseHelper._internal();
  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "cleints.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE cleints (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          surname TEXT,
          phone TEXT,
          email TEXT,
          notes TEXT,
          orders TEXT
        )
      ''');
      
      },
    );
  }
}


class CleintDataSource {
  static final CleintDataSource _instance = CleintDataSource._internal();

  factory CleintDataSource() {
    return _instance;
  }

  CleintDataSource._internal();

  Future<void> deleteHabits(int id) async {
    try {
      Database db = await CleintDatabaseHelper().initDatabase();

      await db.delete('cleints', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }

  Future<void> updateCleint(Cleint cleint) async {
   
    Database db = await CleintDatabaseHelper().initDatabase();

    await db.update('cleints', cleint.toMap(),
        where: 'id = ?', whereArgs: [cleint.id]);
  }

  Future<void> insertCleint(Cleint cleint) async {
     print(cleint);
    try {
      Database db = await CleintDatabaseHelper().initDatabase();
      await db.insert('cleints', cleint.toMap());
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  Future<List<Cleint>> getAllCleint() async {
    try {
      Database db = await CleintDatabaseHelper().initDatabase();
      List<Map<String, dynamic>> rows = await db.query('cleints');
      return rows.map((row) => Cleint.fromMap(row)).toList();
    } catch (e) {
      return [];
    }
  }
}

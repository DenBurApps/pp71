import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp71/core/models/cleint.dart';
import 'package:sqflite/sqflite.dart';

class ClientDatabaseHelper {
  static final ClientDatabaseHelper _instance = ClientDatabaseHelper._internal();

  factory ClientDatabaseHelper() {
    return _instance;
  }

  ClientDatabaseHelper._internal();
  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "clients.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE clients (
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


class ClientDataSource {
  static final ClientDataSource _instance = ClientDataSource._internal();

  factory ClientDataSource() {
    return _instance;
  }

  ClientDataSource._internal();

  Future<void> deleteHabits(int id) async {
    try {
      Database db = await ClientDatabaseHelper().initDatabase();

      await db.delete('clients', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }

  Future<void> updateClient(Client client) async {
   
    Database db = await ClientDatabaseHelper().initDatabase();

    await db.update('clients', client.toMap(),
        where: 'id = ?', whereArgs: [client.id]);
  }

  Future<void> insertClient(Client client) async {
    
    try {
      Database db = await ClientDatabaseHelper().initDatabase();
      await db.insert('clients', client.toMap());
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  Future<List<Client>> getAllClient() async {
    try {
      Database db = await ClientDatabaseHelper().initDatabase();
      List<Map<String, dynamic>> rows = await db.query('clients');
      return rows.map((row) => Client.fromMap(row)).toList();
    } catch (e) {
      return [];
    }
  }
}

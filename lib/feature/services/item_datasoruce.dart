import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp71/core/models/item.dart';
import 'package:sqflite/sqflite.dart';

class ItemDatabaseHelper {
  static final ItemDatabaseHelper _instance = ItemDatabaseHelper._internal();

  factory ItemDatabaseHelper() {
    return _instance;
  }

  ItemDatabaseHelper._internal();
  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "item.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            desc TEXT,
            photos TEXT,
            deadline INTEGER,
            materials TEXT 
          )
        ''');

        await db.execute('''
          CREATE TABLE materials (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item_id INTEGER,
            name TEXT,
            cost REAL
          )
        ''');
      },
    );
  }
}

class ItemDataSource {
  static final ItemDataSource _instance = ItemDataSource._internal();

  factory ItemDataSource() {
    return _instance;
  }

  ItemDataSource._internal();

  Future<void> addItem(Item item) async {
    Database database = await ItemDatabaseHelper().initDatabase();

    // Insert the item details
    int itemId = await database.insert('items', item.toMap());

    // Insert materials associated with the item
    for (var material in item.materials) {
      await database.insert('materials', {
        'item_id': itemId,
        'name': material.name,
        'cost': material.cost,
      });
    }
  }

  Future<List<Item>> getItems() async {
    Database database = await ItemDatabaseHelper().initDatabase();
    //  await database.delete('items');
    List<Map<String, dynamic>> maps = await database.query('items');

    List<Item> items = [];
    for (var map in maps) {
      List<Map<String, dynamic>> materialMaps = await database
          .query('materials', where: 'item_id = ?', whereArgs: [map['id']]);

      List<Materials> materials = materialMaps
          .map((materialMap) => Materials.fromMap(materialMap))
          .toList();

      items.add(Item(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        desc: map['desc'],
        photos: List<String>.from(jsonDecode(map['photos'])),
        deadline: map['deadline'],
        materials: materials,
      ));
    }

    return items;
  }

  Future<void> deleteItem(int id) async {
    Database database = await ItemDatabaseHelper().initDatabase();
    await database.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Also delete associated materials
    await database.delete(
      'materials',
      where: 'item_id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateItem(Item item) async {
    Database database = await ItemDatabaseHelper().initDatabase();
     await database.update('items', item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }
}

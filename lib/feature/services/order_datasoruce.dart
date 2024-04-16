import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pp71/core/models/order.dart';
import 'package:sqflite/sqflite.dart';

class OrderDatabaseHelper {
  static final OrderDatabaseHelper _instance = OrderDatabaseHelper._internal();

  factory OrderDatabaseHelper() {
    return _instance;
  }

  OrderDatabaseHelper._internal();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "orders.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
       await db.execute('''
        CREATE TABLE orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          device TEXT,
          description TEXT,
          startTime INTEGER,
          endTime INTEGER,
          photos TEXT,
          client TEXT,
          FOREIGN KEY (client) REFERENCES Clients(id)
        )
        ''');
      },
    );
  }
}

class OrderDataSource {
  static final OrderDataSource _instance = OrderDataSource._internal();

  factory OrderDataSource() {
    return _instance;
  }

  OrderDataSource._internal();

  Future<void> deleteOrder(int id) async {
    try {
      Database db = await OrderDatabaseHelper().initDatabase();

      await db.delete('orders', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
       if (kDebugMode) {
         print(e);
       }
    }
  }

  Future<void> updateOrder(Order order) async {
    Database db = await OrderDatabaseHelper().initDatabase();

    await db.update('orders', order.toMap(),
        where: 'id = ?', whereArgs: [order.id]);
  }

  Future<void> insertOrder(Order order) async {
   
    try {
      Database db = await OrderDatabaseHelper().initDatabase();
      await db.insert('orders', order.toMap());
    } catch (e) {
      if (kDebugMode) {
         print(e);
       }
    }
  }

  Future<List<Order>> getAllOrders() async {
    try {
      Database db = await OrderDatabaseHelper().initDatabase();
      List<Map<String, dynamic>> rows = await db.query('orders');
     
      return rows.map((row) => Order.fromMap(row)).toList();
    } catch (e) {
     if (kDebugMode) {
         print(e);
       }
      return [];
    }
  }
}

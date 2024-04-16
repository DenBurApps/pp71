import 'dart:convert';

import 'package:pp71/core/models/order.dart';

class Client {
  int? id;
  final String name;
  final String surname;
  final String notes;
  final String phone;
  final String email;
  final List<Order?> orders;

  Client({
    this.id,
    required this.name,
    required this.surname,
    required this.notes,
    required this.phone,
    required this.email,
    required this.orders,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'notes': notes,
      'phone': phone,
      'email': email,
      'orders':
          jsonEncode(orders.map((order) => order?.toMap() ?? {}).toList()),
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'] as String,
      surname: map['surname'] as String,
      notes: map['notes'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      orders: List<Order>.from((jsonDecode(map['orders']) as List<dynamic>)
          .map((materialMap) => Order.fromMap(materialMap))),
    );
  }
}

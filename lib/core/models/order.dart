// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pp71/core/models/cleint.dart';

class Order {
  int? id;
  final Cleint client; // Change property name to match database column
  final String device;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> photos; 

  Order({
    this.id,
    required this.client, // Change property name to match database column
    required this.device,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.photos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'client': jsonEncode(client.toMap()), // Change property name to match database column
      'device': device,
      'description': description,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'photos': jsonEncode(photos),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as int : null,
      client: Cleint.fromMap(jsonDecode(map['client'])), // Change property name to match database column
      device: map['device'] as String,
      description: map['description'] as String?,
      startTime: _parseDeadline(map['startTime']),
      endTime: _parseDeadline(map['endTime']),
      photos: List<String>.from(jsonDecode(map['photos'])),
    );
  }

  static DateTime _parseDeadline(dynamic deadline) {
    if (deadline is int) {
      return DateTime.fromMillisecondsSinceEpoch(deadline);
    } else if (deadline is String) {
      return DateTime.tryParse(deadline) ?? DateTime.now();
    }
    return DateTime.now(); // Return the current date in case of an unsupported format
  }
}

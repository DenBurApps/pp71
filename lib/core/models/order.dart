// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pp71/core/models/cleint.dart';


class Order {
  int? id;
  final Client client; // Change property name to match database column
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
      'client': jsonEncode(
          client.toMap()), // Change property name to match database column
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
      client: Client.fromMap(jsonDecode(map['client'])),
      device: map['device'] as String,
      description: map['description'] as String?,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      photos: List<String>.from(jsonDecode(map['photos'])),
    );
  }
}

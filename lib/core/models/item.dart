import 'dart:convert';

class Item {
  int? id;
  final String name;
  final String category;
  final String desc;
  final List<String> photos; 
  final int deadline;
  final List<Materials> materials;

  Item({
    this.id,
    required this.name,
    required this.category,
    required this.desc,
    required this.photos,
    required this.deadline,
    required this.materials,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'desc': desc,
      'photos': jsonEncode(photos), 
      'deadline': deadline,
      'materials': jsonEncode(materials.map((material) => material.toMap()).toList()), 
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      desc: map['desc'],
      photos: List<String>.from(jsonDecode(map['photos'])), // Десериализуем JSON в список строк
      deadline: map['deadline'],
      materials: List<Materials>.from((jsonDecode(map['materials']) as List<dynamic>).map((materialMap) => Materials.fromMap(materialMap))), // Десериализуем JSON в список словарей
    );
  }
}

class Materials {
  final String name;
  final double cost;

  Materials({
    required this.name,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cost': cost,
    };
  }

  factory Materials.fromMap(Map<String, dynamic> map) {
    return Materials(
      name: map['name'],
      cost: map['cost'],
    );
  }
}

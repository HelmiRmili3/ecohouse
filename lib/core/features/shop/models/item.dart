import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ItemModule {
  final String id;
  final String name;
  final int points;
  final String description;
  final String imageUrl;
  int quantity;
  bool selected;

  ItemModule(
      {required this.id,
      required this.name,
      required this.points,
      required this.description,
      required this.imageUrl,
      this.quantity = 1, // Default quantity to 1
      this.selected = false});

  factory ItemModule.create({
    required String name,
    required int points,
    required String description,
    String? imageUrl = "",
  }) {
    final String itemId = const Uuid().v1();
    return ItemModule(
      id: itemId,
      name: name,
      points: points,
      description: description,
      imageUrl: imageUrl!,
    );
  }

  factory ItemModule.fromJson(Map<String, dynamic> json) => ItemModule(
        id: json["id"],
        name: json["name"],
        points: json["points"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        quantity: json["quantity"] ?? 1, // Set quantity from JSON, default to 1
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'points': points,
        'description': description,
        'imageUrl': imageUrl,
        'quantity': quantity, // Include quantity in JSON
      };

  ItemModule copyWith({
    String? id,
    String? name,
    int? points,
    String? description,
    String? imageUrl,
    int? quantity,
    bool? selected,
  }) {
    return ItemModule(
      id: this.id,
      name: this.name,
      points: points ?? this.points,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity, // Include quantity in copy
      selected: selected ?? this.selected,
    );
  }

  factory ItemModule.fromSnapshot(DocumentSnapshot snapshot) {
    return ItemModule(
      id: snapshot["id"],
      name: snapshot["name"],
      points: snapshot["points"],
      description: snapshot["description"],
      imageUrl: snapshot["imageUrl"],
    );
  }
}

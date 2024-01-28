import 'package:uuid/uuid.dart';

class ProductModule {
  final String id;
  final String name;
  final int pointsPerKg;
  final String? image;
  int weight;
  ProductModule(
      {required this.id,
      required this.name,
      required this.pointsPerKg,
      this.image,
      required this.weight});

  // factory constructor to create a product with a generated ID
  factory ProductModule.create({
    required String name,
    required int pointsPerKg,
    required int weight,
    String? image,
  }) {
    final String productId = const Uuid().v1();
    return ProductModule(
      id: productId, name: name, pointsPerKg: pointsPerKg, weight: weight,
      // other properties...
    );
  }

  factory ProductModule.fromJson(Map<String, dynamic> json) => ProductModule(
        id: json["id"],
        name: json["name"],
        pointsPerKg: json["pointsPerKg"],
        weight: json["weight"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pointsPerKg': pointsPerKg,
        'image': image,
        'weight': weight
      };

  ProductModule copyWith({
    String? id,
    String? name,
    int? weight,
    int? pointsPerKg,
  }) {
    return ProductModule(
      id: this.id,
      name: this.name,
      weight: weight ?? this.weight,
      pointsPerKg: pointsPerKg ?? this.pointsPerKg,
    );
  }
}

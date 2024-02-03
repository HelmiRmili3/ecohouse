import 'package:uuid/uuid.dart';

class ProductModule {
  final String id;
  final String name;
  final int pointsPerKg;
  final String image;
  int weight;
  ProductModule(
      {required this.id,
      required this.name,
      required this.pointsPerKg,
      this.image =
          "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
      required this.weight});

  // factory constructor to create a product with a generated ID
  factory ProductModule.create({
    required String name,
    required int pointsPerKg,
    required int weight,
    String image =
        "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
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
    String? image,
  }) {
    return ProductModule(
      id: this.id,
      name: this.name,
      weight: weight ?? this.weight,
      pointsPerKg: this.pointsPerKg,
      image: this.image,
    );
  }
}

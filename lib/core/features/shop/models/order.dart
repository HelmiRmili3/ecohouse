import 'package:ecohouse/core/features/shop/models/product.dart';

class OrderModule {
  final String id;
  final List<ProductModule> products;
  final int totalPoints;
  final int totalWeight;

  OrderModule({
    required this.id,
    required this.products,
    required this.totalPoints,
    required this.totalWeight,
  });

  factory OrderModule.fromJson(Map<String, dynamic> json) {
    List<ProductModule> products = (json['items'] as List)
        .map((productJson) => ProductModule.fromJson(productJson))
        .toList();

    return OrderModule(
      id: json['id'],
      products: products,
      totalPoints: json['totalPoints'],
      totalWeight: json['totalWeight'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'products': products.map((item) => item.toJson()).toList(),
        'totalPoints': totalPoints,
        'totalWeight': totalWeight,
      };
}
//12695849
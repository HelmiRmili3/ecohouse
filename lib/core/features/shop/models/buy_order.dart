import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:uuid/uuid.dart';

import '../../../enums.dart';

class BuyOrderModule {
  final String id;
  final List<ItemModule> products;
  final String customerId;
  final DateTime orderDate;
  final int totalPrice;
  final int number;
  final Status status;

  BuyOrderModule({
    required this.id,
    required this.products,
    required this.customerId,
    required this.orderDate,
    required this.totalPrice,
    required this.number,
    required this.status,
  });

  factory BuyOrderModule.create({
    required List<ItemModule> products,
    required String customerId,
    required int totalPrice,
    required int number,
    required Status status,
  }) {
    final String id = const Uuid().v1();
    final DateTime orderDate = DateTime.now();
    return BuyOrderModule(
      id: id,
      products: products,
      customerId: customerId,
      orderDate: orderDate,
      totalPrice: totalPrice,
      number: number,
      status: status,
    );
  }

  factory BuyOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<ItemModule> products = productsJson
        .map((productJson) => ItemModule.fromSnapshot(productJson))
        .toList();
    return BuyOrderModule(
      id: json['id'],
      products: products,
      customerId: json['customerId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: json['totalPrice'],
      number: json['number'],
      status: _getStatusFromString(json['status']),
    );
  }

  factory BuyOrderModule.fromSnapshot(Map<String, dynamic> snapshot) {
    List<dynamic> productsJson = snapshot['products'];
    List<ItemModule> products = productsJson
        .map((productJson) => ItemModule.fromJson(productJson))
        .toList();

    String id = snapshot['id'];
    String customerId = snapshot['customerId'];
    DateTime orderDate = DateTime.parse(snapshot['orderDate']);
    int totalPrice = snapshot['totalPrice'];
    int number = snapshot['number'];
    Status status = _getStatusFromString(snapshot['status']);

    return BuyOrderModule(
      id: id,
      products: products,
      customerId: customerId,
      orderDate: orderDate,
      totalPrice: totalPrice,
      number: number,
      status: status,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();
    return {
      'id': id,
      'products': productsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
      'totalPrice': totalPrice,
      'number': number,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }

  static Status _getStatusFromString(String statusString) {
    return Status.values.firstWhere(
        (status) =>
            status.toString().split('.').last == statusString.toLowerCase(),
        orElse: () => Status.waiting); // Default to waiting if not found
  }
}

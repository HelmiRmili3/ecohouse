import 'package:ecohouse/core/features/products/models/product.dart';

import '../../../enums.dart';

class SellOrderModule {
  final String id;
  final List<ProductModule> items;
  final String customerId;
  final DateTime orderDate;
  final int totalPoints;
  final int totalWeight;
  final Status status;

  SellOrderModule({
    required this.id,
    required this.items,
    required this.customerId,
    required this.orderDate,
    required this.totalPoints,
    required this.totalWeight,
    required this.status,
  });

  factory SellOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'];
    List<ProductModule> items =
        itemsJson.map((itemJson) => ProductModule.fromJson(itemJson)).toList();
    return SellOrderModule(
        id: json["id"],
        items: items,
        customerId: json['customerId'],
        orderDate: DateTime.parse(json['orderDate']),
        totalPoints: json["totalPoints"],
        totalWeight: json["totalWeight"],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJson =
        items.map((product) => product.toJson()).toList();
    return {
      'id': id,
      'products': itemsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
      'totalPoints': totalPoints,
      'totalWeight': totalWeight,
      'status': status.toString().split('.').last,
    };
  }

  factory SellOrderModule.fromSnapshot(Map<String, dynamic> snapshot) {
    List<dynamic> itemsJson = snapshot['products'];
    List<ProductModule> items = itemsJson
        .map((productJson) => ProductModule.fromJson(productJson))
        .toList();

    String id = snapshot['id'];
    String customerId = snapshot['customerId'];
    DateTime orderDate = DateTime.parse(snapshot['orderDate']);
    Status status = _getStatusFromString(snapshot['status']);
    int totalPoints = snapshot['totalPoints'];
    int totalWeight = snapshot['totalWeight'];

    return SellOrderModule(
      id: id,
      items: items,
      customerId: customerId,
      orderDate: orderDate,
      totalPoints: totalPoints,
      totalWeight: totalWeight,
      status: status,
    );
  }

  static Status _getStatusFromString(String statusString) {
    return Status.values.firstWhere(
        (status) =>
            status.toString().split('.').last == statusString.toLowerCase(),
        orElse: () => Status.waiting);
  }
}

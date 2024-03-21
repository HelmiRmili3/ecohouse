import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/shop/models/buy_order.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../../enums.dart';

class ShopRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ItemModule>> fetchItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firebaseFirestore.collection('items').get();
      List<ItemModule> items =
          snapshot.docs.map((doc) => ItemModule.fromJson(doc.data())).toList();

      return items;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<void> addOrder(List<ItemModule> products) async {
    try {
      String userId = _auth.currentUser!.uid;
      CollectionReference ordersCollection =
          _firebaseFirestore.collection('buy');

      String orderId = const Uuid().v1();
      final Map<String, dynamic> order = BuyOrderModule(
        id: orderId,
        products: products,
        customerId: userId,
        orderDate: DateTime.now(),
        totalPrice: calculateTotalPoints(products),
        number: calculateTotalQuantity(products),
        status: Status.waiting,
      ).toJson();
      await ordersCollection
          .doc(orderId)
          .set(order); // Set document with custom ID
    } catch (e) {
      throw Exception('Failed to add order to Firestore: $e');
    }
  }

  int calculateTotalPoints(List<ItemModule> products) {
    int totalPoints = 0;

    for (var product in products) {
      totalPoints += product.points * product.quantity;
    }

    return totalPoints;
  }

  int calculateTotalQuantity(List<ItemModule> products) {
    int totalWeight = 0;

    for (var product in products) {
      totalWeight += product.quantity;
    }

    return totalWeight;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/products/models/sell_order.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shop/models/buy_order.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<List<BuyOrderModule>> fetchBuyOrders() {
    return _firestore
        .collection('buy')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return BuyOrderModule.fromSnapshot(doc.data());
      }).toList();
    });
  }

  Stream<List<SellOrderModule>> fetchSellOrders() {
    return _firestore
        .collection('sell')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return SellOrderModule.fromSnapshot(doc.data());
      }).toList();
    });
  }
  // Future<List<OrderModule>> fetchOrders() async {
  //   try {
  //     // Get a reference to the 'orders' collection
  //     CollectionReference usersCollection = _firestore.collection('users');

  //     // Get the current user's ID
  //     String userId = _auth.currentUser!.uid;

  //     // Get a reference to the 'orders' sub-collection under the user's ID
  //     CollectionReference orders =
  //         usersCollection.doc(userId).collection('orders');

  //     // Get the documents from the 'orders' collection
  //     QuerySnapshot dataSnapshot = await orders.get();

  //     // Convert each document to an OrderModule
  //     List<OrderModule> ordersList = dataSnapshot.docs.map((doc) {
  //       // Convert the documents to a list of ProductModule
  //       List<ProductModule> products = (doc['products'] as List)
  //           .map((productJson) => ProductModule.fromJson(productJson))
  //           .toList();

  //       return OrderModule(
  //         id: doc.id,
  //         products: products,
  //         totalPoints: doc['totalPoints'],
  //         totalWeight: doc['totalWeight'],
  //       );
  //     }).toList();

  //     return ordersList;
  //   } catch (e) {
  //     throw Exception('Failed to fetch Orders: $e');
  //   }
  // }

  Future<void> deleteOrder(String orderId) async {
    try {
      // Get a reference to the 'orders' collection
      CollectionReference usersCollection = _firestore.collection('users');

      // Get the current user's ID
      String userId = _auth.currentUser!.uid;

      // Get a reference to the specific order document
      DocumentReference orderDocument =
          usersCollection.doc(userId).collection('orders').doc(orderId);

      // Delete the document
      await orderDocument.delete();
    } catch (e) {
      throw Exception('Failed to delete Order: $e');
    }
  }
}

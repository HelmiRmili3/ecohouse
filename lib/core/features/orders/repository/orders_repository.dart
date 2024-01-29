import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/shoppingCard/models/order.dart';
import 'package:ecohouse/core/features/shoppingCard/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<OrderModule>> fetchOrders() async {
    try {
      // Get a reference to the 'orders' collection
      CollectionReference usersCollection = _firestore.collection('users');

      // Get the current user's ID
      String userId = _auth.currentUser!.uid;

      // Get a reference to the 'orders' sub-collection under the user's ID
      CollectionReference orders =
          usersCollection.doc(userId).collection('orders');

      // Get the documents from the 'orders' collection
      QuerySnapshot dataSnapshot = await orders.get();

      // Convert each document to an OrderModule
      List<OrderModule> ordersList = dataSnapshot.docs.map((doc) {
        // Convert the documents to a list of ProductModule
        List<ProductModule> products = (doc['products'] as List)
            .map((productJson) => ProductModule.fromJson(productJson))
            .toList();

        return OrderModule(
          products: products,
          totalPoints: doc['totalPoints'],
          totalWeight: doc['totalWeight'],
        );
      }).toList();

      return ordersList;
    } catch (e) {
      throw Exception('Failed to fetch Orders: $e');
    }
  }
}

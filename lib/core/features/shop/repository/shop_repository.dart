import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/shop/models/item.dart';

class ShopRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
}

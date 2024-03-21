import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/enums.dart';
import 'package:ecohouse/core/features/products/models/product.dart';
import 'package:ecohouse/core/features/products/models/sell_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ShoppingCardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ProductModule>> fetchProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('products').get();
      List<ProductModule> products = snapshot.docs
          .map((doc) => ProductModule.fromJson(doc.data()))
          .toList();

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Future<void> addProduct(ProductModule product, File? image) async {
  //   try {
  //     // Add image product to Storage
  //     final imageUrl = await uploadImageToFirebaseStorage(image);
  //     ProductModule newProduct = ProductModule(
  //         id: product.id,
  //         name: product.name,
  //         pointsPerKg: product.pointsPerKg,
  //         weight: product.weight,
  //         image: imageUrl);
  //     // Add product data to Firestore
  //     await _firestore.collection('products').add(newProduct.toJson());
  //   } catch (e) {
  //     throw Exception('Failed to add product to Firestore');
  //   }
  // }

  Future<void> addOrder(List<ProductModule> products) async {
    try {
      String userId = _auth.currentUser!.uid;
      CollectionReference ordersCollection = _firestore.collection('sell');

      String orderId = const Uuid().v1(); // Generate unique ID for the order

      final Map<String, dynamic> order = SellOrderModule(
              id: orderId,
              items: products,
              customerId: userId,
              orderDate: DateTime.now(),
              status: Status.waiting,
              totalPoints: calculateTotalPoints(products),
              totalWeight: calculateTotalWeight(products))
          .toJson();

      await ordersCollection
          .doc(orderId)
          .set(order); // Set document with custom ID
    } catch (e) {
      throw Exception('Failed to add order to Firestore: $e');
    }
  }

  int calculateTotalPoints(List<ProductModule> products) {
    int totalPoints = 0;

    for (var product in products) {
      totalPoints += product.pointsPerKg * product.weight;
    }

    return totalPoints;
  }

  int calculateTotalWeight(List<ProductModule> products) {
    int totalWeight = 0;

    for (var product in products) {
      totalWeight += product.weight;
    }

    return totalWeight;
  }

// List<ProductModule> filterProductsByWeightZero(List<ProductModule> products) {
//   return products.where((product) => product.weight > 0).toList();
// }

// Future<String> uploadImageToFirebaseStorage(File? imageFile) async {
//   if (imageFile == null) return '';

//   final storage = FirebaseStorage.instance;
//   final Reference storageReference =
//       storage.ref().child('images/${DateTime.now().toString()}');
//   final UploadTask uploadTask = storageReference.putFile(
//     File(imageFile.path),
//   );
//   await uploadTask.whenComplete(() => null);
//   final String imageUrl = await storageReference.getDownloadURL();

//   return imageUrl;
// }
}

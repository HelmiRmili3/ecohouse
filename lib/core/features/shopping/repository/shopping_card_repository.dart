// shopping_card_repository.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/shopping/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<void> addProduct(ProductModule product, File? image) async {
    try {
      // Add image product to Storage
      final imageUrl = await uploadImageToFirebaseStorage(image);
      ProductModule newProduct = ProductModule(
          id: product.id,
          name: product.name,
          pointsPerKg: product.pointsPerKg,
          weight: product.weight,
          image: imageUrl);
      // Add product data to Firestore
      await _firestore.collection('products').add(newProduct.toJson());
    } catch (e) {
      throw Exception('Failed to add product to Firestore');
    }
  }

  Future<void> addOrder(List<ProductModule> products) async {
    try {
      // Get a reference to the 'orders' collection
      CollectionReference usersCollection = _firestore.collection('users');
      // Get the current user's ID
      String userId = _auth.currentUser!.uid;
      // Create a new document reference with an auto-generated ID under the user's ID
      DocumentReference orderDocRef =
          usersCollection.doc(userId).collection('orders').doc();
      List<ProductModule> filteredList = filterProductsByWeightZero(products);
      List<Map<String, dynamic>> productsData =
          filteredList.map((product) => product.toJson()).toList();
      // Set the order document with product data
      await orderDocRef.set({
        "products": productsData,
        "totalPoints": calculateTotalPoints(filteredList),
        "totalWeight": calculateTotalWeight(filteredList)
      });

      // print('Order added successfully with ID: ${orderDocRef.id}');
    } catch (e) {
      throw Exception('Failed to add order to Firestore: $e');
    }
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

List<ProductModule> filterProductsByWeightZero(List<ProductModule> products) {
  return products.where((product) => product.weight > 0).toList();
}

Future<String> uploadImageToFirebaseStorage(File? imageFile) async {
  if (imageFile == null) return '';

  final storage = FirebaseStorage.instance;
  final Reference storageReference =
      storage.ref().child('images/${DateTime.now().toString()}');
  final UploadTask uploadTask = storageReference.putFile(
    File(imageFile.path),
  );
  await uploadTask.whenComplete(() => null);
  final String imageUrl = await storageReference.getDownloadURL();

  return imageUrl;
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohouse/core/features/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModule> fetchUsers() async {
    try {
      // Get a reference to the 'orders' collection
      CollectionReference usersCollection = _firestore.collection('users');
      // Get the current user's ID
      String userId = _auth.currentUser!.uid;

      // Get a reference to the 'orders' sub-collection under the user's ID
      CollectionReference userCollection =
          usersCollection.doc(userId).collection('userCredential');

      // Get the documents from the 'orders' collection
      QuerySnapshot dataSnapshot = await userCollection.get();

      // Convert the documents to a list of Order objects
      Map<String, dynamic> data =
          dataSnapshot.docs.first.data() as Map<String, dynamic>;
      return UserModule.fromJson(data);
    } catch (e) {
      throw Exception(
          '########### ->  Failed to fetch orders from Firestore: $e');
    }
  }
}

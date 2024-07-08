import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSave {
  Future<void> storeUserData(User user) async {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define a reference to the user's document
    DocumentReference userRef = firestore.collection('users').doc(user.uid);

    // Check if the user already exists in Firestore
    bool userExists = (await userRef.get()).exists;

    // If the user doesn't exist, create a new document with user data
    if (!userExists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
      });
    }
  }
}

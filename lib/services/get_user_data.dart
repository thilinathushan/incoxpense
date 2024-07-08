import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/db_user_model.dart';

class GetUserDetails {
  final String userId;

  GetUserDetails(this.userId);

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        // print('User data not found in Firestore.');
        return null;
      }
    } catch (e) {
      // print('Error retrieving user data: $e');
      return null;
    }
  }

  Future<UserData> getCurrentUserDetails() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserData.fromJSON(snapshot.data() as Map<String, dynamic>);
  }
}
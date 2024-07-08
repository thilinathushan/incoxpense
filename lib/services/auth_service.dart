import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user from firebase user with uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //create a user stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }


  //Continue with Google
  Future signInWithGoogle() async {
    try {
      //begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //finally, lets sign in
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      return _userWithFirebaseUserUid(user);
    } catch (error) {
      // print(error.toString());
      return null;
    }
  }
}

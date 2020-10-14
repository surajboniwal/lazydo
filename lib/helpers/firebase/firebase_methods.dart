import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser;

  //Future Method
  Future<User> getUser() async {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithGoogle() async {
    googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut();
    return await _auth.signOut();
  }
}

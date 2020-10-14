import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser;

  //Future Method here if current user is null it means it logged out
  Future<User> getUser() async {
    return _auth.currentUser;
  }

  //it does sign in and returns Credentials that later can be used to store in DB
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

  //Signout function makes current user as null
  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    return await _auth.signOut();
  }
}

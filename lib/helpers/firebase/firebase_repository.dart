import 'package:firebase_auth/firebase_auth.dart';
import 'package:lazydo/data/models/userDetails.dart';

import 'firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getUser() => _firebaseMethods.getUser();

  Future<UserCredential> signInWithGoogle() =>
      _firebaseMethods.signInWithGoogle();

  Future<void> signOutWithGoogle() => _firebaseMethods.signOutWithGoogle();

  Future<UserDetail> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<bool> authenticateUser(UserCredential userCredential) =>
      _firebaseMethods.authenticateUser(userCredential);

  Future<void> addDataToDb(UserCredential credential) =>
      _firebaseMethods.addDataToDb(credential);

  Future<void> updateUser(User user, String key, String value) =>
      _firebaseMethods.updateUser(user, key, value);

  Future<void> updateUserUsingClass(
          UserDetail user, String key, String value) =>
      _firebaseMethods.updateUserUsingClass(user, key, value);
}

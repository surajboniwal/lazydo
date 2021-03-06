import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:lazydo/data/models/userDetails.dart';

import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Change this to another file

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection = FirebaseFirestore.instance.collection('userDetails');
  static final CollectionReference _avatarCollection = FirebaseFirestore.instance.collection('Avatars');
  StorageReference _storageReference;
  double uploadProgress = 0;

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

  //it does sign in and returns Credentials that later can be used to store in DB
  Future<UserCredential> signInWithGithub(BuildContext context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn =
        GitHubSignIn(clientId: 'ab8e3a7f9ac8b4de3981', clientSecret: 'f7bf2847a9e0c52852a9cdeb5acb6959c2eee9dc', redirectUrl: 'https://lazydo2020.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        if (result.token != null) {
          // Create a credential from the access token
          final AuthCredential githubAuthCredential = GithubAuthProvider.credential(result.token);
          return await _auth.signInWithCredential(githubAuthCredential);
        } else {
          print('error');
          return null;
        }
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        return null;
        break;
      default:
        return null;
    }
  }

  //Signout function makes current user as null
  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    return await _auth.signOut();
  }

  //Get user Details
  Future<UserDetail> getUserDetails() async {
    User currentUser = await getUser();
    DocumentSnapshot documentSnapshot = await _userCollection.doc(currentUser.uid).get();
    return UserDetail.fromMap(documentSnapshot.data());
  }

  //Get user Avatars
  Future<List> getAvatarURL() async {
    QuerySnapshot results = await _avatarCollection.get();
    List avatarUrls = List<String>();
    results.docs.forEach((element) {
      avatarUrls.add(element.data()['avatarLink']);
    });

    return avatarUrls;
  }

  //Is user present in DB
  Future<bool> authenticateUser(UserCredential userCredential) async {
    QuerySnapshot results = await firestore.collection('userDetails').where('email', isEqualTo: userCredential.user.email).get();
    final List<DocumentSnapshot> docs = results.docs;

    return docs.length == 0 ? true : false;
  }

  //Add User to DB

  UserDetail userDetail = UserDetail();
  Future<void> addDataToDb(UserCredential credential) async {
    //Later generate dynamically
    String username = 'LazyUser';

    userDetail = UserDetail(id: credential.user.uid, email: credential.user.email, displayName: credential.user.displayName, profilePhoto: credential.user.photoURL, userName: username);

    firestore.collection('userDetails').doc(credential.user.uid).set(userDetail.toMap());
  }

  //See this if it gets error from the auth use UserDetails from below too
  Future<void> updateUser(User user, String key, String value) {
    return _userCollection.doc(user.uid).update({'$key': '$value'}).then((value) => print("User Updated")).catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateUserUsingClass(UserDetail user, String key, String value) {
    return _userCollection.doc(user.id).update({'$key': '$value'}).then((value) => print("User Updated")).catchError((error) => print("Failed to update user: $error"));
  }

  Future<String> uploadImageToStorage(File image, String userId) async {
    try {
      _storageReference = FirebaseStorage.instance.ref().child('profileImages').child('$userId');

      StorageUploadTask _storageUploadTask = _storageReference.putFile(image);

      _storageUploadTask.events.listen((event) {
        uploadProgress = (event.snapshot.totalByteCount / event.snapshot.bytesTransferred) * 100;

        print('Progress: $uploadProgress %');
      });

      var url = await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (E) {
      print(E);
      return null;
    }
  }
}

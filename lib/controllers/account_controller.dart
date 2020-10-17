import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';
import 'package:lazydo/presentation/screens/account/account.dart';
import 'package:lazydo/presentation/screens/home/home.dart';

FirebaseMethods _firebase = FirebaseMethods();

class AccountController extends GetxController {
  User user = null;

  signInWithGoogle() {
    _firebase.signInWithGoogle().then(
      (userCredential) {
        if (userCredential != null) {
          _firebase.authenticateUser(userCredential).then(
            (isNewUser) {
              if (isNewUser) {
                _firebase.addDataToDb(userCredential).then(
                  (value) {
                    user = userCredential.user;
                    Get.off(HomeScreen());
                  },
                );
              } else {
                user = userCredential.user;
                Get.off(HomeScreen());
              }
            },
          );
        } else {
          Get.snackbar(
            'Sign in error',
            'Please select an account',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
          );
        }
      },
    );
  }

  signOut() {
    _firebase.signOutWithGoogle();
    user = null;
    Get.off(AccountScreen());
  }

  signInWithGithub(BuildContext context) {
    _firebase.signInWithGithub(context).then(
      (userCredential) {
        if (userCredential != null) {
          _firebase.authenticateUser(userCredential).then((isNewUser) {
            if (isNewUser) {
              _firebase.addDataToDb(userCredential).then(
                (value) {
                  user = userCredential.user;
                  Get.off(HomeScreen());
                },
              );
            } else {
              user = userCredential.user;
              Get.off(HomeScreen());
            }
          });
        }
      },
    );
  }
}

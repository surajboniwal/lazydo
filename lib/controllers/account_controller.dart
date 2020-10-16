import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lazydo/helpers/firebase/firebase_repository.dart';

FirebaseRepository _repository = FirebaseRepository();

class AccountController extends GetxController {
  User user = null;

  signInWithGoogle() {
    _repository.signInWithGoogle().then(
      (userCredential) {
        if (userCredential != null) {
          _repository.authenticateUser(userCredential).then((isNewUser) {
            if (isNewUser) {
              _repository.addDataToDb(userCredential).then(
                (value) {
                  user = userCredential.user;
                  update();
                },
              );
            } else {
              user = userCredential.user;
              update();
            }
          });
        }
      },
    );
  }

  signOutWithGoogle() {
    _repository.signOutWithGoogle();
    user = null;
    update();
  }
}

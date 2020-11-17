import 'package:get/get.dart';
import 'package:lazydo/data/models/userDetails.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';

FirebaseMethods _firebaseMethods = FirebaseMethods();

class UserController extends GetxController {
  UserDetail user = null;

  UserController() {
    if (user == null) {
      _firebaseMethods.getUserDetails().then((value) {
        user = value;
        update();
      });
    }
  }
}

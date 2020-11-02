import 'package:get/get.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';

FirebaseMethods _firebaseMethods = FirebaseMethods();

class UserController extends GetxController {
  List<String> avatars = [];
  String selectedAvatar;

  UserController() {
    if (avatars.length == 0) {
      _firebaseMethods.getAvatarURL().then((value) {
        avatars = value;
        update();
      });
    }
  }

  changeAvatar(int index) {
    selectedAvatar = avatars[index];
    update();
  }
}

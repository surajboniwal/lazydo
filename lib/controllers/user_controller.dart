import 'dart:io';

import 'package:get/get.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';

FirebaseMethods _firebaseMethods = FirebaseMethods();

class UserController extends GetxController {
  List<String> avatars = [];
  String selectedAvatar = "https://image.shutterstock.com/image-photo/landscape-imaage-sea-sunset-260nw-336142157.jpg";
  File selectedFile;
  bool isNetwork = true;

  UserController() {
    if (avatars.length == 0) {
      _firebaseMethods.getAvatarURL().then((value) {
        avatars = value;
        update();
      });
    }
  }

  setFile(File image) {
    selectedFile = image;
    update();
  }

  changeType(bool boolean) {
    isNetwork = boolean;
    update();
  }

  changeAvatar(String image) {
    selectedAvatar = image;
    update();
  }
}

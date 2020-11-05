import 'dart:io';

import 'package:get/get.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';

FirebaseMethods _firebaseMethods = FirebaseMethods();

class AvatarController extends GetxController {
  List<String> avatars = [];
  String selectedAvatar = "https://firebasestorage.googleapis.com/v0/b/lazydo2020.appspot.com/o/defaultAvatar%2Fdefault_avatar.png?alt=media&token=b10eb7b2-4326-4e03-9741-358dbfec0ac1";
  File selectedFile;
  bool isNetwork = true;

  AvatarController() {
    if (avatars.length == 0) {
      _firebaseMethods.getAvatarURL().then((value) {
        avatars = value;
        update();
      });
    }
  }

  setSelectedFile(File image) {
    selectedFile = image;
    update();
  }

  changeImageType(bool boolean) {
    isNetwork = boolean;
    update();
  }

  changeAvatar(String image) {
    selectedAvatar = image;
    update();
  }
}

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageHandler {
  static Future<File> pickImage(ImageSource source) async {
    //Image source can be gallery or camera
    final picker = ImagePicker();

    //We can compress this image too : ;
    final pickedFile = await picker.getImage(source: source);

    //We pass the pickedFile to compress Image
    //Since firebase accepts file we reach to return file
    return File(pickedFile.path);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/controllers/avatar_controller.dart';
import 'package:lazydo/helpers/Image/imagehandler.dart';
import 'package:lazydo/helpers/firebase/firebase_methods.dart';
import 'package:lazydo/presentation/screens/home/home.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/clippers.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/input_field.dart';
import 'package:lazydo/presentation/styles/colors.dart';

FirebaseMethods _firebaseMethods = FirebaseMethods();

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final AccountController _accountController = AccountController();
  final AvatarController _avatarController = AvatarController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayNameController.text = _accountController.user.displayName;
    _emailController.text = _accountController.user.email;
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.92,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipPath(
                clipper: ProfileSetupTopContainerClipper(),
                child: Container(
                  color: AppColors.primaryColor,
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Setup your profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            buildBottomSheet(context);
                          },
                          child: GetBuilder<AvatarController>(
                            init: _avatarController,
                            builder: (controller) => CircleAvatar(
                              backgroundImage: _avatarController.isNetwork ? NetworkImage(_avatarController.selectedAvatar) : FileImage(_avatarController.selectedFile),
                              radius: Get.width * 0.13,
                            ),
                          ),
                        ),
                        Text(
                          'Let’s  find out a little bit about you \nThis won’t take long!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    InputField(displayNameController: _displayNameController, label: 'Name', enabled: true, isBio: false),
                    SizedBox(height: 12),
                    InputField(displayNameController: _emailController, label: 'Email', enabled: false, isBio: false),
                    SizedBox(height: 12),
                    InputField(displayNameController: _bioController, label: 'Bio', enabled: true, isBio: true),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                height: 48,
                child: RaisedButton(
                  onPressed: () {
                    if (_avatarController.isNetwork) {
                      _firebaseMethods.updateUser(_accountController.user, 'profilePhoto', _avatarController.selectedAvatar).then((value) {
                        Get.off(HomeScreen());
                      });
                    } else {
                      _firebaseMethods.uploadImageToStorage(_avatarController.selectedFile, _accountController.user.uid).then((value) {
                        _firebaseMethods.updateUser(_accountController.user, 'profilePhoto', value).then((value) {
                          Get.off(HomeScreen());
                        });
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      enableDrag: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Choose an avatar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                GetBuilder<AvatarController>(
                  init: _avatarController,
                  builder: (_userController) {
                    return Container(
                      height: 80,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _userController.avatars.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
                            child: GestureDetector(
                              onTap: () {
                                _userController.changeAvatar(_userController.avatars[index]);
                                _userController.changeImageType(true);
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_userController.avatars[index]),
                                minRadius: 32,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 12),
                Text('OR', style: TextStyle(color: Colors.white, fontSize: 12)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        File image = await ImageHandler.pickImage(ImageSource.camera);
                        _avatarController.setSelectedFile(image);
                        Navigator.pop(context);
                        _avatarController.changeImageType(false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          children: [Icon(Icons.camera), Text('Camera')],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () async {
                        File image = await ImageHandler.pickImage(ImageSource.gallery);
                        _avatarController.setSelectedFile(image);
                        Navigator.pop(context);
                        _avatarController.changeImageType(false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          children: [Icon(Icons.image), Text('Gallery')],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

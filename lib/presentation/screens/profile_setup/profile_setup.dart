import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/clippers.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class ProfileSetup extends StatelessWidget {
  final AccountController _accountController = AccountController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: ProfileSetupTopContainerClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_accountController.user.photoURL),
                ),
              ),
              height: Get.height * 0.4,
              width: Get.width,
            ),
          ),
          Container(
            height: Get.height * 0.42,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.edit),
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

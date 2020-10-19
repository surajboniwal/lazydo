import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/presentation/screens/account/account.dart';
import 'package:lazydo/presentation/screens/home/home.dart';
import 'package:lazydo/presentation/screens/onboarding/onboarding.dart';
import 'package:lazydo/presentation/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  final AccountController _accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Future.delayed(Duration(seconds: 3)).then(
          (value) {
            if (preferences.getBool('skipOnBoard') != true) {
              preferences.setBool('skipOnBoard', true);
              Get.off(OnBoardingScreen());
            } else {
              if (_accountController.user == null) {
                Get.off(AccountScreen());
              } else {
                print(_accountController.user);
                Get.off(HomeScreen());
              }
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SvgPicture.asset('assets/svg/logo.svg'),
      ),
    );
  }
}

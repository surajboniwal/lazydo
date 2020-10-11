import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazydo/presentation/screens/onboarding/onboarding.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3)).then(
        (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen()),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SvgPicture.asset('assets/svg/logo.svg'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import '../data/models/onboarding.dart';

List<OnBoarding> onBoardingScreens = getOnBoardingScreens();

class OnBoardingHeaderController extends GetxController {
  String title = onBoardingScreens[0].title;
  String desc = onBoardingScreens[0].desc;
  IconData icon = Icons.arrow_forward;

  void updateInfo(int index) {
    title = onBoardingScreens[index].title;
    desc = onBoardingScreens[index].desc;
    update();
  }

  setIcon(int value) {
    if (value == 2) {
      icon = Icons.done;
    } else {
      icon = Icons.arrow_forward;
    }
    update();
  }
}

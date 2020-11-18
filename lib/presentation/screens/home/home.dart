import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/controllers/user_controller.dart';
import 'package:lazydo/presentation/screens/home/widgets/BottomSheetContainer.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  final AccountController _accountController = AccountController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 75,
              height: double.infinity,
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  GetBuilder<UserController>(
                    init: _userController,
                    builder: (controller) => CircleAvatar(
                      backgroundImage:
                          NetworkImage(controller.user.profilePhoto),
                      radius: 28,
                    ),
                  ),
                  Expanded(child: Container()),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Todo list',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'All Projects',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    'assets/svg/category_icon.svg',
                    height: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/svg/calendar_icon.svg',
                    height: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/svg/plus_icon.svg',
                    height: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/search_icon.svg',
                              width: 32,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/svg/setting_icon.svg',
                              width: 32,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Hello,'),
                            TextSpan(text: ' '),
                            TextSpan(text: 'Krish'),
                          ],
                        ),
                      )
                    ],
                  ),
                  BottomSheetContainer(
                      bottomContainerHeight: 350, containerChild: Container())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/controllers/user_controller.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  final AccountController _accountController = AccountController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 75,
            height: double.infinity,
            color: AppColors.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  GetBuilder<UserController>(
                    init: _userController,
                    builder: (controller) => CircleAvatar(
                      backgroundImage: NetworkImage(controller.user.profilePhoto),
                      radius: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}

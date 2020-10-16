import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/controllers/account_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<AccountController>(
          init: AccountController(),
          builder: (controller) => Text(controller.user == null ? 'No user' : controller.user.displayName),
        ),
      ),
    );
  }
}

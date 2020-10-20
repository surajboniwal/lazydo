import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/controllers/account_controller.dart';

class HomeScreen extends StatelessWidget {
  final AccountController _accountController = AccountController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AccountController>(
        init: _accountController,
        builder: (_accountController) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_accountController.user == null ? 'No user' : _accountController.user.email),
              FlatButton(
                onPressed: () {
                  _accountController.signOut();
                },
                child: Text('Signout'),
              ),
            ],
          );
        },
      ),
    );
  }
}

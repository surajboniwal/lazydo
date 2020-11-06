import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  final AccountController _accountController = AccountController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AccountController>(
        init: _accountController,
        builder: (_accountController) {
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<UserController>(
                  init: _userController,
                  builder: (controller) {
                    return CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(controller.user == null
                          ? 'https://firebasestorage.googleapis.com/v0/b/lazydo2020.appspot.com/o/defaultAvatar%2Fdefault_avatar.png?alt=media&token=b10eb7b2-4326-4e03-9741-358dbfec0ac1'
                          : _userController.user.profilePhoto),
                    );
                  },
                ),
                Text(_accountController.user == null ? 'No user' : _accountController.user.email),
                FlatButton(
                  onPressed: () {
                    _accountController.signOut();
                  },
                  child: Text('Signout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

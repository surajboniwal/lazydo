import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/clippers.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/input_field.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final AccountController _accountController = AccountController();

  final TextEditingController _displayNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayNameController.text = _accountController.user.displayName;
    _emailController.text = _accountController.user.email;
    _userNameController.text = 'Lazy_' + _accountController.user.displayName.split(' ')[0] + _accountController.user.displayName.split(' ')[1];
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
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
                    height: Get.height * 0.4,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.edit),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    InputField(displayNameController: _displayNameController, label: 'Display Name'),
                    SizedBox(height: 24),
                    InputField(displayNameController: _emailController, label: 'Email'),
                    SizedBox(height: 24),
                    InputField(displayNameController: _userNameController, label: 'Username'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 42, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

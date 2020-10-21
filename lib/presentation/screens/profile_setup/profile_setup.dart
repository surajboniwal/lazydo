import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazydo/controllers/account_controller.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/clippers.dart';
import 'package:lazydo/presentation/screens/profile_setup/widgets/input_field.dart';
import 'package:lazydo/presentation/styles/colors.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final AccountController _accountController = AccountController();

  final TextEditingController _displayNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayNameController.text = _accountController.user.displayName;
    _emailController.text = _accountController.user.email;
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.92,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipPath(
                clipper: ProfileSetupTopContainerClipper(),
                child: Container(
                  color: AppColors.primaryColor,
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Setup your profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(_accountController.user.photoURL),
                          radius: Get.width * 0.13,
                        ),
                        Text(
                          'Let’s  find out a little bit about you \nThis won’t take long!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    InputField(displayNameController: _displayNameController, label: 'Name', enabled: true, isBio: false),
                    SizedBox(height: 12),
                    InputField(displayNameController: _emailController, label: 'Email', enabled: false, isBio: false),
                    SizedBox(height: 12),
                    InputField(displayNameController: _bioController, label: 'Bio', enabled: true, isBio: true),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

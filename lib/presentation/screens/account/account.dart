import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazydo/controllers/account_controller.dart';

import 'package:video_player/video_player.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  VideoPlayerController _videoIntroController;
  AccountController _accountController = AccountController();

  @override
  void initState() {
    super.initState();
    _videoIntroController =
        VideoPlayerController.asset('assets/video/intro.mp4');
    _videoIntroController.addListener(() {
      setState(() {});
    });
    _videoIntroController.setLooping(true);
    _videoIntroController.initialize().then((_) => setState(() {}));
    _videoIntroController.play();
  }

  @override
  void dispose() {
    super.dispose();
    _videoIntroController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: _videoIntroController.value.size?.width ?? 0,
                height: _videoIntroController.value.size?.height ?? 0,
                child: _videoIntroController.value.initialized
                    ? VideoPlayer(_videoIntroController)
                    : Container(),
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: Get.height * 0.4,
                child: SvgPicture.asset(
                  'assets/svg/logo.svg',
                  height: Get.height * 0.22,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign in to get started!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 12),
                      GetBuilder<AccountController>(
                        init: _accountController,
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              controller.signInWithGoogle();
                            },
                            child: _buildSocialButton('assets/svg/google.svg'),
                          );
                        },
                      ),
                      SizedBox(height: Get.height * 0.05)
                    ],
                  ),
                ),
              ),
            ],
          ),
          GetBuilder<AccountController>(
            init: _accountController,
            builder: (_accountController) {
              if (_accountController.showLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Container _buildSocialButton(String iconLocation) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: -10,
            blurRadius: 10,
          ),
        ],
      ),
      child: SvgPicture.asset(iconLocation),
    );
  }
}

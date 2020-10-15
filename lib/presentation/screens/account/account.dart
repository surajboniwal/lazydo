import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  VideoPlayerController _videoIntroController;

  @override
  void initState() {
    super.initState();
    _videoIntroController = VideoPlayerController.asset('assets/video/intro.mp4');
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
                child: _videoIntroController.value.initialized ? VideoPlayer(_videoIntroController) : Container(),
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.2)),
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
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/google.svg', height: 72),
                          SvgPicture.asset('assets/svg/facebook.svg', height: 72),
                          SvgPicture.asset('assets/svg/github.svg', height: 72),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.05)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

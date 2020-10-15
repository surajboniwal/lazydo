import 'package:flutter/material.dart';
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
    _videoIntroController.setLooping(false);
    _videoIntroController.initialize().then((_) => setState(() {}));
    _videoIntroController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}

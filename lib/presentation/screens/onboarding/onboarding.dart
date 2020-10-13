import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/on_boarding_header_controller.dart';
import '../../../data/models/onboarding.dart';
import 'widgets/clippers.dart';
import '../../styles/colors.dart';
import '../../widgets/disable_scroll_glow.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  AnimationController _controller;

  List<OnBoarding> _onBoardingScreens = getOnBoardingScreens();
  OnBoardingHeaderController _onBoardingHeaderController = OnBoardingHeaderController();
  PageController _pageViewScrollController = PageController(initialPage: 0);

  AnimationController _opacityController;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    //tweak duration for improving fade transition
    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() => setState(() {}));

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_opacityController);

    _opacityController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: OnBoardingTopContainerClipper(),
            child: Container(
              height: height * 0.40,
              color: AppColors.primaryColor,
              child: Center(
                child: GetBuilder<OnBoardingHeaderController>(
                  init: _onBoardingHeaderController,
                  builder: (_onBoardingHeaderController) {
                    return FadeTransition(
                      opacity: _opacity,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _onBoardingHeaderController.title,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: _onBoardingHeaderController.desc,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableScrollGlow(),
              child: PageView.builder(
                controller: _pageViewScrollController,
                itemCount: _onBoardingScreens.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Lottie.asset(
                      _onBoardingScreens[index].animationLocation,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  );
                },
                onPageChanged: (value) {
                  _opacityController.reset();
                  _opacityController.forward();
                  _onBoardingHeaderController.updateInfo(value);
                  _controller.reset();
                  _controller.forward();
                  _onBoardingHeaderController.setIcon(value);
                },
              ),
            ),
          ),
          GetBuilder<OnBoardingHeaderController>(
            init: _onBoardingHeaderController,
            builder: (controller) {
              return FloatingActionButton(
                onPressed: () {
                  if (_pageViewScrollController.page.toInt() < 2) {
                    _pageViewScrollController.animateToPage(_pageViewScrollController.page.toInt() + 1,
                        duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                  } else {
                    print('next screen');
                  }
                },
                backgroundColor: AppColors.primaryColor,
                child: Icon(controller.icon),
              );
            },
          ),
          SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _pageViewScrollController,
            count: _onBoardingScreens.length,
            effect: WormEffect(
              activeDotColor: AppColors.primaryColor,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

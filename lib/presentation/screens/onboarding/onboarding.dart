import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lazydo/data/controllers/on_boarding_header_controller.dart';
import 'package:lazydo/data/models/onboarding.dart';
import 'package:lazydo/presentation/screens/onboarding/widgets/clippers.dart';
import 'package:lazydo/presentation/styles/colors.dart';
import 'package:lazydo/presentation/widgets/disable_scroll_glow.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  double _opacityOfText = 0;
  List<OnBoarding> _onBoardingScreens = getOnBoardingScreens();
  OnBoardingHeaderController _onBoardingHeaderController = OnBoardingHeaderController();
  PageController _pageViewScrollController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _opacityOfText = 1.0;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  return AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: _opacityOfText,
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
              )),
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
                  _opacityOfText =0;
                  Future.delayed(
                    Duration(seconds: 1),
                      (){
                      _opacityOfText = 1;
                      }
                  );
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
                onPressed: () {},
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

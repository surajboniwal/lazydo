class OnBoarding {
  String title;
  String desc;
  String animationLocation;

  OnBoarding({this.title, this.desc, this.animationLocation});
}

List<OnBoarding> onBoardingScreens = [
  OnBoarding(title: 'Get Organized', desc: 'Organise all your tasks into projects.', animationLocation: 'assets/lottie/calander.json'),
  OnBoarding(title: 'Stay on Time', desc: 'Always complete all your tasks on time.', animationLocation: 'assets/lottie/time.json'),
  OnBoarding(title: 'Keep Track', desc: 'Keep track of all your project statistics.', animationLocation: 'assets/lottie/stats.json'),
];

getOnBoardingScreens() {
  return onBoardingScreens;
}

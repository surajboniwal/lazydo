import 'package:flutter/widgets.dart';

class ProfileSetupTopContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int roundness = 20;
    Path path = Path();

    path.lineTo(0.0, size.height - roundness);
    path.quadraticBezierTo(size.width * 0.5, size.height, size.width, size.height - roundness);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

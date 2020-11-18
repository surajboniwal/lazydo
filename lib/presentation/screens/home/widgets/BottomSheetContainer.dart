import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    Key key,
    @required double bottomContainerHeight,
    @required this.containerChild,
  })  : _bottomContainerHeight = bottomContainerHeight,
        super(key: key);

  final double _bottomContainerHeight;
  final Widget containerChild;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
        width: double.infinity,
        height: _bottomContainerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(0, -4),
              blurRadius: 6,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: containerChild,
      ),
    );
  }
}

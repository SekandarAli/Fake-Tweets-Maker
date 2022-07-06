// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

class AnimationforScreen extends PageRouteBuilder {
  Widget widget;

  AnimationforScreen({required this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 1200),
            transitionsBuilder: (context, animation, animationSec, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastLinearToSlowEaseIn);
              // curve: Curves.fastOutSlowIn);

              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> animationSec,
            ) {
              return widget;
            });
}

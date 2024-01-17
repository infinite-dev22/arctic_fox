import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppLoader extends StatelessWidget {
  final Color? color;
  const AppLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle
      ),
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color ?? Colors.white,
        valueColor:AlwaysStoppedAnimation<Color>( color ?? Colors.white),
      ),
    );
  }
}

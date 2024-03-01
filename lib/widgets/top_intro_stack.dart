import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopIntroStack extends StatelessWidget {
  const TopIntroStack({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: ProsteThirdOrderBezierCurve(
            position: ClipPosition.bottom,
            list: [
              ThirdOrderBezierCurveSection(
                p1: Offset(0, 200),
                p2: Offset(0, 300),
                p3: Offset(width, 200),
                p4: Offset(width, 300),
              ),
            ],
          ),
          child: Image.asset(
            'assets/auth/sky2.jpg',
          ),
        ),
        Positioned(
            top: 10.h,
            left: 10.w,
            right: 10.w,
            child: Image.asset('assets/auth/house.png'))
      ],
    );
  }
}

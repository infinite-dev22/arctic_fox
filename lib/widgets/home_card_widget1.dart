import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class HomeCardWidget1 extends StatelessWidget {
  final Color color;
  final int total;
  final String title;
  final VoidCallback function;

  const HomeCardWidget1({super.key, required this.color, required this.total, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: function,
      child: Container(
        padding: EdgeInsets.only(left: 2.w, bottom: 2.h, right: 2.w),
        height: 10.h,
        width: 42.5.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: color,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: AppTheme.buttonText,),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 3.w,
                child: Text(total.toString(), style: TextStyle(color: color),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';

class HomeCardWidget2 extends StatelessWidget {
  final String image;
  final String title;
  final int number;
  final VoidCallback function;
  final bool isAmount;
  const HomeCardWidget2({super.key, required this.image, required this.title, required this.number, required this.function, required this.isAmount});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: function,
      child: Container(
        height: 17.5.h,
        width: 42.5.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp),
              bottomRight: Radius.circular(15.sp)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            SizedBox(height: 1.h,),
            Text(title, style: AppTheme.appTitle4,),
            Text(isAmount ? '\$ ${amountFormatter.format(number.toString())}'  : amountFormatter.format(number.toString()) , style: AppTheme.orangeSubText,),

          ],
        ),
      ),
    );
  }
}

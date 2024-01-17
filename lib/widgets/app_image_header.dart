import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AppImageHeader extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? isTitleCentred;
  final VoidCallback? backFunction;

  const AppImageHeader({super.key, required this.title,  this.actions,  this.leading, this.isTitleCentred, this.backFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: AppBar(
        // backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Image.asset(title, width: 50.w,),
        centerTitle: isTitleCentred ?? false,
        actions: actions ?? [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Image.asset('assets/home/sidely.png'),
          )
        ],
        leading: leading ?? GestureDetector(
            onTap: backFunction ?? (){Get.back();},
            child:  Image.asset('assets/general/back.png')),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(10.h);

}

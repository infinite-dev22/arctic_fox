import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AppTextHeader extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? isTitleCentred;

  const AppTextHeader({super.key, required this.title,  this.actions,  this.leading, this.isTitleCentred});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title, style: AppTheme.appTitle3,),
        centerTitle: isTitleCentred ?? false,
        actions: actions ?? [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Image.asset('assets/home/sidely.png'),
          )
        ],
        leading: leading ?? GestureDetector(onTap: (){Get.back();},child:  Image.asset('assets/general/back.png')),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(10.h);

}

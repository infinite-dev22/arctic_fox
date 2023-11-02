import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AppImageHeader extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const AppImageHeader({super.key, required this.title,  this.actions,  this.leading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(title, width: 50.w,),
        actions: actions ?? [],
        leading: leading,
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(10.h);

}

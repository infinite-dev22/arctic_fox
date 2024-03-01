import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const AppHeader({super.key, this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppTheme.primaryColor,
      automaticallyImplyLeading: false,
      title: Text(
        title ?? '',
        style: AppTheme.appTitle3,
      ),
      centerTitle: true,
      actions: actions ??
          [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Image.asset('assets/home/sidely.png'),
            ),
          ],
      leading: leading ??
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: leading ?? Image.asset('assets/general/back.png')),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(7.5.h);
}

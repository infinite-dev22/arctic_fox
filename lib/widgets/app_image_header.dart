import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class AppImageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? isTitleCentred;
  final VoidCallback? backFunction;
  final PreferredSizeWidget? bottom;

  const AppImageHeader(
      {super.key,
      required this.title,
      this.actions,
      this.leading,
      this.isTitleCentred,
      this.backFunction,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      automaticallyImplyLeading: false,
      title: Image.asset(
        title,
        width: 70.w,
        color: Colors.white,
      ),
      centerTitle: isTitleCentred ?? false,
      bottom: bottom,
      actions: actions ??
          [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Image.asset(
                'assets/home/sidely.png',
                color: Colors.white,
              ),
            )
          ],
      leading: leading ??
          GestureDetector(
              onTap: backFunction ??
                  () {
                    Get.back();
                  },
              child: Image.asset(
                'assets/general/back.png',
                color: Colors.white,
              )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}

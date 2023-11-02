import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AppHeader extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const AppHeader({super.key,  this.title,  this.actions,  this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title ?? '', style: AppTheme.appTitle3,),
      centerTitle: true,
      actions: actions ?? [],
      leading: leading,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(7.5.h);

}

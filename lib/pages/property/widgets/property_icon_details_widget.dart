import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class PropertyIconDetailsWidget extends StatelessWidget {
  final IconData? icon;
  final String detail;

  const PropertyIconDetailsWidget({super.key, this.icon, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon == null ? Container() : FaIcon(icon, size: 17.5.sp),
          SizedBox(
            width: 2.w,
          ),
          Text(
            detail,
            style: AppTheme.subText,
          )
        ],
      ),
    );
  }
}

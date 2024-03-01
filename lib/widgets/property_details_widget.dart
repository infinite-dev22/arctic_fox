import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class PropertyDetailsWidget extends StatelessWidget {
  final String? icon;
  final String detail;

  const PropertyDetailsWidget({super.key, this.icon, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          icon == null ? Container() : Image.asset(icon.toString()),
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

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class PropertyOptionsWidget extends StatefulWidget {
  final String title;
  const PropertyOptionsWidget({super.key, required this.title});

  @override
  State<PropertyOptionsWidget> createState() => _PropertyOptionsWidgetState();
}

class _PropertyOptionsWidgetState extends State<PropertyOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 1.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title, style: AppTheme.darkBlueText1,),
              SizedBox(width: 5.w,),
              Image.asset('assets/home/add.png', width: 5.w),
            ],
          ),
          SizedBox(height: 2.h,),
          Divider(
            height: 2,
            color: AppTheme.greyTextColor1,
          )
        ],
      ),
    );
  }
}

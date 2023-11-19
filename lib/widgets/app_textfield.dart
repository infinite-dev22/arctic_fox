import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final String? title;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.fillColor,
    this.style,
    this.enabled = true,
    this.title,
    this.validator,
    this.keyBoardType,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null ? Container() : Text(title ?? '', style: AppTheme.appFieldTitle,),
        title == null ? Container() : SizedBox(height: 1.h,),
        SizedBox(
          height: 8.5.h,
          child: TextFormField(
            onTap: onTap,
            // validator: (val) =>
            // val!.isEmpty ? 'Required field, Please fill in.' : null,
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            style: style,
            enabled: enabled,
            decoration: InputDecoration(
              focusedBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              )
                  : null,
              enabledBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              )
                  : null,
              border: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              fillColor: fillColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
            keyboardType: keyBoardType ?? TextInputType.emailAddress,
            // maxLines: 10,
          ),
        ),
      ],
    );
  }
}
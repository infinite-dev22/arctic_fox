import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class AppSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final String? title;
  final VoidCallback function;
  final int number;

  const AppSearchTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.isEmail = false,
      this.borderSide = BorderSide.none,
      this.fillColor = AppTheme.fillColor,
      this.style,
      this.enabled = true,
      this.title,
      required this.function,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 6.5.h,
          child: TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Required field, Please fill in.' : null,
            controller: controller,
            obscureText: obscureText,
            style: style,
            enabled: enabled,
            decoration: InputDecoration(
              focusedBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    )
                  : null,
              enabledBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              // fillColor: fillColor,
              fillColor: AppTheme.itemBgColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
              suffixIcon: Image.asset('assets/home/filter.png'),
              prefixIcon: Image.asset('assets/home/search.png'),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        SizedBox(
          height: 1.h,
        ),
        //
        // userStorage.read('roleId') == 4 ? Container() : Align(alignment: Alignment.centerRight, child: Bounceable(
        //   onTap: function,
        //   child: Container(
        //     width: 10.w,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10.sp),
        //       color: AppTheme.primaryColor,
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Center(
        //         child: Icon(Icons.add, color: Colors.white,),
        //       ),
        //     ),
        //   ),
        // )),

        Text(
          'Your properties',
          style: AppTheme.appTitle1,
        ),
        Text(
          '$number ${number > 1 ? 'properties' : 'property'}',
          style: AppTheme.subText,
        ),
      ],
    );
  }
}

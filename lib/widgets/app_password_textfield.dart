import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/styles/app_theme.dart';

class AppPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final BorderSide borderSide;
  final Color fillColor;
  final Color iconColor;
  final bool enabled;
  final TextStyle? style;
  final String? title;

  const AppPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.fillColor,
    this.iconColor = AppTheme.darkerColor,
    this.style,
    this.enabled = true,
    this.title
  });

  @override
  State<AppPasswordTextField> createState() => _AuthPasswordTextField();
}

class _AuthPasswordTextField extends State<AppPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title ?? '', style: AppTheme.appFieldTitle,),
        SizedBox(height: 1.h,),
        SizedBox(
          height: 6.5.h,
          child: TextFormField(
            validator: (val) =>
            val!.isEmpty ? 'Required field, Please fill in.' : null,
            controller: widget.controller,
            obscureText: obscure,
            style: widget.style,
            enabled: widget.enabled,
            decoration: InputDecoration(
              focusedBorder: (widget.borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              )
                  : null,
              enabledBorder: (widget.borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              )
                  : null,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility_rounded,
                    color: widget.iconColor,
                  )),
              border: OutlineInputBorder(
                borderSide: widget.borderSide,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              fillColor: widget.fillColor,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppTheme.inActiveColor,
                fontSize: 16.sp,
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
      ],
    );
  }
}

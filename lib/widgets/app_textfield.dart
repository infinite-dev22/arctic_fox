import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
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
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final void Function(String)? onChanged;

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
    this.onTap,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.onChanged
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
          height: 50,
          child: TextFormField(
            minLines: minLines,
            maxLength: maxLength,
            maxLines: maxLines,
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
              // fillColor: AppTheme.textBoxColor,
              fillColor: AppTheme.appBgColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
              ),

            ),
            keyboardType: keyBoardType ?? TextInputType.emailAddress,
            onChanged: onChanged,
            // onChanged: (value){
            //   print(value);
            // },
            // maxLines: 10,
          ),
        ),
      ],
    );
  }
}



class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyBoardType;

  const AuthTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onTap, this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: AppTheme.gray45,
        validator: (val) =>
        val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        style: style,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
              width: 2.0,
            ),
          )
              : null,
          enabledBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          // fillColor: fillColor,
          fillColor: AppTheme.appBgColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
        ),
        keyboardType: keyBoardType ?? TextInputType.emailAddress,
        onTap: onTap,

      ),
    );
  }
}


class AmountTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? suffix;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyBoardType;

  const AmountTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onTap, this.keyBoardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: AppTheme.gray45,
        validator: (val) =>
        val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        style: style,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
              width: 2.0,
            ),
          )
              : null,
          enabledBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          // fillColor: fillColor,
          fillColor: AppTheme.appBgColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
          suffix: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(suffix.toString()),
              )),
        ),
        keyboardType: keyBoardType ?? TextInputType.emailAddress,
        onTap: onTap,
      ),
    );
  }
}


class DateTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;

  const DateTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: AppTheme.gray45,
        validator: (val) =>
        val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        style: style,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
              width: 2.0,
            ),
          )
              : null,
          enabledBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          // fillColor: fillColor,
          fillColor: AppTheme.appBgColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
          prefix: Text(hintText),
          suffix: Card(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(controller!.text.toString()),
              )),
        ),
        keyboardType: TextInputType.emailAddress,
        onTap: onTap,
        showCursor: false,
        cursorHeight: 0,
        cursorRadius: Radius.zero,
        cursorWidth: 0,
      ),
    );
  }
}


class DateTextField2 extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TenantController? tenantController;

  const DateTextField2({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.tenantController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: AppTheme.gray45,
        validator: (val) =>
        val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        style: style,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
              width: 2.0,
            ),
          )
              : null,
          enabledBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          // fillColor: fillColor,
          fillColor: AppTheme.appBgColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
          prefix: Text(hintText),
          suffix: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Obx(() {
                  return tenantController!.tenantUnitAmount.value == 0 ? Container() : Text(controller!.text.toString());
                }),
              )),
        ),
        keyboardType: TextInputType.emailAddress,
        onTap: onTap,
        showCursor: false,
        cursorHeight: 0,
        cursorRadius: Radius.zero,
        cursorWidth: 0,
      ),
    );
  }
}


class AppDateTextField extends StatelessWidget {
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
  final int? maxLines;
  final int? maxLength;
  final int? minLines;

  const AppDateTextField({
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
    this.onTap,
    this.maxLines,
    this.maxLength,
    this.minLines,
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
            minLines: minLines,
            maxLength: maxLength,
            maxLines: maxLines,
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
              fillColor: AppTheme.textBoxColor,
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
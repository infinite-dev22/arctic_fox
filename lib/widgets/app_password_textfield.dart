import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_rent/styles/app_theme.dart';

class AppPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final BorderSide borderSide;
  final Color fillColor;
  final Color iconColor;
  final bool enabled;
  final TextStyle? style;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const AppPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.iconColor = AppTheme.darker,
    this.style,
    this.enabled = true,
    this.onTap,
    this.inputFormatters,
  });

  @override
  State<AppPasswordTextField> createState() => _AppPasswordTextField();
}

class _AppPasswordTextField extends State<AppPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        inputFormatters: widget.inputFormatters ??
            [
              LengthLimitingTextInputFormatter(30),
            ],
        cursorColor: AppTheme.gray45,
        validator: (val) =>
            val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: widget.controller,
        obscureText: obscure,
        style: widget.style,
        enabled: widget.enabled,
        decoration: InputDecoration(
          focusedBorder: (widget.borderSide != BorderSide.none)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppTheme.gray45,
                    width: 2.0,
                  ),
                )
              : null,
          enabledBorder: (widget.borderSide != BorderSide.none)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppTheme.gray45,
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
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: widget.fillColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        onTap: widget.onTap,
      ),
    );
  }
}

//
// class AppPasswordTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final BorderSide borderSide;
//   final Color fillColor;
//   final Color iconColor;
//   final bool enabled;
//   final TextStyle? style;
//   final String? title;
//   final String? Function(String?)? validator;
//   final String value;
//
//   const AppPasswordTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.borderSide = BorderSide.none,
//     this.fillColor = AppTheme.fillColor,
//     this.iconColor = AppTheme.darkerColor,
//     this.style,
//     this.enabled = true,
//     this.title,
//     this.validator,
//     this.value = '',
//   });
//
//   @override
//   State<AppPasswordTextField> createState() => _AuthPasswordTextField();
// }
//
// class _AuthPasswordTextField extends State<AppPasswordTextField> {
//   bool obscure = true;
//   String? password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title ?? '', style: AppTheme.appFieldTitle,),
//         SizedBox(height: 1.h,),
//         SizedBox(
//           height: 8.5.h,
//           child: TextFormField(
//
//             // validator: (val) =>
//             // val!.isEmpty ? 'Required field, Please fill in.' : null,
//             validator: widget.validator,
//             controller: widget.controller,
//             onChanged: (val){
//               // password = val;
//               // setState(() {
//               //
//               // });
//             },
//             obscureText: obscure,
//             style: widget.style,
//             enabled: widget.enabled,
//             decoration: InputDecoration(
//               focusedBorder: (widget.borderSide != BorderSide.none)
//                   ? OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15.sp),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                   width: 2.0,
//                 ),
//               )
//                   : null,
//               enabledBorder: (widget.borderSide != BorderSide.none)
//                   ? OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15.sp),
//                 borderSide: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               )
//                   : null,
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       obscure = !obscure;
//                     });
//                   },
//                   icon: Icon(
//                     obscure ? Icons.visibility_off : Icons.visibility_rounded,
//                     color: widget.iconColor,
//                   )),
//               border: OutlineInputBorder(
//                 borderSide: widget.borderSide,
//                 borderRadius: BorderRadius.circular(15.sp),
//               ),
//               fillColor: widget.fillColor,
//               filled: true,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: AppTheme.inActiveColor,
//                 fontSize: 16.sp,
//               ),
//             ),
//             keyboardType: TextInputType.visiblePassword,
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smart_rent/screens/auth/complete_signup_screen.dart';
// import 'package:smart_rent/styles/app_theme.dart';
// import 'package:smart_rent/widgets/app_button.dart';
// import 'package:smart_rent/widgets/app_password_textfield.dart';
// import 'package:smart_rent/widgets/app_textfield.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
//           child: Center(
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Center(child: Image.asset('assets/auth/otp.png')),
//
//                   Text('Sign up' , style: AppTheme.appTitleLarge,),
//
//                   AppTextField(
//                     title: 'VERIFY THROUGH EMAIL',
//                     controller: emailController,
//                     hintText: 'email',
//                     obscureText: false,
//                   ),
//
//                   SizedBox(height: 3.h,),
//
//                   AppButton(
//                       title: 'Verify',
//                       color: AppTheme.darkerColor,
//                       function: (){
//                         Get.snackbar('INFO', 'Please check your email',
//                           titleText: Text('INFO', style: AppTheme.appTitle3,),
//                         );
//                       }),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                      width: 42.5.w,
//                         child: AppPasswordTextField(
//                           // title: 'PASSWORD',
//                           controller: passwordController,
//                           hintText: 'password',
//                         ),
//                       ),
//
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(height: 1.h,),
//                           Text(''),
//                           AppButton(
//                             width: 42.5.w,
//                               title: 'Get code',
//                               color: AppTheme.primaryColor,
//                               function: (){
//                                 Get.snackbar('OTP', 'Your OTP is 1234',
//                                   titleText: Text('OTP', style: AppTheme.appTitle3,),
//                                 );
//                               }),
//                         ],
//                       ),
//
//                     ],
//                   ),
//
//                   SizedBox(height: 5.h,),
//
//                   AppButton(
//                     title: 'Next',
//                     color: AppTheme.primaryColor,
//                     function: (){
//                       Get.to(() => CompleteSignUpScreen(), transition: Transition.rightToLeftWithFade);
//                     },
//                   ),
//                   SizedBox(height: 1.h,),
//                   Center(child: Bounceable(
//                     onTap: (){
//                       Get.back();
//                     },
//                       child: Text('back to login', style: AppTheme.subTextBold,))),
//
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:animate_do/animate_do.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smart_rent/controllers/user/auth_controller.dart';
// import 'package:smart_rent/styles/app_theme.dart';
// import 'package:smart_rent/widgets/app_button.dart';
//
// class VerifyEmailOtpComponent extends StatelessWidget {
//   final String email;
//
//   const VerifyEmailOtpComponent({super.key, required this.email,});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController p1 = TextEditingController();
//     final AuthController authController = Get.put(AuthController());
//     return Container(
//       // height: 50.h,
//       width: 30.w,
//       decoration: BoxDecoration(
//         // color: Colors.red,
//         borderRadius: BorderRadius.circular(15.sp),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: 3.w, vertical: 2.h),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 1.h,),
//             Text('Verify with OTP', style: AppTheme.blueAppTitle,),
//             SizedBox(height: 1.h,),
//             Row(
//               children: [
//                 Text('OTP sent to ', style: AppTheme.blueSubText,),
//                 Text(email, style: AppTheme.appFieldTitle,),
//               ],
//             ),
//             SizedBox(height: 3.h,),
//
//             FadeInRight(
//               child: Pinput(
//                 length: 6,
//                 controller: p1,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 validator: (otp) {
//                   return null;
//                 },
//                 // onChanged: (value){
//                 //   setState((){
//                 //     code = value;
//                 //   });
//                 // },
//                 defaultPinTheme: PinTheme(
//                   height: 5.h,
//                   width: 5.w,
//                   decoration: BoxDecoration(
//                     color: AppTheme.appBgColor,
//                     borderRadius: BorderRadius.circular(10.sp),
//                   ),
//                   textStyle: TextStyle(
//                     color: AppTheme.primaryColor,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 errorPinTheme: PinTheme(
//                   height: 5.h,
//                   width: 5.w,
//                   decoration: BoxDecoration(
//                     color: AppTheme.appBgColor,
//                     borderRadius: BorderRadius.circular(10.sp),
//                     border: Border.all(
//                       color: Colors.red, width: 2,
//                     ),
//                   ),
//                   textStyle: TextStyle(
//                     color: AppTheme.primaryColor,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//
//
//             ZoomIn(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 3.h),
//                 child: Center(
//                   child: SizedBox(
//                     width: 10.w,
//                     child: Obx(() {
//                       return AppButton(
//                           isLoading: authController.isVerifyEmailOtpLoading.value,
//                           width: 10.w,
//                           title: 'Verify',
//                           color: AppTheme.primaryColor,
//                           function: () async {
//
//                             print(p1.text.toString());
//
//
//                             authController.verifyEmailOtp(
//                                 email.toString(), p1.text.toString());
//
//                           });
//                     }),
//                   ),
//                 ),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }

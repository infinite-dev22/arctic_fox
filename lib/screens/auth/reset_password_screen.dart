import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/auth_controller.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController otpTokenController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final AuthController authController = Get.put(AuthController());

  bool isEmailValid(String email) {
    return GetUtils.isEmail(email);
  }

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.appBgColor,
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(child: Image.asset('assets/auth/otp.png')),

                  Text(
                    'Reset Password',
                    style: AppTheme.appTitle2,
                  ),
                  Text(
                    'Enter OTP sent to ${widget.email}',
                    style: AppTheme.blueSubText,
                  ),

                  FadeInRight(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Pinput(
                        length: 6,
                        controller: otpTokenController,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        validator: (otp) {
                          return null;
                        },
                        // onChanged: (value){
                        //   setState((){
                        //     code = value;
                        //   });
                        // },
                        defaultPinTheme: PinTheme(
                          height: 10.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppTheme.appWidgetColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          textStyle: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        errorPinTheme: PinTheme(
                          height: 10.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppTheme.appWidgetColor,
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          textStyle: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // AuthTextField(
                  //   isEmail: true,
                  //   controller: otpTokenController,
                  //   hintText: 'Enter Reset OTP',
                  //   obscureText: false,
                  //
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),

                  AppPasswordTextField(
                    controller: passwordEditingController,
                    hintText: 'Enter New Password',
                    fillColor: AppTheme.appWidgetColor,
                    // validator: passwordValidator,
                  ),

                  // AppDateTextField(
                  //     controller: emailEditingController,
                  //     hintText: 'Email', obscureText: false,
                  //   validator: emailValidator,
                  // ),

                  SizedBox(
                    height: 3.h,
                  ),

                  Obx(() {
                    return AppButton(
                        isLoading: authController.isResetPasswordLoading.value,
                        title: 'Reset Password',
                        color: AppTheme.primaryColor,
                        function: () async {
                          if (passwordEditingController.text.isEmpty &&
                              otpTokenController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'all fields required',
                                gravity: ToastGravity.TOP);
                          } else if (passwordEditingController.text.length <
                              6) {
                            Fluttertoast.showToast(
                                msg: 'Password is short',
                                gravity: ToastGravity.TOP);
                          } else if (otpTokenController.text.length < 6) {
                            Fluttertoast.showToast(
                                msg: 'Otp is short', gravity: ToastGravity.TOP);
                          } else {
                            await authController.resetUserPassword(
                              widget.email,
                              otpTokenController.text.trim().toString(),
                              passwordEditingController.text.trim().toString(),
                            );

                            // await authController.resetPassword(
                            //     widget.email, passwordEditingController.text.trim());
                          }
                        });
                  }),
                  SizedBox(
                    height: 1.h,
                  ),
                  Center(
                      child: Bounceable(
                          onTap: () {
                            Get.off(() => InitialScreen());
                          },
                          child: Text(
                            'back',
                            style: AppTheme.subTextBold,
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

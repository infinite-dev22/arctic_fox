import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/auth_controller.dart';
import 'package:smart_rent/screens/auth/complete_signup_screen.dart';
import 'package:smart_rent/screens/auth/login_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController otpTokenController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

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

                  Text('Reset Password' , style: AppTheme.appTitle2,),

                  // AuthTextField(
                  //   isEmail: true,
                  //   controller: otpTokenController,
                  //   hintText: 'Enter Reset OTP',
                  //   obscureText: false,
                  //
                  // ),
                  SizedBox(height: 2.h,),

                  AppPasswordTextField(
                    controller: passwordEditingController,
                    hintText: 'Enter New Password',
                    fillColor: AppTheme.appBgColor,
                    // validator: passwordValidator,
                  ),

                  // AppDateTextField(
                  //     controller: emailEditingController,
                  //     hintText: 'Email', obscureText: false,
                  //   validator: emailValidator,
                  // ),


                  SizedBox(height: 3.h,),

                  AppButton(
                      title: 'Reset Password',
                      color: AppTheme.primaryColor,
                      function: ()async{


                        if(passwordEditingController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Password required');
                        } else if (passwordEditingController.text.length <6) {
                          Fluttertoast.showToast(msg: 'Password is short');
                        }  else {
                          await authController.resetPassword(
                              widget.email, passwordEditingController.text.trim());
                        }

                      }


                  ),
                  SizedBox(height: 1.h,),
                  Center(child: Bounceable(
                      onTap: (){
                        Get.back();
                      },
                      child: Text('back to login', style: AppTheme.subTextBold,))),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

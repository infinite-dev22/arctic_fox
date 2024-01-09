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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController emailEditingController = TextEditingController();
  AuthController authController = Get.put(AuthController());

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

                  Text('Forgot Password', style: AppTheme.appTitle2,),

                  AuthTextField(
                    isEmail: true,
                    controller: emailEditingController,
                    hintText: 'Email',
                    obscureText: false,

                  ),

                  // AppDateTextField(
                  //     controller: emailEditingController,
                  //     hintText: 'Email', obscureText: false,
                  //   validator: emailValidator,
                  // ),


                  SizedBox(height: 3.h,),

                  Obx(() {
                    return AppButton(
                      isLoading: authController.isSendOtpLoading.value,
                        title: 'Send Reset Code',
                        color: AppTheme.primaryColor,
                        function: () async {
                          String email = emailEditingController.text.trim();
                          bool isValid = isEmailValid(email);

                          if (email.isEmpty) {
                            Fluttertoast.showToast(msg: 'Email Required');
                          } else if (!isValid) {
                            Fluttertoast.showToast(msg: 'Enter Correct Email');
                          } else {
                            await authController.checkUserEmailAvailability(
                                email);

                            // print('Okay');
                            // await authController.sendResetOtp(email);
                            // Fluttertoast.showToast(msg: 'Enter New Password');

                          }
                        }


                    );
                  }),
                  SizedBox(height: 1.h,),
                  Center(child: Bounceable(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'back to login', style: AppTheme.subTextBold,))),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

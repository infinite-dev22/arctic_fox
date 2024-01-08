import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/auth_controller.dart';
import 'package:smart_rent/screens/auth/complete_signup_screen.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/screens/auth/login_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class VerifyPhoneOtpScreen extends StatefulWidget {
  final String phone;
  const VerifyPhoneOtpScreen({super.key, required this.phone});

  @override
  State<VerifyPhoneOtpScreen> createState() => _VerifyPhoneOtpScreenState();
}

class _VerifyPhoneOtpScreenState extends State<VerifyPhoneOtpScreen> {

  final TextEditingController otpTokenController = TextEditingController();
  late TextEditingController phoneEditingController;

  final AuthController authController = Get.put(AuthController());

  bool isEmailValid(String email) {
    return GetUtils.isEmail(email);
  }

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneEditingController = TextEditingController(text: widget.phone);

  }

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

                  Text('Verify Phone' , style: AppTheme.appTitle2,),

                  AuthTextField(
                    isEmail: false,
                    controller: otpTokenController,
                    hintText: 'Enter sent OTP',
                    obscureText: false,

                  ),
                  SizedBox(height: 2.h,),

                  AuthTextField(
                    obscureText: false,
                    controller: phoneEditingController,
                    hintText: 'Phone account',
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
                      title: 'Verify Otp',
                      color: AppTheme.primaryColor,
                      function: ()async{


                        if(phoneEditingController.text.isEmpty && otpTokenController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'all fields required');
                        } else if (phoneEditingController.text.length <12) {
                          Fluttertoast.showToast(msg: 'Phone is short');
                        }  else if (otpTokenController.text.length <5) {
                          Fluttertoast.showToast(msg: 'Otp is short');
                        } else {

                          await authController.verifyPhoneOtp(
                              otpTokenController.text.trim().toString(),
                              phoneEditingController.text.trim().toString(),
                          );

                          // await authController.resetUserPassword(
                          //   widget.phone,
                          //   otpTokenController.text.trim().toString(),
                          //   phoneEditingController.text.trim().toString(),
                          // );


                        }

                      }


                  ),
                  SizedBox(height: 1.h,),
                  Center(child: Bounceable(
                      onTap: (){
                        Get.off(() => InitialScreen());
                      },
                      child: Text('back', style: AppTheme.subTextBold,))),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

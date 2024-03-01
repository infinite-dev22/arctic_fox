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

class VerifyEmailOtpScreen extends StatefulWidget {
  final String email;

  const VerifyEmailOtpScreen({super.key, required this.email});

  @override
  State<VerifyEmailOtpScreen> createState() => _VerifyEmailOtpScreenState();
}

class _VerifyEmailOtpScreenState extends State<VerifyEmailOtpScreen> {
  final TextEditingController otpTokenController = TextEditingController();
  late TextEditingController emailEditingController;

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
    emailEditingController = TextEditingController(text: widget.email);
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

                  Text(
                    'Verify Email',
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

                  SizedBox(
                    height: 3.h,
                  ),

                  Obx(() {
                    return AppButton(
                        isLoading: authController.isVerifyEmailOtpLoading.value,
                        title: 'Verify Otp',
                        color: AppTheme.primaryColor,
                        function: () async {
                          if (otpTokenController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'otp required', gravity: ToastGravity.TOP);
                          } else if (otpTokenController.text.length < 6) {
                            Fluttertoast.showToast(
                                msg: 'Otp is short', gravity: ToastGravity.TOP);
                          } else {
                            await authController.verifyEmailOtp(
                              widget.email.toString(),
                              otpTokenController.text.trim().toString(),
                            );

                            // await authController.resetUserPassword(
                            //   widget.phone,
                            //   otpTokenController.text.trim().toString(),
                            //   phoneEditingController.text.trim().toString(),
                            // );
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

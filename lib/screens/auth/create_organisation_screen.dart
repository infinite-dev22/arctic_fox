import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/screens/auth/complete_signup_screen.dart';
import 'package:smart_rent/screens/auth/login_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class CreateOrganisationScreen extends StatefulWidget {
  const CreateOrganisationScreen({super.key});

  @override
  State<CreateOrganisationScreen> createState() =>
      _CreateOrganisationScreenState();
}

class _CreateOrganisationScreenState extends State<CreateOrganisationScreen> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final businessNameValidator = MultiValidator([
    RequiredValidator(errorText: 'business name required'),
    MinLengthValidator(5, errorText: 'business name too short'),
    MaxLengthValidator(50, errorText: 'first name too long'),
  ]);
  final descriptionValidator = MultiValidator([
    RequiredValidator(errorText: 'description required'),
    MinLengthValidator(5, errorText: 'description too short'),
    MaxLengthValidator(100, errorText: 'description too long'),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(child: Image.asset('assets/auth/otp.png')),

                    Text(
                      'Create Organization',
                      style: AppTheme.appTitle2,
                    ),

                    AuthTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(25),
                      ],
                      controller: businessNameController,
                      hintText: 'Business Name',
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),

                    DescriptionTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(35),
                      ],
                      controller: descriptionController,
                      hintText: 'Description',
                      obscureText: false,
                    ),

                    SizedBox(
                      height: 3.h,
                    ),

                    AppButton(
                      title: 'Next',
                      color: AppTheme.primaryColor,
                      function: () {
                        if (businessNameController.text.isEmpty &&
                            descriptionController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Fill all Fields',
                              gravity: ToastGravity.TOP);
                        } else if (businessNameController.text.length < 5) {
                          Fluttertoast.showToast(
                              msg: 'Short business name',
                              gravity: ToastGravity.TOP);
                        } else if (descriptionController.text.length < 5) {
                          Fluttertoast.showToast(
                              msg: 'Too short description',
                              gravity: ToastGravity.TOP);
                        } else {
                          Get.to(
                                  () => CompleteSignUpScreen(
                                        businessName: businessNameController
                                            .text
                                            .toString(),
                                        description: descriptionController.text
                                            .toString(),
                                      ),
                                  transition: Transition.rightToLeftWithFade)!
                              .then((value) {
                            businessNameController.clear();
                            descriptionController.clear();
                            Get.to(LoginScreen());
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Center(
                        child: Bounceable(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              'back to login',
                              style: AppTheme.subTextBold,
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

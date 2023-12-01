import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class CompleteSignUpScreen extends StatefulWidget {
  final String businessName;
  final String description;
  const CompleteSignUpScreen({super.key, required this.businessName, required this.description});

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {

  final TextEditingController firstNameEditingController = TextEditingController();
  final TextEditingController lastNameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController confirmPasswordEditingController = TextEditingController();

  var userList = [
    'admin',
    'manager',
    'user'
  ];

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(5, errorText: 'password must be at least 5 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);


  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);
  final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'last name required'),
    MinLengthValidator(2, errorText: 'last name too short'),
    MaxLengthValidator(15, errorText: 'last name too long'),
  ]);

  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(height: 2.h,),
                  // Center(child: Text('Congratulations', style: AppTheme.appTitle1,)),
                  // Center(child: Text('on verifying the email belongs to you', style: AppTheme.blueSubText,)),
                  // SizedBox(height: 3.h,),
                  Center(child: Text('Sign Up', style: AppTheme.appTitle2,)),
                  Center(child: Text('we need something more', style: AppTheme.blueSubText,)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 42.5.w,
                        child: AppTextField(
                            controller: firstNameEditingController,
                            hintText: 'Firstname',
                            obscureText: false,
                          validator: firstNameValidator,

                        ),
                      ),

                      SizedBox(
                        width: 42.5.w,
                        child: AppTextField(
                          controller: lastNameEditingController,
                          hintText: 'Lastname',
                          obscureText: false,
                          validator: lastNameValidator,
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 3.h,),

                  AppTextField(
                    isEmail: true,
                    controller: emailEditingController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: emailValidator,
                  ),

                  AppPasswordTextField(
                      controller: passwordEditingController,
                      hintText: 'Password',
                    validator: passwordValidator,
                  ),

                  // AppPasswordTextField(
                  //   controller: confirmPasswordEditingController,
                  //   hintText: 'Confirm Password',
                  //   validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val.toString(), ),
                  // ),

                  SizedBox(height: 3.h,),

                  // Text('TYPE OF USER', style: AppTheme.appFieldTitle,),
                  // CustomGenericDropdown<String>(
                  //     hintText: 'Choose your user-type',
                  //   menuItems: userList,
                  //   onChanged: (value){
                  //
                  //   },
                  // ),

                  SizedBox(height: 3.h,),

                  AppButton(
                      title: 'Submit',
                      color: AppTheme.primaryColor,
                      function: (){

                        if(_formKey.currentState!.validate()){
                          // userController.signUpUser(UserModel(email: widget.description, password: widget.businessName));

                          userController.createUser(
                            emailEditingController.text.trim().toString(),
                            passwordEditingController.text.trim().toString(),
                            widget.businessName.toString(),
                            widget.description.toString(),
                            firstNameEditingController.text.trim().toString(),
                            lastNameEditingController.text.trim().toString(),
                          );

                          // userController.signUpUser(
                          //     emailEditingController.text.trim().toString(),
                          //     passwordEditingController.text.trim().toString(),
                          //     firstNameEditingController.text.trim().toString(),
                          //     lastNameEditingController.text.trim().toString(),
                          //     widget.businessName.toString(),
                          //     widget.description.toString(),
                          // );

                          // Get.off(() => BottomNavBar(), transition: Transition.rightToLeftWithFade);
                          // Get.snackbar('SUCCESS', 'Account created successfully',
                          //   titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
                          // );

                        } else {

                        }

                      }),

                  SizedBox(height: 5.h,),

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

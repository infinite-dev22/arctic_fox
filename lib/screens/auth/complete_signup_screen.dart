import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      backgroundColor: AppTheme.whiteColor,
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
                        child: AuthTextField(
                            controller: firstNameEditingController,
                            hintText: 'Firstname',
                            obscureText: false,

                        ),
                      ),

                      SizedBox(
                        width: 42.5.w,
                        child: AuthTextField(
                          controller: lastNameEditingController,
                          hintText: 'Lastname',
                          obscureText: false,

                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 1.h,),

                  AuthTextField(
                    isEmail: true,
                    controller: emailEditingController,
                    hintText: 'Email',
                    obscureText: false,

                  ),
                  SizedBox(height: 1.h,),

                  AppPasswordTextField(
                      controller: passwordEditingController,
                      hintText: 'Password',
                    fillColor: AppTheme.appBgColor,
                    // validator: passwordValidator,
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


                  AppButton(
                      title: 'Submit',
                      color: AppTheme.primaryColor,
                      function: () async{

                        if(firstNameEditingController.text.isEmpty && lastNameEditingController.text.isEmpty &&
                            emailEditingController.text.isEmpty && passwordEditingController.text.isEmpty
                        ) {
                          Fluttertoast.showToast(msg: 'fill in all fields');

                        } else {

                          await userController.createUser(
                            emailEditingController.text.trim().toString(),
                            passwordEditingController.text.trim().toString(),
                            widget.businessName.toString(),
                            widget.description.toString(),
                            firstNameEditingController.text.trim().toString(),
                            lastNameEditingController.text.trim().toString(),
                          ).then((value) {
                            emailEditingController.clear();
                            passwordEditingController.clear();
                            firstNameEditingController.clear();
                            lastNameEditingController.clear();
                          });

                        }

                        // if(_formKey.currentState!.validate()){
                        //   // userController.signUpUser(UserModel(email: widget.description, password: widget.businessName));
                        //
                        //   userController.createUser(
                        //     emailEditingController.text.trim().toString(),
                        //     passwordEditingController.text.trim().toString(),
                        //     widget.businessName.toString(),
                        //     widget.description.toString(),
                        //     firstNameEditingController.text.trim().toString(),
                        //     lastNameEditingController.text.trim().toString(),
                        //   );
                        //
                        // } else {
                        //
                        // }

                      }),

                  SizedBox(height: 3.h,),

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

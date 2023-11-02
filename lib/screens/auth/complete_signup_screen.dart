import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_drop_downs.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class CompleteSignUpScreen extends StatefulWidget {
  const CompleteSignUpScreen({super.key});

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {

  final TextEditingController firstNameEditingController = TextEditingController();
  final TextEditingController lastNameEditingController = TextEditingController();
  final TextEditingController emailNameEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController confirmPasswordEditingController = TextEditingController();

  List<SmartModel> menuList = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Center(child: Text('Congratulations', style: AppTheme.appTitle1,)),
                Center(child: Text('on verifying the email belongs to you', style: AppTheme.blueSubText,)),
                SizedBox(height: 3.h,),
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
                      ),
                    ),

                    SizedBox(
                      width: 42.5.w,
                      child: AppTextField(
                        controller: lastNameEditingController,
                        hintText: 'Lastname',
                        obscureText: false,
                      ),
                    ),

                  ],
                ),

                AppTextField(
                  isEmail: true,
                  controller: emailNameEditingController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                AppPasswordTextField(
                    controller: passwordEditingController,
                    hintText: 'Passcode',
                ),

                AppPasswordTextField(
                  controller: passwordEditingController,
                  hintText: 'Confirm passcode',
                ),

                SizedBox(height: 3.h,),

                Text('TYPE OF USER', style: AppTheme.appFieldTitle,),
                CustomGenericDropdown(
                    hintText: 'Choose your user-type',
                  menuItems: menuList,
                ),

                SizedBox(height: 3.h,),

                AppButton(
                    title: 'Submit',
                    color: AppTheme.primaryColor,
                    function: (){
                      Get.to(() => HomePage(), transition: Transition.rightToLeftWithFade);
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
    );
  }
}

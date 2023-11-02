import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/screens/auth/signup_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  Image.asset('assets/auth/logo.png', width: 50.w,),

                  Text('Sign in' , style: AppTheme.appTitleLarge,),

                  AppTextField(
                    title: 'YOUR EMAIL',
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false,
                  ),

                  SizedBox(height: 3.h,),

                  AppPasswordTextField(
                    title: 'PASSWORD',
                      controller: passwordController,
                      hintText: 'password',
                  ),

                  SizedBox(height: 5.h,),

                  AppButton(
                      title: 'Sign in',
                      color: AppTheme.primaryColor,
                      function: (){

                      }),

                  SizedBox(height: 5.h,),
                  Center(child: Text('Don\'t have an account?', style: AppTheme.subTextBold,)),
                  AppButton(
                      title: 'Create An Account',
                      color: AppTheme.darkerColor,
                      function: (){
                        Get.to(() => SignUpScreen(), transition: Transition.upToDown);
                      },
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

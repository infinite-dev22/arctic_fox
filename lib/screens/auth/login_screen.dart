import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:smart_rent/screens/auth/create_organisation_screen.dart';
import 'package:smart_rent/screens/auth/forgot_password_screen.dart';
import 'package:smart_rent/screens/auth/signup_screen.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/extra.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // userController.listenToChanges();
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

                    Image.asset('assets/auth/logo.png', width: 50.w,),

                    Text('Sign in', style: AppTheme.appTitleLarge,),

                    AuthTextField(
                      controller: usernameController,
                        hintText: 'Your Username',
                        obscureText: false,
                      onChanged: (value){
                        print('${usernameController.text.trim().toString()}');
                      },
                    ),

                    SizedBox(height: 1.h,),

                    AppPasswordTextField(
                      controller: passwordController,
                      hintText: 'password',
                      // fillColor: AppTheme.textBoxColor,
                      fillColor: AppTheme.appBgColor,
                    ),

                    SizedBox(height: 2.h,),

                    AppButton(
                        title: 'Sign in',
                        color: AppTheme.primaryColor,
                        function: () async {
                          
                          if(usernameController.text.length < 10) {
                            Fluttertoast.showToast(msg: 'short or no username');
                          } else if (passwordController.text.length < 6){
                            Fluttertoast.showToast(msg: 'short or no password');
                          } else {
                            // Fluttertoast.showToast(msg: 'SUCCESS', backgroundColor: Colors.green);
                            userController.checkUsernameType(usernameController.text.trim().toString(), passwordController.text.trim().toString());

                          }

                        }),
                    SizedBox(height: 1.h,),
                    Center(child: Bounceable(
                      onTap: (){
                        Get.to(() => ForgotPasswordScreen());
                      },
                      child: Text(
                        'Forgot Password!', style: AppTheme.subTextBold,),
                    )),

                    SizedBox(height: 5.h,),
                    Center(child: Text(
                      'Don\'t have an account?', style: AppTheme.subTextBold,)),
                    AppButton(
                      title: 'Create An Account',
                      color: AppTheme.darkerColor,
                      function: () async {
                        // Get.to(() => SignUpScreen(), transition: Transition.upToDown);
                        Get.to(() => CreateOrganisationScreen(), transition: Transition.upToDown);
                      },
                    ),

                    // Obx(() {
                    //   return userController.userList.isEmpty ? Center(child: Text('No Users'),)
                    //       : ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: userController.userList.length,
                    //       itemBuilder: (context, index) {
                    //         var user = userController.userList[index];
                    //         return Text(user.email);
                    //       });
                    // })

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

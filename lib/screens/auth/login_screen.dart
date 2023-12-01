import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:smart_rent/screens/auth/create_organisation_screen.dart';
import 'package:smart_rent/screens/auth/signup_screen.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/screens/home/homepage_screen.dart';
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

  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.listenToChanges();
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
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
                      fillColor: AppTheme.textBoxColor,
                    ),

                    SizedBox(height: 5.h,),

                    AppButton(
                        title: 'Sign in',
                        color: AppTheme.primaryColor,
                        function: () async {
                          if (_formKey.currentState!.validate()) {

                            // userController.insertUser(UserModel(
                            //     email: emailController.text.toString(),
                            //   password: passwordController.text.toString(),
                            // ));

                            // await AppConfig().supaBaseClient.from('users')
                            //     .insert(({
                            //   'email': emailController.text.toString(),
                            //   'password': passwordController.text.toString(),
                            // }))
                            //     .then((value) {});

                            Get.off(() => BottomNavBar());
                            Get.snackbar('SUCCESS', 'Logged in successfully',
                              titleText: Text(
                                'SUCCESS', style: AppTheme.greenTitle1,),
                            );

                          } else {

                          }
                        }),

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

                    Obx(() {
                      return userController.userList.isEmpty ? Center(child: Text('No Users'),)
                          : ListView.builder(
                          shrinkWrap: true,
                          itemCount: userController.userList.length,
                          itemBuilder: (context, index) {
                            var user = userController.userList[index];
                            return Text(user.email);
                          });
                    })

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

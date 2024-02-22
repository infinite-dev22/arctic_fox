import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/pages/home/home_screen.dart';
import 'package:smart_rent/pages/login/bloc/login_bloc.dart';
import 'package:smart_rent/screens/auth/create_organisation_screen.dart';
import 'package:smart_rent/screens/auth/forgot_password_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/app_password_textfield.dart';
import 'package:smart_rent/widgets/app_textfield.dart';

class LoginScreenLayout extends StatefulWidget {
  const LoginScreenLayout({super.key});

  @override
  State<LoginScreenLayout> createState() => _LoginScreenLayoutState();
}

class _LoginScreenLayoutState extends State<LoginScreenLayout> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(context.read<LoginBloc>().state.status);
        if (state.status == LoginStatus.success) {
          Fluttertoast.showToast(msg: 'Logged In Successfully', backgroundColor: Colors.green, gravity: ToastGravity.TOP);
          Get.off(() => HomeScreen());
        }
        if (state.status == LoginStatus.accessDenied) {
          Fluttertoast.showToast(
              msg: state.message.toString(),gravity: ToastGravity.TOP);
        }
      },
      child: Scaffold(
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
                      Image.asset(
                        'assets/auth/logo.png',
                        width: 50.w,
                      ),

                      Text(
                        'Sign in',
                        style: AppTheme.appTitleLarge,
                      ),

                      AuthTextField(
                        controller: usernameController,
                        hintText: 'Your Username',
                        obscureText: false,
                        onChanged: (value) {
                          print('${usernameController.text.trim().toString()}');
                        },
                      ),

                      SizedBox(
                        height: 1.h,
                      ),

                      AppPasswordTextField(
                        controller: passwordController,
                        hintText: 'password',
                        // fillColor: AppTheme.textBoxColor,
                        fillColor: AppTheme.appWidgetColor,
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          print(
                              "ISLOADING: ${context.read<LoginBloc>().state.isLoading}");
                          return AppButton(
                              isLoading:
                                  context.read<LoginBloc>().state.isLoading,
                              title: 'Sign in',
                              color: AppTheme.primaryColor,
                              function: () async {
                                if (usernameController.text.length < 10) {
                                  Fluttertoast.showToast(
                                      msg: 'short or no username',
                                      gravity: ToastGravity.TOP);
                                } else if (passwordController.text.length < 6) {
                                  Fluttertoast.showToast(
                                      msg: 'short or no password',
                                      gravity: ToastGravity.TOP);
                                } else {
                                  // Fluttertoast.showToast(msg: 'SUCCESS', backgroundColor: Colors.green);
                                  context.read<LoginBloc>().add(AuthUserEvent(
                                      usernameController.text.trim().toString(),
                                      passwordController.text
                                          .trim()
                                          .toString()));

                                  // userController.checkUsernameType(
                                  //     usernameController.text.trim().toString(),
                                  //     passwordController.text
                                  //         .trim()
                                  //         .toString());
                                }
                              });
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Center(
                          child: Bounceable(
                        onTap: () {
                          Get.to(() => ForgotPasswordScreen());
                          usernameController.clear();
                          passwordController.clear();
                        },
                        child: Text(
                          'Forgot Password!',
                          style: AppTheme.subTextBold,
                        ),
                      )),

                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                          child: Text(
                        'Don\'t have an account?',
                        style: AppTheme.subTextBold,
                      )),
                      AppButton(
                        title: 'Create An Account',
                        color: AppTheme.darkerColor,
                        function: () async {
                          // Get.to(() => SignUpScreen(), transition: Transition.upToDown);
                          Get.to(
                            () => CreateOrganisationScreen(),
                          );
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
      ),
    );
  }
}

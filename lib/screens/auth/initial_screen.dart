import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/config/app_strings.dart';
import 'package:smart_rent/pages/login/login_screen.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/widgets/app_button.dart';
import 'package:smart_rent/widgets/top_intro_stack.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopIntroStack(),
          SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to', style: AppTheme.italicTitle,),

                SizedBox(height: 1.h,),

                Image.asset('assets/auth/logo.png', width: 50.w,),
                SizedBox(height: 3.h,),
                Text(introText, style: AppTheme.subText,),
                SizedBox(height: 5.h,),
                
                AppButton(
                    title: 'Get Started',
                    color: AppTheme.primaryColor,
                    function: (){
                      // Get.to(() => LoginScreen(), transition: Transition.downToUp);
                      Get.to(() => LoginScreen(), transition: Transition.downToUp);
                    }),
                
              ],
            ),
          )

        ],
      ),
    );
  }
}

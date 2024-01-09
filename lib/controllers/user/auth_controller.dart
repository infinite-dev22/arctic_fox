import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/user/user_controller.dart';
import 'package:smart_rent/screens/auth/login_screen.dart';
import 'package:smart_rent/screens/auth/reset_password_screen.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {

  var isVerifyOtpLoading = false.obs;
  var isSendOtpLoading = false.obs;

  Future<void> checkUserEmailAvailability(String email) async{
    isSendOtpLoading(true);
    try{

     final response = await AppConfig().supaBaseClient.from('user_profiles').select().eq('email', email);
      final data = response as List<dynamic>;
     print('The AVAILABLE User IS == ${data}');
     print(response.length);
     print(data.length);
     print(data);
     print(response);
      if(data.isNotEmpty){
        sendResetOtp(email).then((value) {
          isSendOtpLoading(false);
        });

        // Fluttertoast.showToast(msg: 'Email $email exists', backgroundColor: Colors.green);
      } else {
        isSendOtpLoading(false);
        Fluttertoast.showToast(msg: 'User not found');
      }


    } catch(e){
      isSendOtpLoading(false);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> sendResetOtp(String email) async{
    try{

      await AppConfig().supaBaseClient.auth.resetPasswordForEmail(email).then((value) {
        Get.to(() => ResetPasswordScreen(email: email));
        Get.snackbar('RESET PASSWORD', 'Otp sent to $email');
      });

    } on AuthException catch(e){
      Fluttertoast.showToast(msg: e.message);
    }
  }

  Future<void> resetPassword(String email, String password) async {
    try{


      await AppConfig().supaBaseClient.auth.updateUser(
        UserAttributes(password: password),
      ).then((value) {
        Get.off(() => LoginScreen());
      });


    }  catch(error){
      print('Login Error is $error');
      Fluttertoast.showToast(msg: error.toString());
    }
  }


  Future<void> resetUserPassword(String email, String resetToken, String password) async {
    try{

      final recovery = await AppConfig().supaBaseClient.auth.verifyOTP(
        email: email,
        token: resetToken,
        type: OtpType.recovery,
      );
      print(recovery);
      await AppConfig().supaBaseClient.auth.updateUser(
        UserAttributes(password: password),
      );

      final Session? session = recovery.session;
      final User? user = recovery.user;


      print(session);
      print(session!.accessToken);
      print(user);

      if(user != null) {
        await userStorage.write('isLoggedIn', true).then((value) async{
          await userStorage.write('accessToken', session.accessToken).then((value) async{
            await userStorage.write('userId', user.id).then((value) async{
              Get.put(UserController()).getUserProfileData().then((value) {
                Get.off(() => BottomNavBar());
              });
            });
          });
        });


      } else {
        Fluttertoast.showToast(msg: 'Check your credentials');
      }


    }  catch(error){
      print('Login Error is $error');
      Fluttertoast.showToast(msg: error.toString());
    }
  }


  phonePasswordSignUp(String phone, String password)async{
    try {
      final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(phone: phone, password: password);

      print('PHONE AUTH RESPONSE == $response');
      print('PHONE AUTH USER == ${response.user}');
      print('PHONE AUTH SESSION == ${response.session}');

      print(response.user!.id);

    } catch (error) {
      print('Error inserting into AUTHE USERS: $error');
    }

  }

  Future<void> verifyPhoneOtp(String otp, String phone) async {
    isVerifyOtpLoading(true);

    try{

      final AuthResponse response = await AppConfig().supaBaseClient.auth.verifyOTP(
          token: otp, type: OtpType.sms, phone: phone);


      final Session? session = response.session;
      final User? user = response.user;


      print('PHONE VERIFIED RESPONSE == $response');
      print('PHONE VERIFIED USER == ${user}');
      print('PHONE VERIFIED SESSION == ${session}');

      if(user != null) {
        await userStorage.write('isLoggedIn', true).then((value) async{
          await userStorage.write('accessToken', session!.accessToken).then((value) async{
            await userStorage.write('userId', user.id).then((value) async{
              Get.put(UserController()).getUserProfileData().then((value) {
                Get.off(() => BottomNavBar());
              });
            });
          });
        });

        isVerifyOtpLoading(false);

      } else {
        isVerifyOtpLoading(false);
        Fluttertoast.showToast(msg: 'Check your credentials');
      }


    } on AuthException catch(error){
      isVerifyOtpLoading(false);
      Fluttertoast.showToast(msg: error.message.toString());
    }

  }


}
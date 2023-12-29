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



  Future<void> sendResetOtp(String email) async{
    try{

      await AppConfig().supaBaseClient.auth.resetPasswordForEmail(email).then((value) {
        Get.to(() => ResetPasswordScreen(email: email));
        Get.snackbar('RESET PASSWORD', 'Otp sent to $email');
      });

    } catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> resetPassword(String email, String password) async {
    try{

      // final recovery = await AppConfig().supaBaseClient.auth.verifyOTP(
      //   email: email,
      //   token: resetToken,
      //   type: OtpType.recovery,
      // );

      // final AuthResponse response = await AppConfig().supaBaseClient.auth.signInWithPassword(
      //   email: email,
      //   password: password,
      // );
      // final Session? session = recovery.session;
      // final User? user = recovery.user;


      // print(session);
      // print(session!.accessToken);
      // print(user);
      //
      // if(user != null) {
      //   await userStorage.write('isLoggedIn', true);
      //   await userStorage.write('accessToken', session.accessToken);
      //   await userStorage.write('userId', user.id);
      //   await UserController().getUserProfileData().then((value) {
      //     Get.to(() => BottomNavBar());
      //   });

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


}
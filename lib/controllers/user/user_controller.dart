import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/organisation/organisation_model.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:smart_rent/models/user/user_profile_model.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController extends GetxController {


  Rx<int> organisationId = Rx<int>(-1);
  Rx<int> userProfileId = Rx<int>(-1);

  var userProfileModel = UserProfileModel().obs;
  var userFirstname = ''.obs;

  RxList<UserModel> userList = <UserModel>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserProfileData();
  }

  // void fetchAllUsers() async {
  //   final response = await AppConfig().supaBaseClient.from('users').select();
  //   final data = response as List<dynamic>;
  //
  //   return userList.assignAll(
  //       data.map((json) => UserModel.fromJson(json)).toList());
  // }

  // void insertUser(UserModel userModel) async {
  //   final response = await AppConfig().supaBaseClient.from('users').insert(
  //       [userModel.toJson()]);
  //
  //   fetchAllUsers();
  // }

  Future<void> getUserProfileData() async {

    try{

      final response = await AppConfig().supaBaseClient.from('organisations').select().eq('user_id', userStorage.read('userId')).execute();
      print('MY SPECIFIC RESPONSE IS ${response.data[0]['name']}');
      userFirstname.value = response.data[0]['name'];

      // final response = await AppConfig().supaBaseClient.from('user_profiles').select().eq('user_id', userStorage.read('userId')).execute();
      // print('MY SPECIFIC RESPONSE IS ${response.data[0]['first_name']}');
      // userFirstname.value = response.data[0]['first_name'];


    }catch(error){
      print(error);
    }

  }

  Future<void> logoutUser() async {
    try{

      await AppConfig().supaBaseClient.auth.signOut().then((value) async{
        await userStorage.remove('accessToken');
        await userStorage.remove('userId');
        await userStorage.remove('accessToken');
        await userStorage.write('isLoggedIn', false);
        await userStorage.remove('isLoggedIn');
        Get.off(() => InitialScreen());
      });
    } catch(error) {

    }
  }

  Future<void> createUser(String email, String password, String businessName, String description,
      String firstName, String lastName
      ) async {
    try {
      // final response = await AppConfig().supaBaseClient.from('users').upsert([data]);
      final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email,);
      // if (response.user != null) {
      //   throw response.toString();
      // }
      // organisationId.value = response.data?.first['id'] ?? -1;
      print(response.user!.id);
      createOrganisation(businessName, description, response.user!.id.toString(), firstName, lastName);
    } catch (error) {
      print('Error inserting into Users: $error');
    }
  }

  Future<void> loginUser(String email, String password) async {
    try{

      final AuthResponse response = await AppConfig().supaBaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = response.session;
      final User? user = response.user;


      print(session);
      print(session!.accessToken);
      print(user);

      if(user != null) {
        await userStorage.write('isLoggedIn', true);
        await userStorage.write('accessToken', session.accessToken);
        await userStorage.write('userId', user.id);
        await getUserProfileData().then((value) {
          Get.to(() => BottomNavBar());
        });

      } else {
        Fluttertoast.showToast(msg: 'Check your credentials');
      }


    } catch(error){
      print('Login Error is $error');
    }
  }


  Future<void> createOrganisation( String businessName, String description, String userId,
      String firstName, String lastName
      ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('organisations').insert([
        {
          "name" : businessName,
          "description" : description,
          "user_id" : userId,
        }
      ]);
      // final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email,);
      // if (response.error != null) {
      //   throw response.error;
      // }
      //
      organisationId.value = response.data?.first['id'] ?? -1;
      print(organisationId.value.toString());

      createUserProfile(businessName, description, userId, firstName, lastName);
    } catch (error) {
      print('Error inserting into Organisations: $error');
      throw error;
    }

  }

  Future<void> createUserProfile( String businessName, String description, String userId,
      String firstName, String lastName
      ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('user_profiles').insert([
        {
          "user_id" : userId,
          "organisation_id" : 1,
          "first_name" : firstName,
          "last_name" : lastName,
          "role_id" : 1,
        }
      ]);
      // final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email,);
      // if (response.error != null) {
      //   throw response.error;
      // }

      userProfileId.value = response.data?.first['id'] ?? -1;
      print(userProfileId.value.toString());

      Get.off(() => InitialScreen());

    } catch (error) {
      print('Error inserting into user Profile: $error');
    }
  }

   signUpUser(String email, String password, String firstName, String lastName, String businessName, String description,  ) async {
    
    UserModel userModel = UserModel(email: email, password: password);

    
    final AuthResponse res = await AppConfig().supaBaseClient.auth.signUp(password: userModel.email, email: userModel.email,).then((user) async{

      await AppConfig().supaBaseClient.from('organisations').insert(
        {
          "name" : businessName,
          "description" : description,
          "user_id" : user.user!.id,
        }
      ).then((org) async{

       await AppConfig().supaBaseClient.from('user_profiles').insert(
          {
            "user_id" : user.user!.id,
            "organisation_id" : 1,
            "first_name" : firstName,
            "last_name" : lastName,
            "role_id" : 1,
          }
        );

        return org;
      });

     return user;

    });

    try{
      if(res.user != null){
        Get.snackbar('Account created successfully', 'you may login as');
      } else {
        Fluttertoast.showToast(msg: 'Error Signing Up');
      }
    } catch (e) {

    }

  }

  // void listenToChanges() {
  //   // Set up real-time listener
  //   AppConfig().supaBaseClient
  //       .from('users')
  //       .stream(primaryKey: ['id'])
  //       .listen((List<Map<String, dynamic>> data) {
  //     fetchAllUsers();
  //   });
  //
  // }

}
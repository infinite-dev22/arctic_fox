import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/organisation/organisation_model.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController extends GetxController {


  Rx<int> organisationId = Rx<int>(-1);
  Rx<int> userProfileId = Rx<int>(-1);

  RxList<UserModel> userList = <UserModel>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllUsers();
  }

  void fetchAllUsers() async {
    final response = await AppConfig().supaBaseClient.from('users').select();
    final data = response as List<dynamic>;

    return userList.assignAll(
        data.map((json) => UserModel.fromJson(json)).toList());
  }

  void insertUser(UserModel userModel) async {
    final response = await AppConfig().supaBaseClient.from('users').insert(
        [userModel.toJson()]);

    fetchAllUsers();
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


  Future<void> createOrganisation( String businessName, String description, String userId,
      String firstName, String lastName
      ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('organisations').upsert([
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
    }

  }

  Future<void> createUserProfile( String businessName, String description, String userId,
      String firstName, String lastName
      ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('user_profiles').upsert([
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

  void listenToChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('users')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllUsers();
    });

  }

}
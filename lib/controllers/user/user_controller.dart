import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/employee/employee_property_model.dart';
import 'package:smart_rent/models/organisation/organisation_model.dart';
import 'package:smart_rent/models/role/user_role_model.dart';
import 'package:smart_rent/models/user/user_model.dart';
import 'package:smart_rent/models/user/user_profile_model.dart';
import 'package:smart_rent/screens/auth/initial_screen.dart';
import 'package:smart_rent/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController extends GetxController {


  Rx<int> organisationId = Rx<int>(-1);
  Rx<int> userProfileId = Rx<int>(-1);

  var userProfileModel = UserProfileModel().obs;
  var userFirstname = ''.obs;
  var organisationName = ''.obs;
  var addedUserRoleId = 0.obs;
  var isUserListLoading = false.obs;
  var isEmployeePropertyLoading = false.obs;

  var isPhoneSelected = false.obs;
  var isEmailSelected = false.obs;

  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<UserRoleModel> userRoleList = <UserRoleModel>[].obs;
  RxList<UserProfileModel> userProfileModelList = <UserProfileModel>[].obs;
  RxList<EmployeePropertyModel> employeePropertyModelList = <EmployeePropertyModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserProfileData();
    fetchAllUserRoles();
    // listenToPropertyTenantListChanges();
    // listenToAllUsersInSpecificOrganizationChanges();
  }

  setPhoneAsUsername(){
    isPhoneSelected.toggle();
    print('My Username is ${isPhoneSelected.value}');
  }

  setAddedUserRoleId(int id){
    addedUserRoleId.value = id;
    print('New Added User Role ID is $id');
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

  fetchAllUserRoles() async {
isUserListLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('roles').select();
      final data = response as List<dynamic>;
      print('my Roles are $response');
      print(response.length);
      print(data.length);
      print(data);
      isUserListLoading(false);
      return userRoleList.assignAll(
          data.map((json) => UserRoleModel.fromJson(json)).toList());

    } catch (error) {
      isUserListLoading(false);
      print('Error fetching User Roles: $error');
    }

  }

  fetchAllUsersInSpecificOrganization() async {

    try {

      final response = await AppConfig().supaBaseClient.from('user_profiles').select()
          .eq('organisation_id', userStorage.read('OrganizationId')).order('created_at');
      final data = response as List<dynamic>;
      print('my Profile Users are $response');
      print(response.length);
      print(data.length);
      print(data);

      return userProfileModelList.assignAll(
          data.map((json) => UserProfileModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching User Roles: $error');
    }

  }

  Future<void> getUserOrganizationData() async {

    try{

      final response = await AppConfig().supaBaseClient.from('organisations').select().eq('id', userStorage.read('OrganizationId')).execute();
      print('MY SPECIFIC RESPONSE IS ${response.data[0]['name']}');
      print('MY SPECIFIC ORGANIZATION ID IS ${response.data[0]['id']}');
      organisationName.value = response.data[0]['name'];
     // await userStorage.write('OrganizationId', response.data[0]['id']);
      await userStorage.write('organisationName', response.data[0]['name']);

      // final response = await AppConfig().supaBaseClient.from('user_profiles').select().eq('user_id', userStorage.read('userId')).execute();
      // print('MY SPECIFIC RESPONSE IS ${response.data[0]['first_name']}');
      // userFirstname.value = response.data[0]['first_name'];


    }catch(error){
      print(error);
    }

  }

  Future<void> getUserProfileData() async {

    try{

      await AppConfig().supaBaseClient.from('user_profiles').select().eq('user_id', userStorage.read('userId')).execute().then((userValue) async{
        print('MY SPECIFIC Profile User RESPONSE IS ${userValue.data[0]['first_name']}');
        print('MY SPECIFIC Profile User  ID IS ${userValue.data[0]['user_id']}');
        userFirstname.value = userValue.data[0]['first_name'];
        await userStorage.write('userFirstname', userValue.data[0]['first_name']).then((value) async{
          await userStorage.write('userProfileId', userValue.data[0]['id']).then((value) async{
            await userStorage.write('OrganizationId', userValue.data[0]['organisation_id']).then((value) async{
              await userStorage.write('roleId', userValue.data[0]['role_id']).then((value) async{
                await getUserOrganizationData();
              });
            });
          });
        });
      });
      // print('MY SPECIFIC Profile User RESPONSE IS ${response.data[0]['first_name']}');
      // print('MY SPECIFIC Profile User  ID IS ${response.data[0]['user_id']}');
      // userFirstname.value = response.data[0]['first_name'];
      // userStorage.write('OrganizationId', response.data[0]['id']);
      // await userStorage.write('userFirstname', response.data[0]['first_name']);
      // await userStorage.write('userProfileId', response.data[0]['id']);

      // final response = await AppConfig().supaBaseClient.from('user_profiles').select().eq('user_id', userStorage.read('userId')).execute();
      // print('MY SPECIFIC Profile User RESPONSE IS ${response.data[0]['first_name']}');
      // print('MY SPECIFIC Profile User  ID IS ${response.data[0]['user_id']}');
      // userFirstname.value = response.data[0]['first_name'];
      // // userStorage.write('OrganizationId', response.data[0]['id']);
      // await userStorage.write('userFirstname', response.data[0]['first_name']);
      // await userStorage.write('userProfileId', response.data[0]['id']);

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
        // await userStorage.remove('isLoggedIn');
        await userStorage.remove('userFirstname');
        await userStorage.remove('OrganizationId');
        await userStorage.remove('organisationName');
        await userStorage.remove('userProfileId');
        await DefaultCacheManager().emptyCache();
        print('LOGOUT ORG ID == ${userStorage.read('OrganizationId')}');
        await Get.deleteAll();
        Get.off(() => InitialScreen());
      });
    } catch(error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> createUserWithEmail(String email, String password, String businessName, String description,
      String firstName, String lastName, String phone
      ) async {
    try {
      final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email, phone: phone);

      print(response.user!.id);
      createOrganisation(businessName, description, response.user!.id.toString(), firstName, lastName);


    } catch (error) {
      print('Error inserting into Users: $error');
    }
  }

  Future<void> createUserWithPhone(String phone, String password, String email, String businessName, String description,
      String firstName, String lastName)async{
    try {
      final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(phone: phone, password: password);

      print(response.user!.id);
      createOrganisation(businessName, description, response.user!.id.toString(), firstName, lastName);


    } catch (error) {
      print('Error inserting into Users: $error');
    }

  }




  Future<void> resetPassword(String email, String resetToken, String password) async {
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

  Future<void> loginUser(String email, String password) async {
    try{

      // final AuthResponse response = await AppConfig().supaBaseClient.auth.signInWithPassword(
      //   email: email,
      //   password: password,
      // );

      final AuthResponse response = await AppConfig().supaBaseClient.auth.signInWithPassword(
        phone: email,
        password: password,
      );

      final Session? session = response.session;
      final User? user = response.user;


      print(session);
      print(session!.accessToken);
      print(user);

      if(user != null) {

        await userStorage.write('isLoggedIn', true).then((value) async{
          await userStorage.write('accessToken', session.accessToken).then((value) async{
            await userStorage.write('userId', user.id).then((value) async{
               Get.put(UserController()).getUserProfileData().then((value) {
                 print('LOGIN ORG ID IS ${userStorage.read('OrganizationId')}');
                   Get.off(() => BottomNavBar());
               });
            });
          });
        });


        // await userStorage.write('isLoggedIn', true);
        // await userStorage.write('accessToken', session.accessToken);
        // await userStorage.write('userId', user.id);
        // await getUserOrganizationData().then((value) {
        //   Get.off(() => BottomNavBar());
        // });

      } else {
        Fluttertoast.showToast(msg: 'Check your credentials');
      }


    }  catch(error){
      print('Login Error is $error');
      Fluttertoast.showToast(msg: error.toString());
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
      ]).select();


      final newOrganization = response as List<dynamic>;
      final insertedOrgId = newOrganization[0]['id'];


      print('INSERTED Response is == $response');
      print('INSERTED ORGANIZATION ID == ${response}');
      // organisationId.value = response.data?.first['id'] ?? -1;
      // print(organisationId.value.toString());

       createUserProfile(businessName, description, userId, firstName, lastName, insertedOrgId).then((value) {
        Get.offAll(() => InitialScreen());
      });
    } catch (error) {
      print('Error inserting into Organisations: $error');
      throw error;
    }

  }

  Future<void> createUserProfile( String businessName, String description, String userId,
      String firstName, String lastName, int organizationId
      ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('user_profiles').insert([
        {
          "user_id" : userId,
          // "organisation_id" : 1,
          "organisation_id" : organizationId,
          "first_name" : firstName,
          "last_name" : lastName,
          "role_id" : 1,
        }
      ]);
      // final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email,);
      // if (response.error != null) {
      //   throw response.error;
      // }
      //
      // userProfileId.value = response.data?.first['id'] ?? -1;
      // print(userProfileId.value.toString());

      // Get.off(() => InitialScreen());

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

  Future<void> adminCreateUser(String email, String password,
      String firstName, String lastName, int role
      ) async {
    try {
      // final response = await AppConfig().supaBaseClient.from('users').upsert([data]);
      final AuthResponse response = await AppConfig().supaBaseClient.auth.signUp(password: password, email: email,);
      // if (response.user != null) {
      //   throw response.toString();
      // }
      // organisationId.value = response.data?.first['id'] ?? -1;
      print(response.user!.id);
      adminCreateUserProfile(response.user!.id.toString(), firstName, lastName, role);
    } catch (error) {
      print('Error inserting into Users: $error');
    }
  }

  Future<void> adminCreateUserProfile(String userId,
      String firstName, String lastName, int role
      ) async {
    try {

      await AppConfig().supaBaseClient.from('user_profiles').insert([
        {
          "user_id" : userId,
          "organisation_id" : userStorage.read('OrganizationId'),
          "first_name" : firstName,
          "last_name" : lastName,
          "role_id" : role,
        }
      ]);

      // userProfileId.value = response.data?.first['id'] ?? -1;
      // print(userProfileId.value.toString());

      // Get.back();

    } catch (error) {
      print('Error inserting into user Profile: $error');
    }
  }

  void listenToAllUsersInSpecificOrganizationChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('user_profiles')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllUsersInSpecificOrganization();

    });

  }

  fetchAllEmployeePropertiesInOrganization() async {
    isEmployeePropertyLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('employee_properties').select().eq('user_id', userStorage.read('OrganizationId'))
          .eq('organization_id', userStorage.read('OrganizationId'));
      final data = response as List<dynamic>;
      print('my Employee Properties are $response');
      print(response.length);
      print(data.length);
      print(data);
      isEmployeePropertyLoading(false);
      return employeePropertyModelList.assignAll(
          data.map((json) => EmployeePropertyModel.fromJson(json)).toList());


    } catch (error) {
      print('Error fetching Employee Properties: $error');
      isEmployeePropertyLoading(false);
    }

  }

  void listenToEmployeePropertiesInOrganizationChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('employee_properties')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllEmployeePropertiesInOrganization();

    });

  }

  // Future<void> addPropertyToEmployee(int propertyId, int roleId) async {
  //   try {
  //
  //     final response = await AppConfig().supaBaseClient.from('employee_properties').insert([
  //       {
  //         "user_id" : userStorage.read('userId'),
  //         "property_id" : propertyId,
  //         "role_id" : roleId,
  //         "organization_id" : userStorage.read('OrganizationId'),
  //         "created_by" : userStorage.read('userProfileId'),
  //         "updated_by" : userStorage.read('userProfileId'),
  //       }
  //     ]);
  //
  //     print(response);
  //     final propertyList = response as List<dynamic>;
  //     print('MY Employee Property = $propertyList');
  //
  //   } catch (error) {
  //     print('Error inserting into Employee property: $error');
  //   }
  // }

  addPropertyToEmployee(int propertyId, int roleId) async {

    try {
      final response = await AppConfig().supaBaseClient.from('employee_properties').insert([
        {
          "user_id" : userStorage.read('userId'),
          "property_id" : propertyId,
          "role_id" : roleId,
          "organization_id" : userStorage.read('OrganizationId'),
          "created_by" : userStorage.read('userProfileId'),
          "updated_by" : userStorage.read('userProfileId'),
        }
      ]).then((property) {
        Get.back();
        Get.snackbar('SUCCESS', 'Property added to employee',
          titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        throw response.error;
      }

    } catch (error) {
      print('Error adding property: $error');
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
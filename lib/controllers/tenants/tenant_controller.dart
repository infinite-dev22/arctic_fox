import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/nationality/nationality_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/tenant/tenant_profile_model.dart';
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:uuid/uuid.dart';

class TenantController extends GetxController {

  RxList<NationalityModel> nationalityList = <NationalityModel>[].obs;
  RxList<SalutationModel> salutationList = <SalutationModel>[].obs;
  RxList<TenantTypeModel> tenantTypeList = <TenantTypeModel>[].obs;
  RxList<UnitModel> unitList = <UnitModel>[].obs;
  RxList<TenantModel> tenantList = <TenantModel>[].obs;
  RxList<BusinessTypeModel> businessList = <BusinessTypeModel>[].obs;

  RxList<PaymentScheduleModel> paymentList = <PaymentScheduleModel>[].obs;


  var companyProfileWithContact = TenantProfileContactModel().obs;

  var isAddContactPerson = false.obs;
  var isAddNextOfKin = false.obs;

  var nationalityId = 0.obs;
  var tenantTypeId = 0.obs;
  var unitId = 0.obs;
  var tenantId = 0.obs;
  var businessTypeId = 0.obs;
  var newGender = ''.obs;
  var isTenantListLoading = false.obs;
  var isSpecificTenantLoading = false.obs;
  var isContactDetailsLoading = false.obs;
  var isIndividualTenantDetailsLoading = false.obs;


  var uCompanyNin = ''.obs;
  var uCompanyFirstName = ''.obs;
  var uCompanySurname = ''.obs;
  var uCompanyDesignation = ''.obs;
  var uCompanyContact = ''.obs;
  var uCompanyEmail = ''.obs;

  var uIndividualNin = ''.obs;
  var uIndividualFirstName = ''.obs;
  var uIndividualSurname = ''.obs;
  var uIndividualName = ''.obs;
  var uIndividualDateOfBirth = ''.obs;
  var uIndividualContact = ''.obs;
  var uIndividualEmail = ''.obs;
  var uIndividualDescription = ''.obs;

  var uCompanyBusinessType = ''.obs;
  var uCompanyCountryType = ''.obs;
  var uCompanyTenantDescription = ''.obs;
  var uCompanyBusinessTypeId = 0.obs;

  var uIndividualBusinessType = ''.obs;
  var uIndividualCountryType = ''.obs;
  var uIndividualGender = ''.obs;
  var uIndividualTenantDescription = ''.obs;
  var uIndividualBusinessTypeId = 0.obs;

  var iBusinessType = ''.obs;
  var iCountryType = ''.obs;
  var iDescription = ''.obs;
  var iBusinessTypeId = 0.obs;
  var paymentScheduleId = 0.obs;


  var uuid = Uuid();

  var genderList = [
    'Male',
    'Female',
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllTenantTypes();
    fetchAllNationalities();
    fetchAllSalutations();
    // fetchAllTenants();
    listenToTenantChanges();
    fetchAllUnits();
    fetchAllBusinessTypes();
    fetchAllPayments();

  }

  setNewGender(String gender){
    newGender.value = gender;
    print(gender);
  }

  addContactPerson(bool value){
    isAddContactPerson.toggle();
    print(value);
  }

  setNationalityId(int id){
    nationalityId.value = id;
    print('New Nationality Id is $id');
  }

  setTenantTypeId(int id){
    tenantTypeId.value = id;
    print('New Tenant Type Id is $id');
  }

  setUnitId(int id){
    unitId.value = id;
    print('New Unit Id is $id');
  }

  setTenantId(int id){
    tenantId.value = id;
    print('New Tenant Id is $id');
  }

  setBusinessTypeId(int id){
    businessTypeId.value = id;
    print('New Business Type Id is $id');
  }

  setPaymentScheduleId(int id){
    paymentScheduleId.value = id;
    print('New Payment Schedule Id is $id');
  }


  fetchAllPayments() async {

    try {

      final response = await AppConfig().supaBaseClient.from('payment_schedules').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return paymentList.assignAll(
          data.map((json) => PaymentScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching payments: $error');
    }

  }


  void fetchAllNationalities() async {

    try {

      final response = await AppConfig().supaBaseClient.from('currency_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return nationalityList.assignAll(
          data.map((json) => NationalityModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching nationalities: $error');
    }


  }

  void fetchAllSalutations() async {

    try {

      final response = await AppConfig().supaBaseClient.from('salutations').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return salutationList.assignAll(
          data.map((json) => SalutationModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching salutations: $error');
    }


  }

  void fetchAllTenantTypes() async {

    try {

      final response = await AppConfig().supaBaseClient.from('tenant_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return tenantTypeList.assignAll(
          data.map((json) => TenantTypeModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching tenant types: $error');
    }


  }


  void fetchAllTenants() async {
    isTenantListLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('tenants').select().order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);
      isTenantListLoading(false);

      return tenantList.assignAll(
          data.map((json) => TenantModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
      isTenantListLoading(false);
    }


  }

  void fetchAllBusinessTypes() async {

    try {

      final response = await AppConfig().supaBaseClient.from('business_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return businessList.assignAll(
          data.map((json) => BusinessTypeModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Business Types: $error');
    }


  }

  void fetchAllUnits() async {

    try {

      final response = await AppConfig().supaBaseClient.from('units').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return unitList.assignAll(
          data.map((json) => UnitModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Units: $error');
    }


  }


  addIndividualTenant(String name, int organisationId, int tenantTypeId, String createdBy,
      int nationId,
      ) async {

    String uniqueId = uuid.v4();

    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').insert(
          {
            "name" : name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
          }
      ).then((indTenant) {
        Get.back();
        Get.snackbar('SUCCESS', 'Tenant added to your list',
          titleText: Text(
            'SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        throw response.error;
      }

    } catch (error) {
      print('Error adding tenant: $error');
    }


  }

  // addCompanyTenant(String name, int organisationId, int tenantTypeId, int businessTypeId, String createdBy,
  //     int nationId, String? contactFirstName, String? contactLastName,
  //     String? contactNin, String? contactDesignation, String? contactPhone, String? contactEmail,
  //     ) async {
  //
  //   String uniqueId = uuid.v4();
  //
  //
  //   try {
  //     final response =  await AppConfig().supaBaseClient.from('tenants').insert(
  //         {
  //           "tenant_no" : uniqueId,
  //           "business_type_id" : businessTypeId,
  //           "name" : name,
  //           "nation_id": nationId,
  //           "organisation_id": organisationId,
  //           "tenant_type_id": tenantTypeId,
  //           "created_by" : createdBy,
  //         }
  //     );
  //
  //     // await AppConfig().supaBaseClient.from('tenants').select('id').like('tenant_no', uniqueId.toString()).execute().then((response) {
  //     //   if (response.data == null) {
  //     //     print('Error: ${response.toString()}');
  //     //   } else {
  //     //     // Assuming there is only one row matching the condition
  //     //     final tableId = response.data[0]['id'];
  //     //
  //     //     print('Table ID: $tableId');
  //     //   }
  //     // });
  //
  //
  //     final data = await AppConfig().supaBaseClient.from('tenants')
  //         .select('id')
  //         .like('tenant_no', uniqueId.toString()).execute();
  //
  //     print(data);
  //     print(data.data[0]['id']);
  //
  //     if(isAddContactPerson.isFalse) {
  //       Get.back();
  //       Get.snackbar('SUCCESS', 'Tenant added to your list',
  //         titleText: Text(
  //           'SUCCESS', style: AppTheme.greenTitle1,),
  //       );
  //     } else {
  //
  //       await AppConfig().supaBaseClient.from('tenant_profile_contacts').insert(
  //           {
  //             "tenant_id" : data.data[0]['id'],
  //             "first_name" : contactFirstName,
  //             "last_name" : contactLastName,
  //             "nin" : contactNin,
  //             "contact" : contactPhone,
  //             "email" : contactEmail,
  //             "designation": contactDesignation,
  //             "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
  //           }
  //       );
  //
  //     }
  //
  //   } catch (error) {
  //     print('Error adding tenant: $error');
  //   }
  //
  //
  //   // try {
  //   //   final response =  await AppConfig().supaBaseClient.from('tenants').insert(
  //   //       {
  //   //         "tenant_no" : uniqueId,
  //   //         "business_type_id" : businessTypeId,
  //   //         "name" : name,
  //   //         "nation_id": nationId,
  //   //         "organisation_id": organisationId,
  //   //         "tenant_type_id": tenantTypeId,
  //   //         "created_by" : createdBy,
  //   //       }
  //   //   ).then((compTenant) async{
  //   //     print("My Value Is " + compTenant);
  //   //
  //   //     if(isAddContactPerson.isFalse) {
  //   //       Get.back();
  //   //       Get.snackbar('SUCCESS', 'Tenant added to your list',
  //   //         titleText: Text(
  //   //           'SUCCESS', style: AppTheme.greenTitle1,),
  //   //       );
  //   //     } else {
  //   //
  //   //       await AppConfig().supaBaseClient.from('tenant_profile_contacts').insert(
  //   //           {
  //   //             "tenant_id" : compTenant['id'],
  //   //             "first_name" : contactFirstName,
  //   //             "last_name" : contactLastName,
  //   //             "nin" : contactNin,
  //   //             "contact" : contactPhone,
  //   //             "email" : contactEmail,
  //   //             "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
  //   //           }
  //   //       );
  //   //
  //   //     }
  //   //
  //   //   });
  //   //
  //   //   if (response.error != null) {
  //   //     throw response.error;
  //   //   }
  //   //
  //   // } catch (error) {
  //   //   print('Error adding tenant: $error');
  //   // }
  //
  //
  // }

  deleteTenant(int id) async{

    await AppConfig().supaBaseClient
        .from('tenants')
        .delete()
        .match({ 'id': id });
    fetchAllTenants();
  }

  Future<void> addPersonalTenant(String name, int organisationId, int tenantTypeId, int businessTypeId, String createdBy,
      int nationId,
      String nin,  String phone, String email, String? description, String dob, String gender,
      ) async {

    String uniqueId = uuid.v4();


    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').insert(
          {
            "tenant_no" : uniqueId,
            "business_type_id" : businessTypeId,
            "name" : name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
            "description" : description,
          }
      );

      // await AppConfig().supaBaseClient.from('tenants').select('id').like('tenant_no', uniqueId.toString()).execute().then((response) {
      //   if (response.data == null) {
      //     print('Error: ${response.toString()}');
      //   } else {
      //     // Assuming there is only one row matching the condition
      //     final tableId = response.data[0]['id'];
      //
      //     print('Table ID: $tableId');
      //   }
      // });


      final data = await AppConfig().supaBaseClient.from('tenants')
          .select('id')
          .like('tenant_no', uniqueId.toString()).execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig().supaBaseClient.from('tenant_profiles').insert(
          {
            "tenant_id" : data.data[0]['id'],
            // "first_name" : firstName,
            // "last_name" : lastName,
            "nin" : nin,
            "contact" : phone,
            "email" : email,
            "description": description,
            "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
            "gender" : gender,
            "date_of_birth" : dob,

          }
      );
      // fetchAllTenants();
      Get.back();
      Get.snackbar('Success', 'Added Company With Contact');

      //     .then((value) {
      //   // fetchAllTenants();
      //   Get.back();
      //   Get.snackbar('Success', 'Added Company With Contact');
      // });


    } catch (error) {
      print('Error adding tenant: $error');
    }



  }


  Future<void> addCompanyTenantWithContact(String name, int organisationId, int tenantTypeId, int businessTypeId, String createdBy,
      int nationId, String? contactFirstName, String? contactLastName,
      String? contactNin, String? contactDesignation, String? contactPhone, String? contactEmail, String? description,
      ) async {

    String uniqueId = uuid.v4();


    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').insert(
          {
            "tenant_no" : uniqueId,
            "business_type_id" : businessTypeId,
            "name" : name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
            "description" : description,
          }
      );

      // await AppConfig().supaBaseClient.from('tenants').select('id').like('tenant_no', uniqueId.toString()).execute().then((response) {
      //   if (response.data == null) {
      //     print('Error: ${response.toString()}');
      //   } else {
      //     // Assuming there is only one row matching the condition
      //     final tableId = response.data[0]['id'];
      //
      //     print('Table ID: $tableId');
      //   }
      // });


      final data = await AppConfig().supaBaseClient.from('tenants')
          .select('id')
          .like('tenant_no', uniqueId.toString()).execute();

      print(data);
      print(data.data[0]['id']);

      if(isAddContactPerson.isFalse) {
        // fetchAllTenants();
        Get.back();
        Get.snackbar('SUCCESS', 'Tenant added to your list',
          titleText: Text(
            'SUCCESS', style: AppTheme.greenTitle1,),
        );
      } else {

        await AppConfig().supaBaseClient.from('tenant_profile_contacts').insert(
            {
              "tenant_id" : data.data[0]['id'],
              "first_name" : contactFirstName,
              "last_name" : contactLastName,
              "nin" : contactNin,
              "contact" : contactPhone,
              "email" : contactEmail,
              "designation": contactDesignation,
              "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
            }
        );
        // fetchAllTenants();
        Get.back();
        // Get.snackbar('Success', 'Added Company With Contact');

        //     .then((value) {
        //   Get.back();
        //   Get.snackbar('Success', 'Added Company With Contact');
        // });

      }

    } catch (error) {
      print('Error adding tenant: $error');
    }

  }


  Future<void> addCompanyTenantWithoutContact(String name, int organisationId, int tenantTypeId, int businessTypeId, String createdBy,
      int nationId, String? description,
      ) async {

    String uniqueId = uuid.v4();


    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').insert(
          {
            "tenant_no" : uniqueId,
            "business_type_id" : businessTypeId,
            "name" : name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
            "description" : description,
          }
      );
      // fetchAllTenants();
      Get.back();
      Get.snackbar('Success', 'Added Company Without Contact');



      //     .then((value) {
      //   Get.back();
      //   Get.snackbar('Success', 'Added Company Without Contact');
      // });




    } catch (error) {
      print('Error adding tenant: $error');
    }


  }

  void listenToTenantChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('tenants')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllTenants();
    });

  }

  addTenantToUnit( int tenantId, String createdBy,
      int unitId, DateTime date1, DateTime date2, int amount, int discount
      ) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('tenant_units').insert(
          {
            "amount" : amount,
            "discount" : discount,
            "unit_d": unitId,
            // "organisation_id": organisationId,
            "tenant_id": tenantId,
            "created_by" : createdBy,
            "from_date" : date1,
            "to_date" : date2,
          }
      ).then((tenant) {
        Get.back();
        Get.snackbar('SUCCESS', 'Tenant added to unit',
          titleText: Text(
            'SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        throw response.error;
      }

    } catch (error) {
      print('Error adding tenant: $error');
    }


  }

  Future<void> updatePersonalTenantDetails(int individualTenantId, String? businessTypeId,
      String? name, String? nationId, String? description, String tenantNo,
      String? nin, String? phone, String? email, String? gender, String? dob
      ) async {


    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').update(
          {
            "business_type_id" : businessTypeId,
            "name" : name,
            "nation_id": nationId,
            "description" : description,
          }
      ).eq('id', individualTenantId).execute();



      final data = await AppConfig().supaBaseClient.from('tenants')
          .select('id')
          .like('id', individualTenantId.toString()).execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig().supaBaseClient.from('tenant_profiles').update(
          {
            "nin" : nin,
            "contact" : phone,
            "email" : email,
            "description": description,
            "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
            "gender" : gender,
            "date_of_birth" : dob,

          }
      ).eq('tenant_id', individualTenantId.toString()).execute();
      // fetchAllTenants();
      Get.back();
      Get.snackbar('Success', 'Updated Individual Tenant');


    } catch (error) {
      print('Error updating Individual tenant: $error');
    }



  }



  Future<void> updateCompanyTenantDetailsWithContact(
      String name, int organisationId, int businessTypeId, String createdBy,
      int nationId, String? contactFirstName, String? contactLastName,
      String? contactNin, String? contactDesignation, String? contactPhone,
      String? contactEmail, String? description,) async {
    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').update(
          {
            "business_type_id" : businessTypeId,
            "name" : name,
            "nation_id": nationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
            "description" : description,
          }
      ).execute();

      // await AppConfig().supaBaseClient.from('tenants').select('id').like('tenant_no', uniqueId.toString()).execute().then((response) {
      //   if (response.data == null) {
      //     print('Error: ${response.toString()}');
      //   } else {
      //     // Assuming there is only one row matching the condition
      //     final tableId = response.data[0]['id'];
      //
      //     print('Table ID: $tableId');
      //   }
      // });


      final data = await AppConfig().supaBaseClient.from('tenants')
          .select('id')
          .like('tenant_no', createdBy .toString()).execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig().supaBaseClient.from('tenant_profile_contacts').update(
          {
            "first_name" : contactFirstName,
            "last_name" : contactLastName,
            "nin" : contactNin,
            "contact" : contactPhone,
            "email" : contactEmail,
            "designation": contactDesignation,
            "created_by" : "f88d4f61-6ea8-4d54-aca3-54dfc58bd8f5",
          }
      );
      // fetchAllTenants();
      Fluttertoast.showToast(msg: 'Update Succuessful');
      Get.back();

    } catch (error) {
      print('Error adding tenant: $error');
    }


  }


  Future<void> updateCompanyTenantDetailsWithoutContact() async {



  }


  getCompanyTenantContactProfile(int id) async {
    isContactDetailsLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenant_profile_contacts').select().eq('tenant_id', id).execute();
      isContactDetailsLoading(false);
      // Print the retrieved data
      print('CONTAC TABLE RESPONSE == ${response.data}');
      uCompanyFirstName.value = response.data[0]['first_name'];
      uCompanySurname.value = response.data[0]['last_name'];
      uCompanyDesignation.value = response.data[0]['designation'];
      uCompanyContact.value = response.data[0]['contact'];
      uCompanyEmail.value = response.data[0]['email'];
      uCompanyNin.value = response.data[0]['nin'];
      
      print('MY Contact RESPONSE == ${response.data}');
      // print(response.data[0]['nin']);
      // print('MY CONTACT IS ${response.data[0]['contact']}');


    } catch (e) {
      isContactDetailsLoading(false);
      print('Error: $e');
    }

  }

  getIndividualTenantProfile(int id) async {
    isIndividualTenantDetailsLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenant_profiles').select().eq('tenant_id', id).execute();
      isIndividualTenantDetailsLoading(false);
      // Print the retrieved data
      print('CONTAC TABLE RESPONSE == ${response.data}');

      // uIndividualName.value = response.data[0]['name'];
      uIndividualDescription.value = response.data[0]['description'];
      uIndividualContact.value = response.data[0]['contact'];
      uIndividualEmail.value = response.data[0]['email'];
      uIndividualNin.value = response.data[0]['nin'];
      uIndividualDateOfBirth.value = response.data[0]['date_of_birth'];
      uIndividualGender.value = response.data[0]['gender'];

      // print('MY Contact RESPONSE == ${response.data}');
      print(uIndividualContact);
      // print('MY CONTACT IS ${response.data[0]['contact']}');


    } catch (e) {
      isIndividualTenantDetailsLoading(false);
      print('Error: $e');
    }

  }

  getCompanyTenantBusinessDetails(int id) async {
    // isSpecificTenantLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenants').select().eq('id', id).execute();

      final businessTypeResponse = await AppConfig().supaBaseClient.from('business_types').select().eq('id', response.data[0]['business_type_id']).execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print('Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
      print('Tenants TABLE row id == ${businessTypeResponse.data[0]['id']}');

      uCompanyBusinessType.value = businessTypeResponse.data[0]['name'];
      uCompanyBusinessTypeId.value = businessTypeResponse.data[0]['id'];

    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }

  }

  getIndividualTenantBusinessDetails(int id) async {
    // isSpecificTenantLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenants').select().eq('id', id).execute();

      final businessTypeResponse = await AppConfig().supaBaseClient.from('business_types').select().eq('id', response.data[0]['business_type_id']).execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print('Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
      print('Tenants TABLE row id == ${businessTypeResponse.data[0]['id']}');

      uIndividualBusinessType.value = businessTypeResponse.data[0]['name'];
      uIndividualBusinessTypeId.value = businessTypeResponse.data[0]['id'];
      uIndividualName.value = response.data[0]['name'];

    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }

  }


  getCompanyTenantCountryDetails(int id) async {
    // isSpecificTenantLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenants').select().eq('id', id).execute();

      final countryTypeResponse = await AppConfig().supaBaseClient.from('currency_types').select().eq('id', response.data[0]['nation_id']).execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();


      print('Tenants TABLE row id == ${countryTypeResponse.data[0]['id']}');

      uCompanyCountryType.value = countryTypeResponse.data[0]['country'];

    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }

  }

  getIndividualTenantCountryDetails(int id) async {
    // isSpecificTenantLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenants').select().eq('id', id).execute();

      final countryTypeResponse = await AppConfig().supaBaseClient.from('currency_types').select().eq('id', response.data[0]['nation_id']).execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();


      print('Tenants TABLE row id == ${countryTypeResponse.data[0]['id']}');

      uIndividualCountryType.value = countryTypeResponse.data[0]['country'];

    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }

  }


  getIndividualTenantDetails(int id) async {
    // isSpecificTenantLoading(true);



    try {
      // Fetch the specific row based on ID
      final response = await AppConfig().supaBaseClient.from('tenants').select().eq('id', id).execute();

      final businessTypeResponse = await AppConfig().supaBaseClient.from('business_types').select().eq('id', response.data[0]['business_type_id']).execute();
      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print('Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
      print('Tenants TABLE row id == ${businessTypeResponse.data[0]['id']}');

      uCompanyBusinessType.value = businessTypeResponse.data[0]['name'];
      uCompanyBusinessTypeId.value = businessTypeResponse.data[0]['id'];


    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }

  }


}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/nationality/nationality_model.dart';
import 'package:smart_rent/models/payment/tenant_payment_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/schedule/tenant_unit_schedule.dart';
import 'package:smart_rent/models/tenant/property_tenant_model.dart';
import 'package:smart_rent/models/tenant/property_tenant_schedule.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/tenant/tenant_profile_model.dart';
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/tenant/tenant_unit_model.dart';
import 'package:smart_rent/models/unit/specific_tenant_unit_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:uuid/uuid.dart';
import "package:collection/collection.dart";

class TenantController extends GetxController {

  RxList<NationalityModel> nationalityList = <NationalityModel>[].obs;
  RxList<SalutationModel> salutationList = <SalutationModel>[].obs;
  RxList<TenantTypeModel> tenantTypeList = <TenantTypeModel>[].obs;
  RxList<UnitModel> unitList = <UnitModel>[].obs;
  RxList<UnitModel> specificUnitList = <UnitModel>[].obs;
  RxList<TenantModel> tenantList = <TenantModel>[].obs;
  RxList<BusinessTypeModel> businessList = <BusinessTypeModel>[].obs;
  RxList<TenantUnitModel> tenantUnitList = <TenantUnitModel>[].obs;
  RxList<UnitModel> specificTenantUnits = <UnitModel>[].obs;
  RxList<TenantPaymentModel> tenantPaymentList = <TenantPaymentModel>[].obs;
  RxList<PropertyTenantModel> propertyTenantList = <PropertyTenantModel>[].obs;
  RxList<UnitPropertyScheduleModel> propertyUnitScheduleList = <UnitPropertyScheduleModel>[].obs;
  RxList<UnitPropertyScheduleModel> specificUnitScheduleList = <UnitPropertyScheduleModel>[].obs;
  RxList<TenantUnitScheduleModel> tenantUnitUnitScheduleList = <TenantUnitScheduleModel>[].obs;
  RxList<TenantUnitScheduleModel> specificTenantUnitScheduleList = <TenantUnitScheduleModel>[].obs;
  RxList<SpecificTenantUnitModel> specificTenantUnitModelList = <SpecificTenantUnitModel>[].obs;
  RxList<TenantUnitScheduleModel> tenantUnitUnitScheduleListGroup = <TenantUnitScheduleModel>[].obs;
  RxList<PropertyModel> propertyModelList = <PropertyModel>[].obs;
  RxMap<dynamic, TenantUnitScheduleModel> tenantUnitUnitScheduleMap = <dynamic, TenantUnitScheduleModel>{}.obs;


  RxList<PaymentScheduleModel> paymentList = <PaymentScheduleModel>[].obs;


  var tenantUnitAmount = 0.obs;
  var unitNumber = ''.obs;
  var specificTenantName = ''.obs;
  var specificUnitNumber = 0.obs;

  var companyProfileWithContact = TenantProfileContactModel().obs;

  var isAddContactPerson = false.obs;
  var isAddNextOfKin = false.obs;

  var nationalityId = 0.obs;
  var tenantTypeId = 0.obs;
  var unitId = 0.obs;
  var specificUnitId = 0.obs;
  var tenantId = 0.obs;
  var specificScheduleId = 0.obs;
  var unitAmount = 0.obs;
  var businessTypeId = 0.obs;
  var newGender = ''.obs;
  var isTenantListLoading = false.obs;
  var isTenantUnitListLoading = false.obs;
  var isSpecificTenantLoading = false.obs;
  var isContactDetailsLoading = false.obs;
  var isIndividualTenantDetailsLoading = false.obs;
  var isTenantPaymentsLoading = false.obs;
  var isPropertyTenantLoading = false.obs;
  var isPaymentScheduleLoading = false.obs;
  var isSpecificPaymentScheduleLoading = false.obs;
  var isTenantUnitScheduleLoading = false.obs;
  var isSpecificTenantUnitScheduleLoading = false.obs;
  var isSpecificUnitsLoading = false.obs;
  var isPropertyModelListLoading = false.obs;
  var selectedPropertyId = 0.obs;



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
  var specificPaymentAmount = 0.obs;
  var specificPaymentBalance = 0.obs;
  var specificPaymentPaid = 0.obs;

  var schedules = [].obs;


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
    fetchOnlyAvailableUnits();
    // fetchAllTenants();
    listenToTenantChanges();
    fetchAllUnits();
    fetchAllBusinessTypes();
    fetchAllPayments();
    // fetchNestedTenantsUnits();
    listenToPropertyTenantListChanges();
listenToTenantPaymentChanges();
    listenToPropertyModelListChanges();
// fetchAllPaymentSchedules();
    // listenToPropertyPaymentScheduleChanges();

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

  setSpecificUnitId(int id){
    specificUnitId.value = id;
    print('New Unit Id is $id');
  }

  setUnitNumber(String number){
    unitNumber.value = number;
    print('New Unit Number is $number');
  }

  setUnitAmount(int amount){
    unitAmount.value = amount;
    print('New Unit Amount is $amount');
  }

  setTenantId(int id){
    tenantId.value = id;
    print('New Tenant Id is $id');
  }

  setSpecificScheduleId(int id){
    specificScheduleId.value = id;
    print('New Schedule Id is $id');
  }

  setBusinessTypeId(int id){
    businessTypeId.value = id;
    print('New Business Type Id is $id');
  }

  setPaymentScheduleId(int id){
    paymentScheduleId.value = id;
    print('New Payment Schedule Id is $id');
  }

  setSpecificTenantName(String name){
    specificTenantName.value = name;
    print('New Tenant Name is $name');
  }

  setSpecificTenantUnitNumber(int id){
    specificUnitNumber.value = id;
    print('New Unit Number is $id');
  }

  setFromDate(String date1){
    tenantUnitList.value.first.fromDate = date1;

    print('NEEWWEEST DATE ==${date1}');
  }

  setAmountForSpecificTenantUnit(UnitModel? unitModel){
    tenantUnitAmount.value = unitModel == null ? specificTenantUnits.value.first.amount : unitModel.amount;
    print('Tenant Unit Amount == ${tenantUnitAmount.value}');
}

setSpecificPaymentBalance(int balance){
  specificPaymentBalance.value = balance;
  print('New balance is $balance');
}

  setSpecificPaymentAmount(int amount){
    specificPaymentAmount.value = amount;
    print('New Amount is $amount');
  }

  setSpecificPaymentPaid(int paid){
    specificPaymentPaid.value = paid;
    print('New paid is $paid');
  }

  setSelectedPropertyId(int id){
    selectedPropertyId.value = id;
    print('New Selected Propert is $id');
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

  void fetchAllPropertyTenants() async {
    isPropertyTenantLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('tenant_units').select().order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('PROPERTY ALL TENANT RESPONSE IS ${response}');
      print(response.length);
      print(data.length);
      print(data);
      isPropertyTenantLoading(false);

      return propertyTenantList.assignAll(
          data.map((json) => PropertyTenantModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
      isPropertyTenantLoading(false);
    }

  }


  Future<void> fetchSpecificTenantsUnitSchedules() async {
    isSpecificTenantUnitScheduleLoading(true);
    try {

      final filterConditions = {
        'tenant_id': {'eq': tenantId},
        'unit_id': {'eq': unitId},
        // Add more conditions as needed
      };

      final filters = [
        {'tenant_id': tenantId},
        {'unit_id': unitId},
        // Add more conditions as needed
      ];

      final combinedFilter = filters.fold(
        {},
            (previous, current) => {...previous, 'eq': current},
      );

      final response = await AppConfig().supaBaseClient.from('payment_schedule').select(
          'id, from_date, to_date, amount, balance, paid, tenant_id, unit_id, tenants(name), units(unit_number)'
      ).eq('unit_id', unitId).eq('tenant_id', tenantId).gt('balance', 0);

      final data = response as List<dynamic>;

      // List<TenantUnitScheduleModel> scheduleData = (response)
      //     .map((item) => TenantUnitScheduleModel.fromJson(item as Map<String, dynamic>))
      //     .toList();
      // tenantUnitUnitScheduleListGroup.value = scheduleData;


      print('Unit Tenant schedules IS ${response}');
      print('Unit Tenant schedules Amountt IS ${data[0]['amount']}');
      print('Unit Tenant schedules Balance IS ${data[0]['balance']}');

      setSpecificPaymentBalance(data[0]['balance']);
      setSpecificPaymentAmount(data[0]['amount']);
      print(response.length);
      print(data.length);
      print(data);
      isSpecificTenantUnitScheduleLoading(false);


      return specificTenantUnitScheduleList.assignAll(
          data.map((json) => TenantUnitScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching schedules: $error');
      isSpecificTenantUnitScheduleLoading(false);
    }

  }


  Future<void> payForSpecificTenantUnitSchedule(int tenantId, int unitId, String date1, String date2, int amount,
      int paid, int balance, String createdBy, String updatedBy,) async {


    try {



         await AppConfig().supaBaseClient.from('payment_schedule').update(
          {
            "paid" : paid,
            "balance" : balance,
            "date_posted": DateTime.now().toIso8601String(),
          }
      ).eq('id', specificScheduleId.value).execute().then((value) async{

       await addTenantPayment(tenantId, unitId, date1, date2, amount, paid, balance, createdBy, updatedBy);

      });

    } catch (error) {
      print('Error updating Individual tenant: $error');
    }


  }

  Future<void> payForMultipleTenantUnitSchedule(int tenantId, int unitId, String date1, String date2, int amount,
      int paid, int balance, String createdBy, String updatedBy,) async {


    Set uniqueNumbersSet = schedules.toSet();


    List uniqueNumbersList = uniqueNumbersSet.toList();


    print('MY UNIQUE Controller List is $uniqueNumbersList');


    try {

      // Iterate over the list of IDs and update each row
      for (final id in uniqueNumbersList) {
        await AppConfig().supaBaseClient.from('payment_schedule').update(
            {
              "paid" : paid,
              "balance" : balance,
              "date_posted": DateTime.now().toIso8601String(),
            }
        ).eq('id', id).execute().then((value) async{

          await addTenantPayment(tenantId, unitId, date1, date2, amount, paid, balance, createdBy, updatedBy);

        });
      }



    } catch (error) {
      print('Error updating Individual tenant: $error');
    }


  }

  testout(){

    Set uniqueNumbersSet = schedules.toSet();


    List uniqueNumbersList = uniqueNumbersSet.toList();


    print('MY UNIQUE Controller List is $uniqueNumbersList');
  }

  Future<void> fetchNestedTenantsUnits() async {
    isTenantUnitScheduleLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('payment_schedule').select(
        'id, from_date, to_date, amount, balance, paid, tenant_id, unit_id, tenants(name), units(unit_number)'
      ).order('created_at', ascending: false);

      final data = response as List<dynamic>;

      // List<TenantUnitScheduleModel> scheduleData = (response)
      //     .map((item) => TenantUnitScheduleModel.fromJson(item as Map<String, dynamic>))
      //     .toList();
      // tenantUnitUnitScheduleListGroup.value = scheduleData;

      print('Grouped list is $tenantUnitUnitScheduleListGroup');
      print('Unit Tenants IS ${response}');
      print(response.length);
      print(data.length);
      print(data);
      isTenantUnitScheduleLoading(false);


      return tenantUnitUnitScheduleList.assignAll(
          data.map((json) => TenantUnitScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching unit tenants: $error');
      isTenantUnitScheduleLoading(false);
    }

  }

  getTenantdatalist(){

    var group = groupBy(tenantUnitUnitScheduleList, (TenantUnitScheduleModel e) => [e.tenantId, e.unitId]);

    print('My Group 1= $group');
    print('My Group type= ${group.runtimeType}');
    print('My Group length= ${group.length}');

  }




  Map<String, dynamic> groupAllPropertyTenants() {


    Map<String, dynamic> groupedData = {};

    for (var item in propertyTenantList) {
      var key = item.tenantId;
      groupedData[key.toString()] = (groupedData[key] ?? 0) + 1;

      // if (groupedData.containsKey(key)) {
      //   groupedData[key.toString()] += 1;
      // } else {
      //   groupedData[key.toString()] = 1;
      // }
    }

    print(groupedData);
    print(groupedData.length);
    return groupedData;
  }


  void fetchAllPaymentSchedules(int tenantId) async {
    isPaymentScheduleLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('payment_schedule').select().eq('tenant_id', tenantId).order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('PROPERTY Payment TENANT data IS ${data}');
      print(response.length);
      print(data.length);
      print(data);
      isPaymentScheduleLoading(false);
      print(propertyUnitScheduleList.length);
      return propertyUnitScheduleList.assignAll(
          data.map((json) => UnitPropertyScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
      isPaymentScheduleLoading(false);
    }

    print(propertyUnitScheduleList.length);

  }

  void getSpecificTenantDetails(int tenantId) async {

    isPaymentScheduleLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('payment_schedule').select().eq('tenant_id', tenantId).order('created_at', ascending: false);

      final tenantResponse = await AppConfig().supaBaseClient.from('tenants').select().eq('id', tenantId);
      // final unitResponse = await AppConfig().supaBaseClient.from('units').select().eq('unit_id', unitId);
      // final unitData = unitResponse as List<dynamic>;
      final tenantData = tenantResponse as List<dynamic>;

      
      //
      print('Specific Tenant Response is $tenantResponse');
      print('Specific Tenant Data is $tenantData');
      print(tenantData.map((e) => e['name']).toString().substring(1).replaceAll(')', ''));
      setSpecificTenantName(tenantData.map((e) => e['name']).toString().substring(1).replaceAll(')', ''));

      print('New Tenant is ${specificTenantName.value}');

      // final containedResponse = await AppConfig().supaBaseClient
      //     .from('units')
      //     .select()
      //     .in_('id', unitData.map((e) => e['unit_id']).toList());

      final data = response as List<dynamic>;
      print('PROPERTY Payment TENANT data IS ${data}');
      print(response.length);
      print(data.length);
      print(data);
      isPaymentScheduleLoading(false);
      print(propertyUnitScheduleList.length);
      return propertyUnitScheduleList.assignAll(
          data.map((json) => UnitPropertyScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
      isPaymentScheduleLoading(false);
    }

    print(propertyUnitScheduleList.length);

  }


  void fetchSpecificUnitPaymentSchedules(int unitId) async {
    specificUnitScheduleList.value.clear();
    isSpecificPaymentScheduleLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('payment_schedule').select().eq('unit_id', unitId).order('created_at', ascending: false);
      final unitResponse = await AppConfig().supaBaseClient.from('units').select().eq('id', unitId);
      final unitData = unitResponse as List<dynamic>;
      final data = response as List<dynamic>;

      print('Specific Unit Response is $unitResponse');
      print('Specific Unit Data is $unitData');
      print(unitData.map((e) => e['unit_number']).toString().substring(1).replaceAll(')', ''));
      setSpecificTenantUnitNumber(int.parse(unitData.map((e) => e['unit_number']).toString().substring(1).replaceAll(')', '')));

      print('New Unit is ${specificUnitNumber.value}');
      
      print('UNIT Payment Sschedule data IS ${data}');
      print(response.length);
      print(data.length);
      print(data);
      isSpecificPaymentScheduleLoading(false);
      print(specificUnitScheduleList.length);
      return specificUnitScheduleList.assignAll(
          data.map((json) => UnitPropertyScheduleModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
      isSpecificPaymentScheduleLoading(false);
    }

    print(propertyUnitScheduleList.length);

  }

  Map<String, dynamic> groupAllPaymentSchedules() {


    Map<String, dynamic> groupedData = {};

    for (var item in propertyUnitScheduleList) {
      var key = item.unitId;
      groupedData[key.toString()] = (groupedData[key] ?? 0) + 1;

      // if (groupedData.containsKey(key)) {
      //   groupedData[key.toString()] += 1;
      // } else {
      //   groupedData[key.toString()] = 1;
      // }
    }

    return groupedData;
  }


  void listenToPropertyPaymentScheduleChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('payment_schedule')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      // fetchAllPaymentSchedules();

    });

  }


  void listenToPropertyTenantListChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('tenant_units')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
          fetchAllPropertyTenants();

    });

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


  void fetchOnlyAvailableUnits() async {

    try {

      final response = await AppConfig().supaBaseClient.from('units').select().eq('is_available', 1);
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return specificUnitList.assignAll(
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


  Future<void> getTenantUnits(UnitModel? unitModel) async {
    isTenantUnitListLoading(true);

    // final data = await AppConfig().supaBaseClient.from('tenant_units')
    //     .select('id')
    //     .like('tenant_id', tenantId.toString()).execute();


    // final unitResponse = await AppConfig().supaBaseClient.from('units').select().eq('id', data);

    try {

      final response = await AppConfig().supaBaseClient.from('tenant_units').select().eq('tenant_id', tenantId);
      final unitResponse = await AppConfig().supaBaseClient.from('tenant_units').select('unit_id').eq('tenant_id', tenantId);
      final data = response as List<dynamic>;
      final unitData = unitResponse as List<dynamic>;


      print(response);
      print(unitResponse);
      print(unitData.map((e) => e['unit_id']).toList());

      final containedResponse = await AppConfig().supaBaseClient
          .from('units')
          .select()
          .in_('id', unitData.map((e) => e['unit_id']).toList());

      print('My Contained Data is ${containedResponse}');
      final getAllUnitData = containedResponse as List<dynamic>;
      specificTenantUnits.assignAll(
          getAllUnitData.map((unit) => UnitModel.fromJson(unit)).toList());

      print('SPEcific tenants ==${specificTenantUnits.value}');
      // tenantUnitAmount.value = unitModel!.amount ?? specificTenantUnits.value.first.amount;
      setAmountForSpecificTenantUnit(unitModel);
      setUnitNumber(specificTenantUnits.value.first.unitNumber);
      print('SPEcific amount ==${tenantUnitAmount.value}');
      print(getAllUnitData);

      print(response.length);
      print(data.length);
      print(data);
      isTenantUnitListLoading(false);
      print(tenantUnitList.value);
      return tenantUnitList.assignAll(
          data.map((json) => TenantUnitModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenant Units: $error');
      isTenantUnitListLoading(false);
    }

    print('My TenantUnitList $tenantUnitList');

  }


  Future<void> getSpecificTenantUnits() async {
    isSpecificUnitsLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('tenant_units').select(
          'id, from_date, to_date, amount, tenant_id, unit_id, tenants(name), units(unit_number)'
      ).eq('tenant_id', tenantId) .order('created_at', ascending: false);

      final data = response as List<dynamic>;

      // List<TenantUnitScheduleModel> scheduleData = (response)
      //     .map((item) => TenantUnitScheduleModel.fromJson(item as Map<String, dynamic>))
      //     .toList();
      // tenantUnitUnitScheduleListGroup.value = scheduleData;

      print('Grouped list is $tenantUnitUnitScheduleListGroup');
      print('Unit Tenants IS ${response}');
      print(response.length);
      print(data.length);
      print(data);
      isSpecificUnitsLoading(false);


      return specificTenantUnitModelList.assignAll(
          data.map((json) => SpecificTenantUnitModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching unit tenants: $error');
      isSpecificUnitsLoading(false);
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

  void listenToTenantPaymentChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('payments')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllTenantPayments();
    });

  }


  Future<void> updateUnitStatusAvailable(UnitModel unitModel)async{
    try{
      await AppConfig().supaBaseClient.from('units').update(
          {
            "is_available" : 1,
          }
      ).eq('id', unitModel.id).then((value) {
        Fluttertoast.showToast(msg: '${unitModel.unitNumber} is now available');
      });
    } catch(error){
      print(error);
    }
  }

  Future<void> addTenantToUnit( int tenantId, String createdBy,
      int unitId, String date1, String date2, int amount, int discount, List<Map<String, dynamic>> periodList
      ) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('tenant_units').insert(
          {
            "amount" : amount,
            "discount" : discount,
            "unit_id": unitId,
            // "organisation_id": organisationId,
            "tenant_id": tenantId,
            "created_by" : createdBy,
            "from_date" : date1,
            "to_date" : date2,
            // "updated_at" : DateTime.now(),
          }
      ).then((tenant) async{

        await AppConfig().supaBaseClient.from('units').update(
            {
              "is_available" : 0,
            }
        ).eq('id', unitId);

        await addPaymentSchedule(periodList);

        // Get.back();
        // Get.snackbar('SUCCESS', 'Tenant added to unit',
        //   titleText: Text(
        //     'SUCCESS', style: AppTheme.greenTitle1,),
        // );
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


  addTenantPayment(int tenantId, int unitId, String date1, String date2, int amount,
      int paid, int balance, String createdBy, String updatedBy,
      ) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('payments').insert(
          {
            "amount" : amount,
            "paid" : paid,
            "balance" : balance,
            "unit_id": unitId,
            "from_date": date1,
            "to_date": date2,
            "tenant_id": tenantId,
            "created_by" : createdBy,
            "updated_by" : updatedBy,
          }
      ).then((indTenant) {
        Get.back();
        Get.snackbar('SUCCESS', 'Tenant payment added',
          titleText: Text(
            'SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        throw response.error;
      }

    } catch (error) {
      print('Error adding tenant payment: $error');
    }


  }

  void fetchAllTenantPayments() async {
    isTenantPaymentsLoading(true);

    try {

      final response = await AppConfig().supaBaseClient.from('payments').select().order('created_at');
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);
      isTenantPaymentsLoading(false);
      return tenantPaymentList.assignAll(
          data.map((json) => TenantPaymentModel.fromJson(json)).toList());

    } catch (error) {
      isTenantPaymentsLoading(false);
      print('Error fetching tenant payments: $error');
    }


  }


  // addPaymentSchedule(int tenantId, int unitId, String fromDate, String toDate, int amount,
  //     int paid, int balance, String createdBy, String updatedBy,
  //     ) async {
  //
  //   try {
  //     final response =  await AppConfig().supaBaseClient.from('payment_schedule').insert(
  //         {
  //           "amount" : amount,
  //           "paid" : paid,
  //           "balance" : balance,
  //           "unit_id": unitId,
  //           "from_date": fromDate,
  //           "to_date": toDate,
  //           "tenant_id": tenantId,
  //           "created_by" : createdBy,
  //           "updated_by" : updatedBy,
  //         }
  //     ).then((indTenant) {
  //       Get.back();
  //       Get.snackbar('SUCCESS', 'Payment Schedule added',
  //         titleText: Text(
  //           'SUCCESS', style: AppTheme.greenTitle1,),
  //       );
  //     });
  //
  //     if (response.error != null) {
  //       throw response.error;
  //     }
  //
  //   } catch (error) {
  //     print('Error adding payment schedule: $error');
  //   }
  //
  //
  // }

  Future<void> addPaymentSchedule(List<Map<String, dynamic>> periodList) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('payment_schedule').insert
        (periodList).then((indTenant) {
        Get.back();
        Get.snackbar('SUCCESS', 'Tenant Added',
          titleText: Text(
            'SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        throw response.error;
      }

    } catch (error) {
      print('Error adding payment schedule: $error');
    }


  }


  fetchAllPropertiesSpecificOrganization() async {
    isPropertyModelListLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('properties').select()
          .eq('organisation_id', userStorage.read('OrganizationId'));
      final data = response as List<dynamic>;
      print('my Properties are $response');
      print(response.length);
      print(data.length);
      print(data);
      isPropertyModelListLoading(false);

      return propertyModelList.assignAll(
          data.map((json) => PropertyModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching User Roles: $error');
      isPropertyModelListLoading(false);
    }

  }

  void listenToPropertyModelListChanges() {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('properties')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      fetchAllPropertiesSpecificOrganization();

    });

  }


}
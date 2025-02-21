import 'dart:typed_data';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/business/business_type_model.dart';
import 'package:smart_rent/models/documents/documents_model.dart';
import 'package:smart_rent/models/nationality/nationality_model.dart';
import 'package:smart_rent/models/payment/tenant_payment_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/schedule/tenant_unit_schedule.dart';
import 'package:smart_rent/models/tenant/property_tenant_model.dart';
import 'package:smart_rent/models/tenant/property_tenant_schedule.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/tenant/tenant_profile_contact_model.dart';
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/tenant/tenant_unit_model.dart';
import 'package:smart_rent/models/unit/specific_tenant_unit_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class TenantController extends GetxController with StateMixin {
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
  RxList<UnitPropertyScheduleModel> propertyUnitScheduleList =
      <UnitPropertyScheduleModel>[].obs;
  RxList<UnitPropertyScheduleModel> specificUnitScheduleList =
      <UnitPropertyScheduleModel>[].obs;
  RxList<TenantUnitScheduleModel> tenantUnitUnitScheduleList =
      <TenantUnitScheduleModel>[].obs;
  RxList<TenantUnitScheduleModel> specificTenantUnitScheduleList =
      <TenantUnitScheduleModel>[].obs;
  RxList<SpecificTenantUnitModel> specificTenantUnitModelList =
      <SpecificTenantUnitModel>[].obs;
  RxList<TenantUnitScheduleModel> tenantUnitUnitScheduleListGroup =
      <TenantUnitScheduleModel>[].obs;
  RxList<PropertyModel> propertyModelList = <PropertyModel>[].obs;
  RxList<PropertyModel> specificUserPropertyModelList = <PropertyModel>[].obs;
  RxList<DocumentsModel> specificTenantDocumentList = <DocumentsModel>[].obs;
  RxList<TenantProfileContactModel> specificTenantProfileContactList =
      <TenantProfileContactModel>[].obs;
  RxMap<dynamic, TenantUnitScheduleModel> tenantUnitUnitScheduleMap =
      <dynamic, TenantUnitScheduleModel>{}.obs;

  RxList<PaymentScheduleModel> paymentList = <PaymentScheduleModel>[].obs;

  var tenantUnitAmount = 0.obs;
  var unitNumber = ''.obs;
  var specificTenantName = ''.obs;
  var specificUnitNumber = 0.obs;

  var companyProfileWithContact = TenantProfileContactModel().obs;

  var isAddContactPerson = false.obs;
  var isAddNextOfKin = false.obs;
  var isAddTenantToUnitLoading = false.obs;
  var isPayForMultipleSchedulesLoading = false.obs;

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
  var isSpecificUserPropertyListLoading = false.obs;
  var selectedPropertyId = 0.obs;
  var isSpecificTenantProfileContactsLoading = false.obs;
  var isAddTenantLoading = false.obs;
  var totalScheduleBalance = 0.obs;

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
    // fetchOnlyAvailableUnits();
    // fetchAllTenants();
    listenToTenantChanges();
    fetchAllUnits();
    fetchAllBusinessTypes();
    fetchAllPayments();
    // fetchNestedTenantsUnits();
    // listenToPropertyTenantListChanges();
// listenToTenantPaymentChanges();
    listenToPropertyModelListChanges();
// fetchAllPaymentSchedules();
    // listenToPropertyPaymentScheduleChanges();
  }

  setTotalScheduleBalance(int totalBalance) {
    totalScheduleBalance.value = totalBalance;
    print('total schedule balance == $totalScheduleBalance');
  }

  setNewGender(String gender) {
    newGender.value = gender;
    print(gender);
  }

  addContactPerson(bool value) {
    isAddContactPerson.toggle();
    print(value);
  }

  setNationalityId(int id) {
    nationalityId.value = id;
    print('New Nationality Id is $id');
  }

  setTenantTypeId(int id) {
    tenantTypeId.value = id;
    print('New Tenant Type Id is $id');
  }

  setUnitId(int id) {
    unitId.value = id;
    print('New Unit Id is $id');
  }

  setSpecificUnitId(int id) {
    specificUnitId.value = id;
    print('New Unit Id is $id');
  }

  setUnitNumber(String number) {
    unitNumber.value = number;
    print('New Unit Number is $number');
  }

  setUnitAmount(int amount) {
    unitAmount.value = amount;
    print('New Unit Amount is $amount');
  }

  setTenantId(int id) {
    tenantId.value = id;
    print('New Tenant Id is $id');
  }

  setSpecificScheduleId(int id) {
    specificScheduleId.value = id;
    print('New Schedule Id is $id');
  }

  setBusinessTypeId(int id) {
    businessTypeId.value = id;
    print('New Business Type Id is $id');
  }

  setPaymentScheduleId(int id) {
    paymentScheduleId.value = id;
    print('New Payment Schedule Id is $id');
  }

  setSpecificTenantName(String name) {
    specificTenantName.value = name;
    print('New Tenant Name is $name');
  }

  setSpecificTenantUnitNumber(int id) {
    specificUnitNumber.value = id;
    print('New Unit Number is $id');
  }

  setFromDate(String date1) {
    tenantUnitList.value.first.fromDate = date1;

    print('NEEWWEEST DATE ==${date1}');
  }

  setAmountForSpecificTenantUnit(UnitModel? unitModel) {
    tenantUnitAmount.value = unitModel == null
        ? specificTenantUnits.value.first.amount
        : unitModel.amount;
    print('Tenant Unit Amount == ${tenantUnitAmount.value}');
  }

  setSpecificPaymentBalance(int balance) {
    specificPaymentBalance.value = balance;
    print('New balance is $balance');
  }

  setSpecificPaymentAmount(int amount) {
    specificPaymentAmount.value = amount;
    print('New Amount is $amount');
  }

  setSpecificPaymentPaid(int paid) {
    specificPaymentPaid.value = paid;
    print('New paid is $paid');
  }

  setSelectedPropertyId(int id) {
    selectedPropertyId.value = id;
    print('New Selected Propert is $id');
  }

  fetchAllPayments() async {
    try {
      final response =
          await AppConfig().supaBaseClient.from('payment_schedules').select();
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
      final response =
          await AppConfig().supaBaseClient.from('currency_symbol').select();
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
      final response =
          await AppConfig().supaBaseClient.from('salutations').select();
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
      final response =
          await AppConfig().supaBaseClient.from('tenant_types').select();
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

  Future<void> fetchAllTenants() async {
    // isTenantListLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select(
              'id, name, tenant_type_id, nation_id, tenant_no, created_by, organisation_id, business_type_id, description, documents(file_url, external_key, created_at), image, business_types(name), tenant_types(name), currency_symbol(country), tenant_profiles(email, date_of_birth, nin, gender, tenant_id, description, contact)')
          .eq('organisation_id', userStorage.read('OrganizationId'))
          .order('created_at');
      final data = response as List<dynamic>;
      print('MY TENANTS RESPONSE: $response');
      print(response.length);
      print(data.length);
      print(data);
      // isTenantListLoading(false);

      tenantList
          .assignAll(data.map((json) => TenantModel.fromJson(json)).toList());
      if (tenantList.isNotEmpty) {
        change(tenantList, status: RxStatus.success());
      } else {
        change(tenantList, status: RxStatus.empty());
      }

      // return tenantList.assignAll(
      //     data.map((json) => TenantModel.fromJson(json)).toList());
    } on PostgrestException catch (error) {
      change(null, status: RxStatus.error('Error ${error.code}'));
      print('Error fetching Tenants Rent: $error');
      // isTenantListLoading(false);
    }
  }

  void fetchSpecificTenantDocuments(int tenantId) async {
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('documents')
          .select()
          .eq('external_key', tenantId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('SPECIFIC TENANT DOCUMENTS ARE == $response');
      print(response.length);
      print(data.length);
      print(data);

      return specificTenantDocumentList.assignAll(
          data.map((json) => DocumentsModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching specific tenant documents: $error');
    }
  }

  void fetchSpecificProfileContacts(int tenantId) async {
    isSpecificTenantProfileContactsLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_profile_contacts')
          .select()
          .eq('tenant_id', tenantId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('SPECIFIC TENANT Profile Contacts ARE == $response');
      print(response.length);
      print(data.length);
      print(data);
      isSpecificTenantProfileContactsLoading(false);
      return specificTenantProfileContactList.assignAll(data
          .map((json) => TenantProfileContactModel.fromJson(json))
          .toList());
    } catch (error) {
      isSpecificTenantProfileContactsLoading(false);
      print('Error fetching specific TENANT Profile Contacts: $error');
    }
  }

  void fetchAllPropertyTenants(int propertyId) async {
    isPropertyTenantLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_units')
          .select(
              '*, tenants(*, documents(*), currency_symbol(*), tenant_types(*), business_types(*))')
          .eq('property_id', propertyId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('PROPERTY ALL TENANT RESPONSE IS ${response}');
      print(response.length);
      print(data.length);
      print(data);
      isPropertyTenantLoading(false);

      return propertyTenantList.assignAll(
          data.map((json) => PropertyTenantModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching property Tenants units: $error');
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

      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .select(
              'id, from_date, to_date, amount, balance, paid, tenant_id, unit_id, tenants(name), units(unit_number)')
          .eq('unit_id', unitId)
          .eq('tenant_id', tenantId)
          .gt('balance', 0);

      final data = response as List<dynamic>;

      // List<TenantUnitScheduleModel> scheduleData = (response)
      //     .map((item) => TenantUnitScheduleModel.fromJson(item as Map<String, dynamic>))
      //     .toList();
      // tenantUnitUnitScheduleListGroup.value = scheduleData;

      print('Unit Tenant schedules IS ${response}');
      print('Unit Tenant schedules Amount IS ${data[0]['amount']}');
      print('Unit Tenant schedules Balance IS ${data[0]['balance']}');

      print('specific schedule == ${data[0]}');
      print('specific balance == ${data[0]['balance']}');
      // double sum = data[0]['discount'].fold(0, (previous, current) => previous + (current ?? 0));

      int calculatedSum = 0;
      for (var schedule in data) {
        // Assuming the column contains integer values
        calculatedSum += schedule['balance'] as int;
      }

      print('new calculated Sum == $calculatedSum');
      print('new calculated Sum == $calculatedSum');
      setTotalScheduleBalance(calculatedSum);
      print('new calculated var balance == $totalScheduleBalance');

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

  Future<void> payForSpecificTenantUnitSchedule(
    int tenantId,
    int unitId,
    String date1,
    String date2,
    int amount,
    int paid,
    int balance,
    String createdBy,
    String updatedBy,
  ) async {
    try {
      await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .update({
            "paid": paid,
            "balance": balance,
            "date_posted": DateTime.now().toIso8601String(),
          })
          .eq('id', specificScheduleId.value)
          .execute()
          .then((value) async {
            await addTenantPayment(tenantId, unitId, date1, date2, amount, paid,
                balance, createdBy, updatedBy);
          });
    } catch (error) {
      print('Error updating Individual tenant: $error');
    }
  }

  Future<void> payForMultipleTenantUnitSchedule(
    int tenantId,
    int unitId,
    String date1,
    String date2,
    int amount,
    int paid,
    int balance,
    String createdBy,
    String updatedBy,
  ) async {
    isPayForMultipleSchedulesLoading(true);

    Set uniqueNumbersSet = schedules.toSet();

    List uniqueNumbersList = uniqueNumbersSet.toList();

    print('MY UNIQUE Controller List is $uniqueNumbersList');

    int initialPaid = paid;

    try {
      for (final pid in uniqueNumbersList) {
        final response = await AppConfig()
            .supaBaseClient
            .from('payment_schedule')
            .select()
            .eq('id', pid)
            .execute();

        var myBalance = response.data[0]['balance'];
        var myAmount = response.data[0]['amount'];

        if (initialPaid >= myBalance) {
          initialPaid -= int.parse(myBalance.toString());
          await AppConfig()
              .supaBaseClient
              .from('payment_schedule')
              .update({
                "paid": myBalance,
                "balance": 0,
                "date_posted": DateTime.now().toIso8601String(),
              })
              .eq('id', pid)
              .execute();
          print('Transferred $initialPaid');
        } else {
          myBalance -= initialPaid;
          await AppConfig()
              .supaBaseClient
              .from('payment_schedule')
              .update({
                "paid": myBalance == 0 ? myAmount : initialPaid,
                "balance": myBalance,
                "date_posted": DateTime.now().toIso8601String(),
              })
              .eq('id', pid)
              .execute();
          print('Transferred $myBalance');
          break;
        }
      }

      // // Iterate over the list of IDs and update each row
      // for (final id in uniqueNumbersList) {
      //
      //   var response;
      //   await AppConfig().supaBaseClient.from('payment_schedule').select().eq('id', id).single().then((value) => response = value)
      //   .then((value) async{
      //     var myResponse = response['balance'];
      //     print('my Response  $myResponse');
      //     print('my Response  type is ${myResponse.runtimeType}');
      //
      //     await AppConfig().supaBaseClient.from('payment_schedule').update(
      //         {
      //           "paid" : paid,
      //           "balance" : myResponse - paid,
      //           "date_posted": DateTime.now().toIso8601String(),
      //         }
      //     ).eq('id', id).execute().then((value) async{
      //
      //       await addTenantPayment(tenantId, unitId, date1, date2, amount, paid, myResponse - paid, createdBy, updatedBy);
      //
      //     });
      //
      //   });
      //   print('Functions response == is $response');
      //
      //
      //   // final response = await AppConfig()
      //   //     .supaBaseClient
      //   //     .from('payment_schedule')
      //   //     .select()
      //   //     .eq('id', id)
      //   //     .single();
      //   //
      //   // var myResponse = response['balance'];
      //   // print('my Response  $myResponse');
      //   // print('my Response  type is ${myResponse.runtimeType}');
      //   //
      //   // await AppConfig().supaBaseClient.from('payment_schedule').update(
      //   //     {
      //   //       "paid" : paid,
      //   //       "balance" : response['balance'] - paid  ,
      //   //       "date_posted": DateTime.now().toIso8601String(),
      //   //     }
      //   // ).eq('id', id).execute().then((value) async{
      //   //   var exactBalance = paid - int.parse(response['balance']);
      //   //
      //   //   await addTenantPayment(tenantId, unitId, date1, date2, amount, paid, exactBalance, createdBy, updatedBy);
      //   //
      //   // });
      //
      // }
    } catch (error) {
      isPayForMultipleSchedulesLoading(false);
      print('Error updating Individual tenant: $error');
    }
  }

  testout() {
    Set uniqueNumbersSet = schedules.toSet();

    List uniqueNumbersList = uniqueNumbersSet.toList();

    print('MY UNIQUE Controller List is $uniqueNumbersList');
  }

  Future<void> fetchNestedTenantsUnits() async {
    isTenantUnitScheduleLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .select(
              'id, from_date, to_date, amount, balance, paid, tenant_id, unit_id, tenants(name), units(unit_number)')
          .order('created_at', ascending: false);

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

  getTenantdatalist() {
    var group = groupBy(tenantUnitUnitScheduleList,
        (TenantUnitScheduleModel e) => [e.tenantId, e.unitId]);

    print('My Group 1= $group');
    print('My Group type= ${group.runtimeType}');
    print('My Group length= ${group.length}');
  }

  // Map<String, dynamic> groupAllPropertyTenants() {
  //
  //
  //   Map<String, dynamic> groupedData = {};
  //
  //   for (var item in propertyTenantList) {
  //     var key = item.tenantModel!.name;
  //     groupedData[key.toString()] = (groupedData[key] ?? 0) + 1;
  //
  //     // if (groupedData.containsKey(key)) {
  //     //   groupedData[key.toString()] += 1;
  //     // } else {
  //     //   groupedData[key.toString()] = 1;
  //     // }
  //   }
  //
  //   print('Grouped property $groupedData');
  //   print(groupedData.length);
  //   return groupedData;
  // }

  // Map<String, dynamic> groupAllPropertyTenants() {
  //
  //
  //   Map<String, dynamic> groupedData = {};
  //
  //   for (var item in propertyTenantList) {
  //     var key = item.tenantModel!.name;
  //     groupedData[key.toString()] = (groupedData[key] ?? 0) + 1;
  //
  //     // if (groupedData.containsKey(key)) {
  //     //   groupedData[key.toString()] += 1;
  //     // } else {
  //     //   groupedData[key.toString()] = 1;
  //     // }
  //   }
  //
  //   print('Grouped property $groupedData');
  //   print(groupedData.length);
  //   return groupedData;
  // }

  Map<K, List<V>> groupAllPropertyTenants<K, V>(
      List<V> list, K Function(V) getKey) {
    final Map<K, List<V>> groupedData = {};
    for (final element in list) {
      final key = getKey(element);
      groupedData.putIfAbsent(key, () => []).add(element);
    }
    return groupedData;
  }

  void fetchAllPaymentSchedules(int tenantId) async {
    isPaymentScheduleLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .select()
          .eq('tenant_id', tenantId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('PROPERTY Payment TENANT data IS ${data}');
      print(response.length);
      print(data.length);
      print(data);
      isPaymentScheduleLoading(false);
      print(propertyUnitScheduleList.length);
      return propertyUnitScheduleList.assignAll(data
          .map((json) => UnitPropertyScheduleModel.fromJson(json))
          .toList());
    } catch (error) {
      print('Error fetching Tenants: $error');
      isPaymentScheduleLoading(false);
    }

    print(propertyUnitScheduleList.length);
  }

  void getSpecificTenantDetails(int tenantId) async {
    isPaymentScheduleLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .select()
          .eq('tenant_id', tenantId)
          .order('created_at', ascending: false);

      final tenantResponse = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', tenantId);
      // final unitResponse = await AppConfig().supaBaseClient.from('units').select().eq('unit_id', unitId);
      // final unitData = unitResponse as List<dynamic>;
      final tenantData = tenantResponse as List<dynamic>;

      //
      print('Specific Tenant Response is $tenantResponse');
      print('Specific Tenant Data is $tenantData');
      print(tenantData
          .map((e) => e['name'])
          .toString()
          .substring(1)
          .replaceAll(')', ''));
      setSpecificTenantName(tenantData
          .map((e) => e['name'])
          .toString()
          .substring(1)
          .replaceAll(')', ''));

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
      return propertyUnitScheduleList.assignAll(data
          .map((json) => UnitPropertyScheduleModel.fromJson(json))
          .toList());
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
      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .select()
          .eq('unit_id', unitId)
          .order('created_at', ascending: false);
      final unitResponse = await AppConfig()
          .supaBaseClient
          .from('units')
          .select()
          .eq('id', unitId);
      final unitData = unitResponse as List<dynamic>;
      final data = response as List<dynamic>;

      print('Specific Unit Response is $unitResponse');
      print('Specific Unit Data is $unitData');
      print(unitData
          .map((e) => e['unit_number'])
          .toString()
          .substring(1)
          .replaceAll(')', ''));
      setSpecificTenantUnitNumber(int.parse(unitData
          .map((e) => e['unit_number'])
          .toString()
          .substring(1)
          .replaceAll(')', '')));

      print('New Unit is ${specificUnitNumber.value}');

      print('UNIT Payment Sschedule data IS ${data}');
      print(response.length);
      print(data.length);
      print(data);
      isSpecificPaymentScheduleLoading(false);
      print(specificUnitScheduleList.length);
      return specificUnitScheduleList.assignAll(data
          .map((json) => UnitPropertyScheduleModel.fromJson(json))
          .toList());
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
    AppConfig()
        .supaBaseClient
        .from('payment_schedule')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      // fetchAllPaymentSchedules();
    });
  }

  void listenToPropertyTenantListChanges(int propertyId) {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('tenant_units')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllPropertyTenants(propertyId);
    });
  }

  void fetchAllBusinessTypes() async {
    try {
      final response =
          await AppConfig().supaBaseClient.from('business_types').select();
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

      return unitList
          .assignAll(data.map((json) => UnitModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching Units: $error');
    }
  }

  Future<void> fetchOnlyAvailableUnits(int propertyId) async {
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('units')
          .select('*, floors!inner(*)')
          .eq('is_available', 1)
          .eq('floors.property_id', propertyId);
      final data = response as List<dynamic>;
      print('My Specific Units Are == $response');
      print(response.length);
      print(data.length);
      print(data);

      return specificUnitList
          .assignAll(data.map((json) => UnitModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching only Units: $error');
    }
  }

  addIndividualTenant(
    String name,
    int organisationId,
    int tenantTypeId,
    String createdBy,
    int nationId,
  ) async {
    String uniqueId = uuid.v4();

    try {
      final response = await AppConfig().supaBaseClient.from('tenants').insert({
        "name": name,
        "nation_id": nationId,
        "organisation_id": organisationId,
        "tenant_type_id": tenantTypeId,
        "created_by": createdBy,
      }).then((indTenant) {
        Get.back();
        Get.snackbar(
          'SUCCESS',
          'Tenant added to your list',
          titleText: Text(
            'SUCCESS',
            style: AppTheme.greenTitle1,
          ),
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
  //             "created_by" : "userStorage.read('userProfileId')",
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
  //
  //           {
  //   //             "tenant_id" : compTenant['id'],
  //   //             "first_name" : contactFirstName,
  //   //             "last_name" : contactLastName,
  //   //             "nin" : contactNin,
  //   //             "contact" : contactPhone,
  //   //             "email" : contactEmail,
  //   //             "created_by" : "userStorage.read('userProfileId')",
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

  deleteTenant(int id) async {
    await AppConfig()
        .supaBaseClient
        .from('tenant_profiles')
        .delete()
        .match({'tenant_id': id});
    await AppConfig()
        .supaBaseClient
        .from('tenants')
        .delete()
        .match({'id': id}).then((value) {
      Get.back();
    });
    // fetchAllTenants();
  }

  deleteCompanyTenant(int id) async {
    await AppConfig()
        .supaBaseClient
        .from('tenant_profiles')
        .delete()
        .match({'tenant_id': id});
    await AppConfig()
        .supaBaseClient
        .from('tenant_profile_contacts')
        .delete()
        .match({'tenant_id': id});
    await AppConfig()
        .supaBaseClient
        .from('tenants')
        .delete()
        .match({'id': id}).then((value) {
      Get.back();
    });

    // fetchAllTenants();
  }

  Future<void> addPersonalTenant(
      String name,
      int organisationId,
      int tenantTypeId,
      int businessTypeId,
      String createdBy,
      int nationId,
      String nin,
      String phone,
      String email,
      String? description,
      String dob,
      String gender,
      Uint8List imageBytes,
      String fileExtension,
      String fileName) async {
    isAddTenantLoading(true);
    String uniqueId = uuid.v4();

    print('MY ORG ID == $organisationId');

    try {
      // final imagePath = '/${userStorage.read('userId')}/profile';
      // await AppConfig().supaBaseClient.storage.from('tenants').uploadBinary(
      //   imagePath,
      //   imageBytes,
      //   fileOptions: FileOptions(upsert: true, contentType: 'image/$fileExtension'),
      // );
      //
      // String imageUrl = AppConfig().supaBaseClient.storage.from('tenants').getPublicUrl(imagePath);

      final tenantResponse =
          await AppConfig().supaBaseClient.from('tenants').insert({
        "tenant_no": uniqueId,
        "business_type_id": businessTypeId,
        "name": name,
        "nation_id": nationId,
        "organisation_id": organisationId,
        "tenant_type_id": tenantTypeId,
        "created_by": createdBy,
        "description": description,
        "image": null,
      });

      final data = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select('id')
          .like('tenant_no', uniqueId.toString())
          .execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig().supaBaseClient.from('tenant_profiles').insert({
        "tenant_id": data.data[0]['id'],
        "nin": nin,
        "contact": phone,
        "email": email,
        "description": description,
        "created_by": userStorage.read('userProfileId'),
        "gender": gender,
        "date_of_birth": dob,
      });

      final imagePath = '/${data.data[0]['id']}/profile';
      await AppConfig().supaBaseClient.storage.from('tenants').uploadBinary(
            imagePath,
            imageBytes,
            fileOptions:
                FileOptions(upsert: false, contentType: 'image/$fileExtension'),
          );

      String imageUrl = AppConfig()
          .supaBaseClient
          .storage
          .from('tenants')
          .getPublicUrl(imagePath);

      final docResponse = await AppConfig()
          .supaBaseClient
          .from('documents')
          .insert({
            "name": fileName,
            "file_url": imageUrl,
            "extension": fileExtension,
            "document_type_id": 2,
            "created_by": createdBy,
            "external_key": data.data[0]['id'],
          })
          .select()
          .execute();

      await AppConfig()
          .supaBaseClient
          .from('tenants')
          .update({
            "image": docResponse.data[0]['id'],
          })
          .eq('id', data.data[0]['id'])
          .then((value) async {
            await fetchAllTenants().then((value) {
              print('MY DOCResponse == $docResponse');
              print('MY DOCID == ${docResponse.data[0]['id']}');

              Get.back();
              Get.snackbar('Success', 'Added Personal Tenant');
            });
          });

      isAddTenantLoading(false);
    } catch (error) {
      isAddTenantLoading(false);
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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_units')
          .select()
          .eq('tenant_id', tenantId);
      final unitResponse = await AppConfig()
          .supaBaseClient
          .from('tenant_units')
          .select('unit_id')
          .eq('tenant_id', tenantId);
      final data = response as List<dynamic>;
      final unitData = unitResponse as List<dynamic>;

      print(response);
      print(unitResponse);
      print(unitData.map((e) => e['unit_id']).toList());

      final containedResponse = await AppConfig()
          .supaBaseClient
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
      setUnitNumber(specificTenantUnits.value.first.unitNumber!);
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

  Future<void> getSpecificTenantUnits(int propertyId) async {
    isSpecificUnitsLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_units')
          .select(
              'id, from_date, to_date, amount, tenant_id, unit_id, tenants(name), units(unit_number), property_id')
          .eq('tenant_id', tenantId)
          .eq('property_id', propertyId)
          .order('created_at', ascending: false);

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

  Future<void> addCompanyTenantWithContact(
      String name,
      int organisationId,
      int tenantTypeId,
      int businessTypeId,
      String createdBy,
      int nationId,
      String? contactFirstName,
      String? contactLastName,
      String? contactNin,
      String? contactDesignation,
      String? contactPhone,
      String? contactEmail,
      String? description,
      Uint8List imageBytes,
      String fileExtension,
      String fileName) async {
    isAddTenantLoading(true);
    String uniqueId = uuid.v4();

    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .insert({
            "tenant_no": uniqueId,
            "business_type_id": businessTypeId,
            "name": name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by": createdBy,
            "description": description,
          })
          .select()
          .execute();

      final data = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select('id')
          .like('tenant_no', uniqueId.toString())
          .execute();

      print(data);
      print(data.data[0]['id']);

      final imagePath = '/${response.data[0]['id']}/profile';
      await AppConfig().supaBaseClient.storage.from('tenants').uploadBinary(
            imagePath,
            imageBytes,
            fileOptions:
                FileOptions(upsert: false, contentType: 'image/$fileExtension'),
          );

      String imageUrl = AppConfig()
          .supaBaseClient
          .storage
          .from('tenants')
          .getPublicUrl(imagePath);

      final docResponse = await AppConfig()
          .supaBaseClient
          .from('documents')
          .insert({
            "name": fileName,
            "file_url": imageUrl,
            "extension": fileExtension,
            "document_type_id": 2,
            "created_by": createdBy,
            "external_key": response.data[0]['id'],
          })
          .select()
          .execute();

      await AppConfig()
          .supaBaseClient
          .from('tenants')
          .update({
            "image": docResponse.data[0]['id'],
          })
          .eq('id', response.data[0]['id'])
          .then((value) async {
            await fetchAllTenants().then((value) {
              print('MY DOCResponse == $docResponse');
              print('MY DOCID == ${docResponse.data[0]['id']}');
              //
              // Get.back();
              // Get.snackbar('Success', 'Added Company Tenant');
            });
          });

      if (isAddContactPerson.isFalse) {
        // fetchAllTenants();
        isAddTenantLoading(false);
        Get.back();
        Get.snackbar(
          'SUCCESS',
          'Tenant added to your list',
          titleText: Text(
            'SUCCESS',
            style: AppTheme.greenTitle1,
          ),
        );
      } else {
        await AppConfig()
            .supaBaseClient
            .from('tenant_profile_contacts')
            .insert({
          "tenant_id": data.data[0]['id'],
          "first_name": contactFirstName,
          "last_name": contactLastName,
          "nin": contactNin,
          "contact": contactPhone,
          "email": contactEmail,
          "designation": contactDesignation,
          "created_by": userStorage.read('userProfileId'),
        });
        isAddTenantLoading(false);
      }
    } catch (error) {
      print('Error adding tenant: $error');
      isAddTenantLoading(false);
    }
  }

  Future<void> addCompanyTenantWithoutContact(
      String name,
      int organisationId,
      int tenantTypeId,
      int businessTypeId,
      String createdBy,
      int nationId,
      String? description,
      Uint8List imageBytes,
      String fileExtension,
      String fileName) async {
    isAddTenantLoading(true);
    String uniqueId = uuid.v4();

    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .insert({
            "tenant_no": uniqueId,
            "business_type_id": businessTypeId,
            "name": name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by": createdBy,
            "description": description,
          })
          .select()
          .execute();

      final imagePath = '/${response.data[0]['id']}/profile';
      await AppConfig().supaBaseClient.storage.from('tenants').uploadBinary(
            imagePath,
            imageBytes,
            fileOptions:
                FileOptions(upsert: false, contentType: 'image/$fileExtension'),
          );

      String imageUrl = AppConfig()
          .supaBaseClient
          .storage
          .from('tenants')
          .getPublicUrl(imagePath);

      final docResponse = await AppConfig()
          .supaBaseClient
          .from('documents')
          .insert({
            "name": fileName,
            "file_url": imageUrl,
            "extension": fileExtension,
            "document_type_id": 2,
            "created_by": createdBy,
            "external_key": response.data[0]['id'],
          })
          .select()
          .execute();

      await AppConfig()
          .supaBaseClient
          .from('tenants')
          .update({
            "image": docResponse.data[0]['id'],
          })
          .eq('id', response.data[0]['id'])
          .then((value) async {
            await fetchAllTenants().then((value) {
              print('MY DOCResponse == $docResponse');
              print('MY DOCID == ${docResponse.data[0]['id']}');

              Get.back();
              Get.snackbar('Success', 'Added Company Without Contact Tenant');
            });
          });
      isAddTenantLoading(false);
    } catch (error) {
      print('Error adding tenant: $error');
      isAddTenantLoading(false);
    }
  }

  void listenToTenantChanges() {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('tenants')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllTenants();
    });
  }

  void listenToTenantPaymentChanges(int propertyId) {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('payments')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllTenantPayments(propertyId);
    });
  }

  Future<void> updateUnitStatusAvailable(UnitModel unitModel) async {
    try {
      await AppConfig()
          .supaBaseClient
          .from('units')
          .update({
            "is_available": 1,
          })
          .eq('id', unitModel.id)
          .then((value) {
            Fluttertoast.showToast(
                msg: '${unitModel.unitNumber} is now available',
                gravity: ToastGravity.TOP);
          });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addTenantToUnit(
      int tenantId,
      String createdBy,
      int unitId,
      String date1,
      String date2,
      int amount,
      int discount,
      List<Map<String, dynamic>> periodList,
      int propertyId) async {
    isAddTenantToUnitLoading(true);

    try {
      final response =
          await AppConfig().supaBaseClient.from('tenant_units').insert({
        "amount": amount,
        "discount": discount,
        "unit_id": unitId,
        // "organisation_id": organisationId,
        "tenant_id": tenantId,
        "created_by": createdBy,
        "from_date": date1,
        "to_date": date2,
        "property_id": propertyId
        // "updated_at" : DateTime.now(),
      }).then((tenant) async {
        await AppConfig()
            .supaBaseClient
            .from('units')
            .update({
              "is_available": 0,
            })
            .eq('id', unitId)
            .then((value) async {
              await Get.put(TenantController())
                  .fetchAllPropertiesSpecificOrganization()
                  .then((value) async {
                await addPaymentSchedule(periodList);
              });
            });

        // await addPaymentSchedule(periodList);

        // Get.back();
        // Get.snackbar('SUCCESS', 'Tenant added to unit',
        //   titleText: Text(
        //     'SUCCESS', style: AppTheme.greenTitle1,),
        // );
      });

      if (response.error != null) {
        isAddTenantToUnitLoading(false);
        throw response.error;
      }
    } catch (error) {
      isAddTenantToUnitLoading(false);
      print('Error adding tenant: $error');
    }
  }

  Future<void> updatePersonalTenantDetails(
      int individualTenantId,
      String? businessTypeId,
      String? name,
      String? nationId,
      String? description,
      String tenantNo,
      String? nin,
      String? phone,
      String? email,
      String? gender,
      String? dob) async {
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .update({
            "business_type_id": businessTypeId,
            "name": name,
            "nation_id": nationId,
            "description": description,
          })
          .eq('id', individualTenantId)
          .execute();

      final data = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select('id')
          .like('id', individualTenantId.toString())
          .execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig()
          .supaBaseClient
          .from('tenant_profiles')
          .update({
            "nin": nin,
            "contact": phone,
            "email": email,
            "description": description,
            "created_by": userStorage.read('userProfileId'),
            "gender": gender,
            "date_of_birth": dob,
          })
          .eq('tenant_id', individualTenantId.toString())
          .execute();
      // fetchAllTenants();
      Get.back();
      Get.snackbar('Success', 'Updated Individual Tenant');
    } catch (error) {
      print('Error updating Individual tenant: $error');
    }
  }

  Future<void> updateCompanyTenantDetailsWithContact(
    String name,
    int organisationId,
    int businessTypeId,
    String createdBy,
    int nationId,
    String? contactFirstName,
    String? contactLastName,
    String? contactNin,
    String? contactDesignation,
    String? contactPhone,
    String? contactEmail,
    String? description,
  ) async {
    try {
      final response = await AppConfig().supaBaseClient.from('tenants').update({
        "business_type_id": businessTypeId,
        "name": name,
        "nation_id": nationId,
        "tenant_type_id": tenantTypeId,
        "created_by": createdBy,
        "description": description,
      }).execute();

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

      final data = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select('id')
          .like('tenant_no', createdBy.toString())
          .execute();

      print(data);
      print(data.data[0]['id']);

      await AppConfig().supaBaseClient.from('tenant_profile_contacts').update({
        "first_name": contactFirstName,
        "last_name": contactLastName,
        "nin": contactNin,
        "contact": contactPhone,
        "email": contactEmail,
        "designation": contactDesignation,
        "created_by": userStorage.read('userProfileId'),
      });
      // fetchAllTenants();
      Fluttertoast.showToast(
          msg: 'Update Successful', gravity: ToastGravity.TOP);
      Get.back();
    } catch (error) {
      print('Error adding tenant: $error');
    }
  }

  Future<void> updateCompanyTenantDetailsWithoutContact() async {}

  getCompanyTenantContactProfile(int id) async {
    isContactDetailsLoading(true);

    try {
      // Fetch the specific row based on ID
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_profile_contacts')
          .select()
          .eq('tenant_id', id)
          .execute();
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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenant_profiles')
          .select()
          .eq('tenant_id', id)
          .execute();
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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', id)
          .execute();

      final businessTypeResponse = await AppConfig()
          .supaBaseClient
          .from('business_types')
          .select()
          .eq('id', response.data[0]['business_type_id'])
          .execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print(
          'Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', id)
          .execute();

      final businessTypeResponse = await AppConfig()
          .supaBaseClient
          .from('business_types')
          .select()
          .eq('id', response.data[0]['business_type_id'])
          .execute();

      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print(
          'Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', id)
          .execute();

      final countryTypeResponse = await AppConfig()
          .supaBaseClient
          .from('currency_symbol')
          .select()
          .eq('id', response.data[0]['nation_id'])
          .execute();

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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', id)
          .execute();

      final countryTypeResponse = await AppConfig()
          .supaBaseClient
          .from('currency_symbol')
          .select()
          .eq('id', response.data[0]['nation_id'])
          .execute();

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
      final response = await AppConfig()
          .supaBaseClient
          .from('tenants')
          .select()
          .eq('id', id)
          .execute();

      final businessTypeResponse = await AppConfig()
          .supaBaseClient
          .from('business_types')
          .select()
          .eq('id', response.data[0]['business_type_id'])
          .execute();
      // final data = await AppConfig().supaBaseClient.from('business_types')
      //     .select('id')
      //     .like('id', response.data[0]['business_type_id']).execute();

      print(businessTypeResponse.data);
      // print('Tenants TABLE RESPONSE == ${response.data}');
      print(
          'Tenants TABLE RESPONSE == ${businessTypeResponse.data[0]['name']}');
      print('Tenants TABLE row id == ${businessTypeResponse.data[0]['id']}');

      uCompanyBusinessType.value = businessTypeResponse.data[0]['name'];
      uCompanyBusinessTypeId.value = businessTypeResponse.data[0]['id'];
    } catch (e) {
      // isSpecificTenantLoading(false);
      print('Error: $e');
    }
  }

  addTenantPayment(
    int tenantId,
    int unitId,
    String date1,
    String date2,
    int amount,
    int paid,
    int balance,
    String createdBy,
    String updatedBy,
  ) async {
    try {
      final response =
          await AppConfig().supaBaseClient.from('payments').insert({
        "amount": amount,
        "paid": paid,
        "balance": balance,
        "unit_id": unitId,
        "from_date": date1,
        "to_date": date2,
        "tenant_id": tenantId,
        "created_by": createdBy,
        "updated_by": updatedBy,
      }).then((indTenant) {
        isPayForMultipleSchedulesLoading(false);
        Get.back();
        Get.snackbar(
          'SUCCESS',
          'Tenant payment added',
          titleText: Text(
            'SUCCESS',
            style: AppTheme.greenTitle1,
          ),
        );
      });

      if (response.error != null) {
        isPayForMultipleSchedulesLoading(false);
        throw response.error;
      }
    } catch (error) {
      isPayForMultipleSchedulesLoading(false);
      print('Error adding tenant payment: $error');
    }
  }

  void fetchAllTenantPayments(int propertyId) async {
    isTenantPaymentsLoading(true);

    try {
      // final response = await AppConfig().supaBaseClient.from('payments').select('*, units(*), tenants(*)').eq('units.property_id', propertyId).eq('tenants.organisation_id', userStorage.read('OrganizationId')).order('created_at');
      final response = await AppConfig()
          .supaBaseClient
          .from('payments')
          .select('*, units!inner(*), tenants!inner(*)')
          .eq('units.property_id', propertyId)
          .eq('tenants.organisation_id', userStorage.read('OrganizationId'))
          .order('created_at');
      final data = response as List<dynamic>;
      print(response);
      print('MY PROPERTY Payments RESPONSE ==$response');
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

  Map<K, List<V>> groupAllTenantPayments<K, V>(
      List<V> list, K Function(V) getKey) {
    final Map<K, List<V>> groupedData = {};
    for (final element in list) {
      final key = getKey(element);
      groupedData.putIfAbsent(key, () => []).add(element);
    }
    return groupedData;
  }

  callAllTenantsPaymentsFunction() async {
    print('Tenants Payments function response ==');

    var tenantPaymentResponse =
        await AppConfig().supaBaseClient.rpc('grouped_payments');
    // var response;
    // await AppConfig()
    //     .supaBaseClient
    //     .rpc('property_revenue', params: {"arg_id": propertyModel.organisationId})
    //     .then((value) => response = value[index])
    //     .onError((error, stackTrace) {
    //   print(error);
    //   print(stackTrace);
    // });

    print('Tenants Payments function response == is $tenantPaymentResponse');
    return tenantPaymentResponse;
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
      final response = await AppConfig()
          .supaBaseClient
          .from('payment_schedule')
          .insert(periodList)
          .then((indTenant) {
        isAddTenantToUnitLoading(false);
        Get.back();
        Get.snackbar(
          'SUCCESS',
          'Tenant Added',
          titleText: Text(
            'SUCCESS',
            style: AppTheme.greenTitle1,
          ),
        );
      });

      if (response.error != null) {
        isAddTenantToUnitLoading(false);
        throw response.error;
      }
    } catch (error) {
      isAddTenantToUnitLoading(false);
      print('Error adding payment schedule: $error');
    }
  }

  Future<void> fetchAllPropertiesSpecificOrganization() async {
    isPropertyModelListLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('properties')
          .select(
              'id, name, description, organisation_id, square_meters, property_type_id, category_type_id, location, main_image, documents!inner(*)')
          .eq('organisation_id', userStorage.read('OrganizationId'))
          .order('created_at');
      final data = response as List<dynamic>;
      print('my Properties are $response');
      print(response.length);
      print(data.length);
      print(data);
      isPropertyModelListLoading(false);

      return propertyModelList
          .assignAll(data.map((json) => PropertyModel.fromJson(json)).toList());
    } on PostgrestException catch (error) {
      print('Error fetching Specific Organization Properties: $error');
      print(
          'Error fetching Specific Organization Properties details: ${error.details}');
      isPropertyModelListLoading(false);
    }
  }

  void listenToPropertyModelListChanges() {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('properties')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllPropertiesSpecificOrganization();
    });
  }

  fetchAllSpecificUserProperties(String userId) async {
    isSpecificUserPropertyListLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('properties')
          .select(
              'id, name, description, organisation_id, square_meters, property_type_id, category_type_id, location, main_image')
          .eq('organisation_id', userStorage.read('OrganizationId'));
      final data = response as List<dynamic>;
      print('my Specific User Properties are $response');
      print(response.length);
      print(data.length);
      print(data);
      isSpecificUserPropertyListLoading(false);

      return specificUserPropertyModelList
          .assignAll(data.map((json) => PropertyModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching Specific Organization Properties: $error');
      isSpecificUserPropertyListLoading(false);
    }
  }

  void listenToSpecificUserPropertyListChanges(String userId) {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('properties')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllSpecificUserProperties(userId);
    });
  }
}

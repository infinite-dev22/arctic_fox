import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/currency/currency_model.dart';
import 'package:smart_rent/models/floor/floor_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/models/unit/unit_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';

class UnitController extends GetxController {

  RxList<UnitTypeModel> unitTypeList = <UnitTypeModel>[].obs;
  RxList<FloorModel> floorList = <FloorModel>[].obs;
  RxList<PaymentScheduleModel> paymentList = <PaymentScheduleModel>[].obs;
  RxList<CurrencyModel> currencyList = <CurrencyModel>[].obs;
  RxList<UnitModel> roomList = <UnitModel>[].obs;

  var unitTypeId = 0.obs;
  var paymentScheduleId = 0.obs;
  var floorId = 0.obs;
  var currencyId = 0.obs;
  var isUnitLoading = false.obs;
  var isUpdateStatusLoading = false.obs;
  var isAddFloorLoading = false.obs;
  var isAddUnitLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllUnitTypes();
    // fetchAllFloors();
    fetchAllPayments();
    fetchAllCurrencies();
    // fetchAllPropertyUnits();
    // listenToUnitChanges();
  }

  setUnitTypeId(int id){
    unitTypeId.value = id;
    print('New Unit Type Id is $id');
  }

  setPaymentScheduleId(int id){
    paymentScheduleId.value = id;
    print('New Payment Schedule Id is $id');
  }

  setFloorId(int id){
    floorId.value = id;
    print('New Floor Id is $id');
  }

  setCurrencyId(int id){
    currencyId.value = id;
    print('New Currency is $id');
  }



  fetchAllUnitTypes() async {

    try {

      final response = await AppConfig().supaBaseClient.from('unit_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return unitTypeList.assignAll(
          data.map((json) => UnitTypeModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching unit types: $error');
    }

  }

  Future<void> addFloorToProperty(int propertyId, String name, String description) async {
    isAddFloorLoading(true);

    try {
      final response = await AppConfig().supaBaseClient.from('floors').insert([
        {
          "property_id" : propertyId,
          "name" : name,
          "description" : description,
          "created_by" : userStorage.read('userProfileId'),

        }
      ]).then((property) {
        isAddFloorLoading(false);
        Get.back();
        Get.snackbar('SUCCESS', 'Floor added successfully',
          titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        isAddFloorLoading(false);
        throw response.error;
      }

    } catch (error) {
      print('Error adding floor to property : $error');
      isAddFloorLoading(false);
    }


  }


  fetchAllFloors(int propertyId) async {

    try {

      final response = await AppConfig().supaBaseClient.from('floors').select().eq('property_id', propertyId);
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return floorList.assignAll(
          data.map((json) => FloorModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching floors: $error');
    }

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

  fetchAllCurrencies() async {

    try {

      final response = await AppConfig().supaBaseClient.from('currency_symbol').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return currencyList.assignAll(
          data.map((json) => CurrencyModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching currencies: $error');
    }

  }


  Future<void> addUnit(int floorId, int currencyId,
      int unitTypeId, int periodId, String squareMeters,
      String createdBy, int unitNumber, int amount, String description, int propertyId
      ) async {
    isAddUnitLoading(true);
    try {
      final response =  await AppConfig().supaBaseClient.from('units').insert(
          {
            "unit_type" : unitTypeId,
            "description": description,
            "period_id": periodId,
            "floor_id": floorId,
            "currency_id": currencyId,
            "unit_number": unitNumber,
            "sq_meters" : squareMeters,
            "amount" : amount,
            "created_by" : createdBy,
            "property_id" : propertyId,
            // "updated_by" : updatedBy,
          }
      ).then((property) {
        isAddUnitLoading(false);
        Get.back();
        Get.snackbar('SUCCESS', 'Property added to your list',
          titleText: Text('SUCCESS', style: AppTheme.greenTitle1,),
        );
      });

      if (response.error != null) {
        isAddUnitLoading(false);
        throw response.error;
      }

    } catch (error) {
      isAddUnitLoading(false);
      print('Error adding property: $error');
    }


  }

  void fetchAllPropertyUnits(int propertyId) async {
    isUnitLoading(true);
    try {

      final response = await AppConfig().supaBaseClient.from('units').select()
          .eq('property_id', propertyId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('MY property units are == $response');
      print(response.length);
      print(data.length);
      print(data);
      isUnitLoading(false);

      return roomList.assignAll(
          data.map((json) => UnitModel.fromJson(json)).toList());


    } catch (error) {
      print('Error fetching Units: $error');
      isUnitLoading(false);
    }

    print('I HAVE ${roomList.length} ROOMS');

  }


  void listenToUnitChanges(int propertyId) {
    // Set up real-time listener
    AppConfig().supaBaseClient
        .from('units')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
     fetchAllPropertyUnits(propertyId);
    });

  }

  deleteUnit(int id) async{

    await AppConfig().supaBaseClient
        .from('units')
        .delete()
        .match({ 'id': id });
    // fetchAllPropertyUnits();
  }

  Future<void> updateUnitStatusAvailable(UnitModel unitModel)async{
    isUpdateStatusLoading(true);
    try{
      await AppConfig().supaBaseClient.from('units').update(
          {
            "is_available" : 1,
          }
      ).eq('id', unitModel.id).then((value) {
        isUpdateStatusLoading(false);
        Get.back();
        Fluttertoast.showToast(msg: '${unitModel.unitNumber} is now available', gravity: ToastGravity.TOP);
      });
    } catch(error){
      isUpdateStatusLoading(false);
      print(error);
    }
  }


}
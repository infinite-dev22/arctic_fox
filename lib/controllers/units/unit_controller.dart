import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/currency/currency_model.dart';
import 'package:smart_rent/models/floor/floor_model.dart';
import 'package:smart_rent/models/payment_schedule/payment_schedule_model.dart';
import 'package:smart_rent/models/property/property_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/models/unit/unit_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:smart_rent/utils/app_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  var specificPropertyTotal = 0.obs;
  var specificPropertiesAvailable = 0.obs;
  var specificPropertiesOccupied = 0.obs;
  var specificPropertyRevenue = 0.obs;

  int? availableCount;
  int? occupiedCount;
  int? totalUnitsCount;
  int? revenueCount;
  double? availablePercentage;
  double? occupiedPercentage;

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

  setSpecificPropertyTotal(int total) {
    specificPropertyTotal.value = total;
    print('New total is $total');
  }

  setSpecificPropertyRevenue(int revenue) {
    specificPropertyRevenue.value = revenue;
    print('New total revenue is $revenue');
  }

  setSpecificPropertiesAvailable(int available) {
    specificPropertiesAvailable.value = available;
    print('New available is $available');
  }

  setSpecificPropertiesOccupied(int occupied) {
    specificPropertiesOccupied.value = occupied;
    print('New occupied is $occupied');
  }

  setUnitTypeId(int id) {
    unitTypeId.value = id;
    print('New Unit Type Id is $id');
  }

  setPaymentScheduleId(int id) {
    paymentScheduleId.value = id;
    print('New Payment Schedule Id is $id');
  }

  setFloorId(int id) {
    floorId.value = id;
    print('New Floor Id is $id');
  }

  setCurrencyId(int id) {
    currencyId.value = id;
    print('New Currency is $id');
  }

  fetchAllUnitTypes() async {
    try {
      final response =
          await AppConfig().supaBaseClient.from('unit_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return unitTypeList
          .assignAll(data.map((json) => UnitTypeModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching unit types: $error');
    }
  }

  Future<void> addFloorToProperty(
      int propertyId, String name, String description) async {
    isAddFloorLoading(true);

    try {
      final response = await AppConfig().supaBaseClient.from('floors').insert([
        {
          "property_id": propertyId,
          "name": name,
          "description": description,
          "created_by": userStorage.read('userProfileId'),
        }
      ]).then((property) {
        isAddFloorLoading(false);
        Get.back();
        Get.snackbar(
          'SUCCESS',
          'Floor added successfully',
          titleText: Text(
            'SUCCESS',
            style: AppTheme.greenTitle1,
          ),
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
      final response = await AppConfig()
          .supaBaseClient
          .from('floors')
          .select()
          .eq('property_id', propertyId);
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return floorList
          .assignAll(data.map((json) => FloorModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching floors: $error');
    }
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

  fetchAllCurrencies() async {
    try {
      final response =
          await AppConfig().supaBaseClient.from('currency_symbol').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return currencyList
          .assignAll(data.map((json) => CurrencyModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching currencies: $error');
    }
  }

  Future<void> addUnit(
      int floorId,
      int currencyId,
      int unitTypeId,
      int periodId,
      String squareMeters,
      String createdBy,
      int unitNumber,
      int amount,
      String description,
      int propertyId) async {
    isAddUnitLoading(true);
    try {
      final response = await AppConfig().supaBaseClient.from('units').insert({
        "unit_type": unitTypeId,
        "description": description,
        "period_id": periodId,
        "floor_id": floorId,
        "currency_id": currencyId,
        "unit_number": unitNumber,
        "sq_meters": squareMeters,
        "amount": amount,
        "created_by": createdBy,
        "property_id": propertyId,
        // "updated_by" : updatedBy,
      }).then((property) async {
        await Get.put(TenantController())
            .fetchOnlyAvailableUnits(propertyId)
            .then((value) async {
          await Get.put(TenantController())
              .fetchAllPropertiesSpecificOrganization()
              .then((value) async {
            isAddUnitLoading(false);
            Get.back();
            Get.snackbar(
              'SUCCESS',
              'Property added to your list',
              titleText: Text(
                'SUCCESS',
                style: AppTheme.greenTitle1,
              ),
            );
          });
        });
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

  countPropertyTotalUnits(PropertyModel propertyModel) async {
    final response = await AppConfig()
        .supaBaseClient
        .from('units')
        .select()
        .eq('property_id', propertyModel.id)
        .execute();

    print(response);
    print(response);

    // int rowCount = data.length;
    totalUnitsCount = response.data.length;
    print('MY property units count is == ${specificPropertyTotal.value}');
    print('MY property units response is == ${response.data}');
    print('MY property units length is == ${response.data.length}');

    return totalUnitsCount;
  }

  countPropertyAvailableUnits(PropertyModel propertyModel) async {
    final response = await AppConfig()
        .supaBaseClient
        .from('units')
        .select()
        .eq('is_available', true)
        .eq('property_id', propertyModel.id);

    final data = response as List<dynamic>;
    print(response);
    print(response);
    print(data.length);
    print(data);

    setSpecificPropertiesAvailable(data.length);

    // int rowCount = data.length;
    availableCount = data.length;
    print(
        'MY property available units count is == ${specificPropertiesAvailable.value}');

    return availableCount;
  }

  countPropertyAvailableUnitsPercentage(PropertyModel propertyModel) async {
    final response = await AppConfig()
        .supaBaseClient
        .from('units')
        .select()
        .eq('is_available', true)
        .eq('property_id', propertyModel.id);

    final data = response as List<dynamic>;
    print(response);
    print(data.length);
    print(data);

    setSpecificPropertiesAvailable(data.length);

    double available = availableCount!.toDouble();
    double total = totalUnitsCount!.toDouble();

    // Calculate percentage
    double availablePercentage = (available / total) * 100;

    // Round off to two decimal places
    double roundedAvailable =
        double.parse(availablePercentage.toStringAsFixed(2));

    // Print the result
    print('The result as a percentage: $roundedAvailable%');

    int rowCount = data.length;
    print(
        'MY property available units count is == ${specificPropertiesAvailable.value}');

    return roundedAvailable;
  }

  countPropertyOccupiedUnits(PropertyModel propertyModel) async {
    final response = await AppConfig()
        .supaBaseClient
        .from('units')
        .select()
        .eq('is_available', false)
        .eq('property_id', propertyModel.id);

    final data = response as List<dynamic>;
    print(response);
    print(response);
    print(data.length);
    print(data);

    setSpecificPropertiesAvailable(data.length);

    // int rowCount = data.length;
    occupiedCount = data.length;
    print(
        'MY property occupied units count is == ${specificPropertiesOccupied.value}');

    return occupiedCount;
  }

  countPropertyRevenue(PropertyModel propertyModel, int index) async {
    print('Functions response ==');
    var response;
    await AppConfig()
        .supaBaseClient
        .rpc('property_revenue', params: {"arg_id": propertyModel.organisationId})
        .then((value) => response = value[index])
        .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });

    print('Functions response == is $response');


    // final response = await AppConfig().supaBaseClient.from('tenant_units').select('discount').eq('property_id', propertyModel.id);
    //
    // final data = response as List<dynamic>;
    // print(response);
    // print(response);
    // print(data.length);
    // print(data);
    // print('new revenue == $data');
    // print('new revenue == ${data[0]}');
    // print('new discount == ${data[0]['discount']}');
    // // double sum = data[0]['discount'].fold(0, (previous, current) => previous + (current ?? 0));
    //
    // int calculatedSum = 0;
    // for (var property in data) {
    //   // Assuming the column contains integer values
    //   calculatedSum += property['discount'] as int;
    // }
    //
    //
    // print('new calculated Sum == $calculatedSum');
    //
    // // // Extract the values from the response
    // // List<dynamic> discountValues = data[0]['discount'];
    // //
    // // // Calculate the sum using the fold method
    // // double sum = discountValues.fold(0, (previous, current) => previous + (current ?? 0));
    // //
    // // int rowSum = sum.toInt();
    // // setSpecificPropertiesAvailable(rowSum);
    // //
    // //
    // // print('MY property revenue count is == ${rowSum}');
    // // print('MY property revenue count is == ${specificPropertyRevenue.value}');
    //



    return response;
  }

  Future<void> fetchAllPropertyUnits(int propertyId) async {
    isUnitLoading(true);
    try {
      final response = await AppConfig()
          .supaBaseClient
          .from('units')
          .select()
          .eq('property_id', propertyId)
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      print('MY property units are == $response');
      print(response.length);
      print(data.length);
      print(data);
      isUnitLoading(false);

      return roomList
          .assignAll(data.map((json) => UnitModel.fromJson(json)).toList());
    } catch (error) {
      print('Error fetching Units: $error');
      isUnitLoading(false);
    }

    print('I HAVE ${roomList.length} ROOMS');
  }

  void listenToUnitChanges(int propertyId) {
    // Set up real-time listener
    AppConfig()
        .supaBaseClient
        .from('units')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      fetchAllPropertyUnits(propertyId);
    });
  }

  deleteUnit(int id) async {
    await AppConfig().supaBaseClient.from('units').delete().match({'id': id});
    // fetchAllPropertyUnits();
  }

  Future<void> updateUnitStatusAvailable(
      UnitModel unitModel, int propertyId) async {
    isUpdateStatusLoading(true);
    try {
      await AppConfig()
          .supaBaseClient
          .from('units')
          .update({
            "is_available": 1,
          })
          .eq('id', unitModel.id)
          .then((value) async {
            await Get.put(TenantController())
                .fetchOnlyAvailableUnits(propertyId)
                .then((value) {
              isUpdateStatusLoading(false);
              Get.back();
              Fluttertoast.showToast(
                  msg: '${unitModel.unitNumber} is now available',
                  gravity: ToastGravity.TOP);
            });
          });
    } catch (error) {
      isUpdateStatusLoading(false);
      print(error);
    }
  }
}

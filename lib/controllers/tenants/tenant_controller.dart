import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/nationality/nationality_model.dart';
import 'package:smart_rent/models/salutation/salutation_model.dart';
import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';
import 'package:smart_rent/styles/app_theme.dart';

class TenantController extends GetxController {

  RxList<NationalityModel> nationalityList = <NationalityModel>[].obs;
  RxList<SalutationModel> salutationList = <SalutationModel>[].obs;
  RxList<TenantTypeModel> tenantTypeList = <TenantTypeModel>[].obs;
  RxList<UnitModel> unitList = <UnitModel>[].obs;
  RxList<TenantModel> tenantList = <TenantModel>[].obs;

  var nationalityId = 0.obs;
  var tenantTypeId = 0.obs;
  var unitId = 0.obs;
  var tenantId = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllTenantTypes();
    fetchAllNationalities();
    fetchAllSalutations();
    fetchAllTenants();
    fetchAllUnits();

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

    try {

      final response = await AppConfig().supaBaseClient.from('tenants').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return tenantList.assignAll(
          data.map((json) => TenantModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching Tenants: $error');
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


  addTenant(String name, int organisationId, int tenantTypeId, String createdBy,
      int nationId,
      ) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('tenants').insert(
          {
            "name" : name,
            "nation_id": nationId,
            "organisation_id": organisationId,
            "tenant_type_id": tenantTypeId,
            "created_by" : createdBy,
          }
      ).then((property) {
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
      ).then((property) {
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

}
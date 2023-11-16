import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';

class PropertyController extends GetxController {

  RxList<PropertyTypeModel> propertyTypeList = <PropertyTypeModel>[].obs;
  RxList<PropertyCategoryModel> propertyCategoryList = <PropertyCategoryModel>[].obs;

  var propertyTypeId = 0.obs;
  var categoryId = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   fetchAllPropertyCategories();
   fetchAllPropertyTypes();
    print(propertyTypeList);
  }

  setPropertyTypeId(int id){
    propertyTypeId.value = id;
    print('New Property Type Id is $id');
  }

  setCategoryId(int id){
    categoryId.value = id;
    print('New Category Id is $id');
  }


  void fetchAllPropertyCategories() async {

    try {

      final response = await AppConfig().supaBaseClient.from('property_categories').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return propertyCategoryList.assignAll(
          data.map((json) => PropertyCategoryModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching categories: $error');
    }


  }

  void fetchAllPropertyTypes() async {

    try {
      final response = await AppConfig().supaBaseClient.from('property_types').select();
      final data = response as List<dynamic>;
      print(response);
      print(response.length);
      print(data.length);
      print(data);

      return propertyTypeList.assignAll(
          data.map((json) => PropertyTypeModel.fromJson(json)).toList());

    } catch (error) {
      print('Error fetching property types: $error');
    }



  }

  addProperty(String name, String description, int organisationId, int propertyTypeId,
      categoryTypeId, String location, String squareMeters,
      String createdBy, String updatedBy
      ) async {

    try {
      final response =  await AppConfig().supaBaseClient.from('properties').insert(
          {
            "name" : name,
            "description": description,
            "organisation_id": organisationId,
            "property_type_id": propertyTypeId,
            "category_type_id": categoryTypeId,
            "location": location,
            "square_meters" : squareMeters,
            "created_by" : createdBy,
            "updated_by" : updatedBy,
          }
      ).then((property) {
        Get.back();
        Get.snackbar('SUCCESS', 'Property added to your list',
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

}
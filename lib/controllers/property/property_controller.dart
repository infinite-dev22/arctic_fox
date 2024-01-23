import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/controllers/tenants/tenant_controller.dart';
import 'package:smart_rent/models/property/property_category_model.dart';
import 'package:smart_rent/models/property/property_type_model.dart';
import 'package:smart_rent/styles/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyController extends GetxController {

  RxList<PropertyTypeModel> propertyTypeList = <PropertyTypeModel>[].obs;
  RxList<PropertyCategoryModel> propertyCategoryList = <PropertyCategoryModel>[].obs;

  var propertyTypeId = 0.obs;
  var categoryId = 0.obs;
  var isAddPropertyLoading = false.obs;

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

  Future<void> addProperty(String name, String description, int organisationId, int propertyTypeId,
      categoryTypeId, String location, String squareMeters,
      String createdBy, String updatedBy, Uint8List imageBytes, String fileExtension, String fileName
      ) async {

    isAddPropertyLoading(true);
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
            "main_image" : null,
          }
      ).select().execute();


      final imagePath = '/${response.data[0]['id']}/property';
      await AppConfig().supaBaseClient.storage.from('properties').uploadBinary(
        imagePath,
        imageBytes,
        fileOptions: FileOptions(upsert: false, contentType: 'image/$fileExtension'),
      );

      String imageUrl = AppConfig().supaBaseClient.storage.from('properties').getPublicUrl(imagePath);

      final docResponse =  await AppConfig().supaBaseClient.from('documents').insert(
          {
            "name" : fileName,
            "file_url": imageUrl,
            "extension": fileExtension,
            "document_type_id": 3,
            "created_by" : createdBy,
            "external_key" : response.data[0]['id'],
          }
      ).select().execute();

      await AppConfig().supaBaseClient.from('properties').update(
          {
            "main_image" : docResponse.data[0]['id'],
          }
      ).eq('id', response.data[0]['id']).then((value) async{
        await AppConfig().supaBaseClient.from('property_units').insert(
            {
              "property_id" : response.data[0]['id'],
              "total_units": 0,
              "available": 0,
              "occupied": 0,
              "created_by" : createdBy,
              "revenue" : 0,
            }
        ).then((value) {
          print('MY DOCResponse == $docResponse');
          print('MY DOCID == ${docResponse.data[0]['id']}');

          Get.back();
          Get.snackbar('Success', 'Added Property to your list');
          isAddPropertyLoading(false);
        });

      });



    } catch (error) {
      isAddPropertyLoading(false);
      print('Error adding property: $error');
    }


  }

}
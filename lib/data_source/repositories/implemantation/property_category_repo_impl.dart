import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/property/property_category_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/property_category_repo.dart';

class PropertyCategoryRepoImpl implements PropertyCategoryRepo {
  @override
  Future<List<PropertyCategoryModel>> getALlPropertyCategories(
      String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/propertycategories');

      var response = await client.get(url, headers: headers);
      List categoryData = jsonDecode(response.body);
      if (kDebugMode) {
        print("property categories RESPONSE: $response");
      }
      return categoryData
          .map((employee) => PropertyCategoryModel.fromJson(employee))
          .toList();
    } finally {
      client.close();
    }
  }
}

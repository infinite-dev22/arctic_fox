import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/property/property_category_model.dart';
import 'package:smart_rent/data_source/models/property/property_types_model.dart';

import 'package:smart_rent/data_source/repositories/interfaces/property_type_repo.dart';


class PropertyTypeRepoImpl implements PropertyTypeRepo {

  @override
  Future<List<PropertyTypeModel>> getALlPropertyTypes(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/propertytypes');


      var response = await client.get(url, headers: headers);
      List typesData = jsonDecode(response.body);
      if (kDebugMode) {
        print("property types RESPONSE: $response");
      }
      return typesData.map((employee) => PropertyTypeModel.fromJson(employee)).toList();
    } finally {
      client.close();
    }

  }


}

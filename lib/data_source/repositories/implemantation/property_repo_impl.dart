import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/employee/employee_list_response_model.dart';
import 'package:smart_rent/data_source/models/property/property_response_model.dart';
import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/interfaces/employee_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/property_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_repo.dart';

class PropertyRepoImpl implements PropertyRepo {
  @override

  @override
  Future<List<Property>> getALlProperties(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/properties');


      var response = await client.get(url, headers: headers);
      List propertyData = jsonDecode(response.body)['clients'];
      if (kDebugMode) {
        print("property RESPONSE: $response");
      }
      return propertyData.map((property) => Property.fromJson(property)).toList();
    } finally {
      client.close();
    }

  }


  @override
  Future<Property> getSingleProperty(int id, String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/properties/show/$id');

      var response = await client.get(url, headers: headers);

      if (kDebugMode) {
        print("Property DETAILS RESPONSE: $response");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Property.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load property details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load property details');
    } finally {
      client.close();
    }
  }


}

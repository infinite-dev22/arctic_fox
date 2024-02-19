import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/employee/employee_list_response_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_details_model.dart';
import 'package:smart_rent/data_source/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/interfaces/employee_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/tenant_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_repo.dart';

class TenantRepoImpl implements TenantRepo {

  @override
  Future<List<TenantModel>> getALlTenants(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/crm/clients');


      var response = await client.get(url, headers: headers);
      List tenantData = jsonDecode(response.body)['clients'];
      if (kDebugMode) {
        print("tenants RESPONSE: $response");
      }
      return tenantData.map((employee) => TenantModel.fromJson(employee)).toList();
    } finally {
      client.close();
    }

  }


  @override
  Future<TenantDetailsModel> getSingleTenant(String token, int id, ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/crm/clients/$id');

      var response = await client.get(url, headers: headers);

      if (kDebugMode) {
        print("Tenant DETAILS RESPONSE: $response");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return TenantDetailsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load tenant details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load tenant details');
    } finally {
      client.close();
    }
  }


}


import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_source/models/unit/unit_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/tenant_unit_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/unit_repo.dart';

class TenantUnitRepoImpl implements TenantUnitRepo {

  @override
  Future<List<TenantUnitModel>> getALlTenantUnits(String token, int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/tenantunitsonproperty/$id');


      var response = await client.get(url, headers: headers);
      List tenantUnitData = jsonDecode(response.body)['tenantunitsonproperty'];
      if (kDebugMode) {
        print("tenant unit RESPONSE: $response");
      }
      return tenantUnitData.map((tenantUnit) => TenantUnitModel.fromJson(tenantUnit)).toList();
    } finally {
      client.close();
    }

  }

}
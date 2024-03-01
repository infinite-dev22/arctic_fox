import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/unit/unit_model.dart';
import 'package:smart_rent/data_source/models/unit/unit_type_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/unit_repo.dart';

class UnitRepoImpl implements UnitRepo {
  @override
  Future<List<UnitModel>> getALlUnits(String token, int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/unitsonproperty/$id');

      var response = await client.get(url, headers: headers);
      List unitData = jsonDecode(response.body)['units'];
      if (kDebugMode) {
        print("unit RESPONSE: $response");
      }
      return unitData.map((unit) => UnitModel.fromJson(unit)).toList();
    } finally {
      client.close();
    }
  }

  @override
  Future<List<UnitTypeModel>> getUnitTypes(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/unittypes');

      var response = await client.get(url, headers: headers);
      List unitTypeData = jsonDecode(response.body);
      if (kDebugMode) {
        print("unit types RESPONSE: $response");
      }
      return unitTypeData.map((unit) => UnitTypeModel.fromJson(unit)).toList();
    } finally {
      client.close();
    }
  }

  @override
  Future<dynamic> addUnitToProperty(String token, int unitTypeId, int floorId, String name, String sqm,
      int periodId, int currencyId, int initialAmount, String description, int propertyId) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/units/store');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          "name": name,
          "number": 1,
          "amount": initialAmount,
          "floor_id": floorId,
          "schedule_id": periodId,
          "property_id": propertyId,
          "currency_id": currencyId,
          "square_meters": sqm,
          "unit_type": unitTypeId,
          "description": description,
        }),
      );

      if (kDebugMode) {
        print("Add Unit RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('Unit Addition response body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

}

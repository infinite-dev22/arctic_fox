
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/models/unit/unit_model.dart';
import 'package:smart_rent/data_source/models/unit/unit_type_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';
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
      List unitData = jsonDecode(response.body);
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

}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/models/role/role_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/role_repo.dart';

class RoleRepoImpl implements RoleRepo {

  @override
  Future<List<RoleModel>> getRoles(String token,) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/admin/roles');


      var response = await client.get(url, headers: headers);
      List roleData = jsonDecode(response.body);
      if (kDebugMode) {
        print("roles RESPONSE: $response");
      }
      return roleData.map((floor) => RoleModel.fromJson(floor)).toList();
    } finally {
      client.close();
    }

  }





}
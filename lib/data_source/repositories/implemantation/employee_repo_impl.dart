import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/employee/employee_list_response_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/employee_repo.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  @override
  Future<List<EmployeeModel>> getALlEmployees(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/admin/users');

      var response = await client.get(url, headers: headers);
      List employeeData = jsonDecode(response.body);
      if (kDebugMode) {
        print("employee RESPONSE: $response");
      }
      return employeeData
          .map((employee) => EmployeeModel.fromJson(employee))
          .toList();
    } finally {
      client.close();
    }
  }
}

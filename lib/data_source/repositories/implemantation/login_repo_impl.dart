import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/repositories/interfaces/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<dynamic> post(String email, String password) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/login');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (kDebugMode) {
        print("LOGIN RESPONSE: $response");
      }
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

}

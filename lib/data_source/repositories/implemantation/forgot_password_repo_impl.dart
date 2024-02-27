
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/forgot_password_repo.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {


  @override
  Future<dynamic> forgotPasswordSendLink(String email, String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/password/$email');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          'email': email,
        }),
      );

      if (kDebugMode) {
        print("Forgot Password RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('Forgot Password body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

}
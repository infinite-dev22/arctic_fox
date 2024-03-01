import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/data_source/models/user_response/user_response.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_repo.dart';

class UserRepoImpl implements UserRepo {
  @override
  @override
  Future<List<UserResponse>> getALl() async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      };

      var url = Uri.parse('https://reqres.in/api/users?page=2');

      var response = await client.get(url);
      print('MY Response $response');
      List userData = jsonDecode(response.body)['data'];
      // List userData =  jsonDecode(response.toString())['data'];
      if (kDebugMode) {
        print("Users RESPONSE: $response");
      }
      return userData.map((user) => UserResponse.fromJson(user)).toList();
    }
    /* catch (e) {
      print(e);
    }*/
    finally {
      client.close();
    }
  }
}

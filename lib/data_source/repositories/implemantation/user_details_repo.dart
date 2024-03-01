import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/data_source/models/user_details_response/user_details_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/user_details_repo.dart';

class UserDetailsRepoImpl implements UserDetailsRepo {
  @override
  Future<UserDetailsModel> getUserDetails(int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      };

      var url = Uri.parse('https://reqres.in/api/unknown/$id');

      var response = await client.get(url, headers: headers);

      if (kDebugMode) {
        print("USER DETAILS RESPONSE: $response");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return UserDetailsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load user details');
    } finally {
      client.close();
    }
  }

// Future<UserDetailsModel> getUserDetails(id) async {
//   var client = RetryClient(http.Client());
//   try {
//     var headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//       HttpHeaders.acceptHeader: 'application/json'
//     };
//
//   var url = Uri.parse('https://reqres.in/api/unknown/$id');
//
//     var response = await client.post(url);
//
//     if (kDebugMode) {
//       print("LOGIN RESPONSE: $response");
//     }
//     return ;
//   } catch (e) {
//     print(e);
//   } finally {
//     client.close();
//   }
// }
}

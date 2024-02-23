
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/nation_repo.dart';

class NationRepoImpl implements NationRepo {

  @override
  Future<List<NationModel>> getALlNations(String token,) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/main/nations');


      var response = await client.get(url, headers: headers);
      List nationData = jsonDecode(response.body);
      if (kDebugMode) {
        print("nations RESPONSE: $response");
      }
      return nationData.map((nation) => NationModel.fromJson(nation)).toList();
    } finally {
      client.close();
    }

  }



}
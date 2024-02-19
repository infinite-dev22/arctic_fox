
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/floor/floor_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/floor_repo.dart';

class FloorRepoImpl implements FloorRepo {

  @override
  Future<List<FloorModel>> getALlFloors(String token, int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/floorsonproperty/$id');


      var response = await client.get(url, headers: headers);
      List floorData = jsonDecode(response.body)['floorsonproperty'];
      if (kDebugMode) {
        print("floor RESPONSE: $response");
      }
      return floorData.map((floor) => FloorModel.fromJson(floor)).toList();
    } finally {
      client.close();
    }

  }

}
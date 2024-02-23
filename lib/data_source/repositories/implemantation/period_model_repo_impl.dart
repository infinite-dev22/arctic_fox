
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/currency/currency_model.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/models/period/period_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/currency_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/nation_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/period_repo.dart';

class PeriodRepoImpl implements PeriodRepo {

  @override
  Future<List<PeriodModel>> getAllPeriods(String token,) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/rent/periods');


      var response = await client.get(url, headers: headers);
      List periodData = jsonDecode(response.body);
      if (kDebugMode) {
        print("periods RESPONSE: $response");
      }
      return periodData.map((period) => PeriodModel.fromJson(period)).toList();
    } finally {
      client.close();
    }

  }



}
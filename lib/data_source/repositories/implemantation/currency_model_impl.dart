
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/config/app_config.dart';
import 'package:smart_rent/data_source/models/currency/currency_model.dart';
import 'package:smart_rent/data_source/models/nation/nation_model.dart';
import 'package:smart_rent/data_source/repositories/interfaces/currency_repo.dart';
import 'package:smart_rent/data_source/repositories/interfaces/nation_repo.dart';

class CurrencyRepoImpl implements CurrencyRepo {

  @override
  Future<List<CurrencyModel>> getAllCurrencies(String token,) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('${AppConfig().baseUrl}api/account/currencies');


      var response = await client.get(url, headers: headers);
      List currencyData = jsonDecode(response.body);
      if (kDebugMode) {
        print("currencies RESPONSE: $response");
      }
      return currencyData.map((nation) => CurrencyModel.fromJson(nation)).toList();
    } finally {
      client.close();
    }

  }



}
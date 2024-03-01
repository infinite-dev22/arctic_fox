// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

CurrencyModel currencyModelFromJson(String str) =>
    CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel extends SmartCurrencyModel {
  int id;
  String currency;

  CurrencyModel({
    required this.id,
    required this.currency,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        id: json["id"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
      };

  @override
  String getCurrency() {
    return currency;
  }

  @override
  int getId() {
    return id;
  }
}

// To parse this JSON data, do
//
//     final nationalityModel = nationalityModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

NationalityModel nationalityModelFromJson(String str) =>
    NationalityModel.fromJson(json.decode(str));

String nationalityModelToJson(NationalityModel data) =>
    json.encode(data.toJson());

class NationalityModel extends SmartNationalityModel {
  int? id;
  String? country;
  String? currency;
  String? code;
  String? symbol;

  NationalityModel({
    required this.id,
    required this.country,
    required this.currency,
    required this.code,
    required this.symbol,
  });

  factory NationalityModel.fromJson(Map<String, dynamic> json) =>
      NationalityModel(
        id: json["id"],
        country: json["country"],
        currency: json["currency"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "currency": currency,
        "code": code,
        "symbol": symbol,
      };

  @override
  String getCountry() {
    return country!;
  }

  @override
  int getId() {
    return id!;
  }

// @override
// String getCode() { return code;
// }
//
// @override
// String getCurrency() { return currency;
// }
//
//
// @override
// String getSymbol() { return symbol;
// }
}

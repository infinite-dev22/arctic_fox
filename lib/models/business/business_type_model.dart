// To parse this JSON data, do
//
//     final businessTypeModel = businessTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

BusinessTypeModel businessTypeModelFromJson(String str) =>
    BusinessTypeModel.fromJson(json.decode(str));

String businessTypeModelToJson(BusinessTypeModel data) =>
    json.encode(data.toJson());

class BusinessTypeModel extends SmartModel {
  int? id;
  String name;

  BusinessTypeModel({
    required this.id,
    required this.name,
  });

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) =>
      BusinessTypeModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  int getId() {
    return id!;
  }

  @override
  String getName() {
    return name;
  }
}

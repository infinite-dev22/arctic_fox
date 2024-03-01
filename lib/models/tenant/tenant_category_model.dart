// To parse this JSON data, do
//
//     final tenantCategoryModel = tenantCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

TenantCategoryModel tenantCategoryModelFromJson(String str) =>
    TenantCategoryModel.fromJson(json.decode(str));

String tenantCategoryModelToJson(TenantCategoryModel data) =>
    json.encode(data.toJson());

class TenantCategoryModel extends SmartModel {
  int id;
  String name;

  TenantCategoryModel({
    required this.id,
    required this.name,
  });

  factory TenantCategoryModel.fromJson(Map<String, dynamic> json) =>
      TenantCategoryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }
}

// To parse this JSON data, do
//
//     final tenantModel = tenantModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

TenantModel tenantModelFromJson(String str) => TenantModel.fromJson(json.decode(str));

String tenantModelToJson(TenantModel data) => json.encode(data.toJson());

class TenantModel extends SmartModel{
  int id;
  String name;

  TenantModel({
    required this.id,
    required this.name,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) => TenantModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  int getId() { return id;
  }

  @override
  String getName() { return name;
  }
}

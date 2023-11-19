// To parse this JSON data, do
//
//     final tenantTypeModel = tenantTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

TenantTypeModel tenantTypeModelFromJson(String str) => TenantTypeModel.fromJson(json.decode(str));

String tenantTypeModelToJson(TenantTypeModel data) => json.encode(data.toJson());

class TenantTypeModel extends SmartTenantTypeModel{
  int id;
  String name;

  TenantTypeModel({
    required this.id,
    required this.name,
  });

  factory TenantTypeModel.fromJson(Map<String, dynamic> json) => TenantTypeModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  String getName() { return name;
  }

  @override
  int getId() { return id;
  }



}

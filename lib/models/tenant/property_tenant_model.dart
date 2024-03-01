// To parse this JSON data, do
//
//     final propertyTenantModel = propertyTenantModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/tenant/tenant_model.dart';

PropertyTenantModel propertyTenantModelFromJson(String str) =>
    PropertyTenantModel.fromJson(json.decode(str));

String propertyTenantModelToJson(PropertyTenantModel data) =>
    json.encode(data.toJson());

class PropertyTenantModel {
  int? id;
  int? tenantId;
  int? unitId;
  dynamic amount;
  dynamic discount;
  TenantModel? tenantModel;

  PropertyTenantModel({
    this.id,
    this.tenantId,
    this.unitId,
    this.amount,
    this.discount,
    this.tenantModel,
  });

  factory PropertyTenantModel.fromJson(Map<String, dynamic> json) =>
      PropertyTenantModel(
        id: json["id"],
        tenantId: json["tenant_id"],
        unitId: json["unit_id"],
        amount: json["amount"],
        discount: json["discount"],
        tenantModel: json["tenants"] == null
            ? null
            : TenantModel.fromJson(json["tenants"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenant_id": tenantId,
        "unit_id": unitId,
        "amount": amount,
        "discount": discount,
        "tenants": tenantModel,
      };
}

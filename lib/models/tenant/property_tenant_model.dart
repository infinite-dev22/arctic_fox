// To parse this JSON data, do
//
//     final propertyTenantModel = propertyTenantModelFromJson(jsonString);

import 'dart:convert';

PropertyTenantModel propertyTenantModelFromJson(String str) => PropertyTenantModel.fromJson(json.decode(str));

String propertyTenantModelToJson(PropertyTenantModel data) => json.encode(data.toJson());

class PropertyTenantModel {
  int? id;
  int? tenantId;
  int? unitId;
  dynamic amount;
  dynamic discount;

  PropertyTenantModel({
    this.id,
    this.tenantId,
    this.unitId,
    this.amount,
    this.discount,
  });

  factory PropertyTenantModel.fromJson(Map<String, dynamic> json) => PropertyTenantModel(
    id: json["id"],
    tenantId: json["tenant_id"],
    unitId: json["unit_id"],
    amount: json["amount"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tenant_id": tenantId,
    "unit_id": unitId,
    "amount": amount,
    "discount": discount,
  };
}

// To parse this JSON data, do
//
//     final tenantUnitModel = tenantUnitModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

TenantUnitModel tenantUnitModelFromJson(String str) =>
    TenantUnitModel.fromJson(json.decode(str));

String tenantUnitModelToJson(TenantUnitModel data) =>
    json.encode(data.toJson());

class TenantUnitModel extends SmartTenantUnitModel {
  int id;
  dynamic createdAt;
  String createdBy;
  int tenantId;
  int unitId;
  dynamic fromDate;
  dynamic toDate;
  int amount;
  int discount;

  TenantUnitModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.tenantId,
    required this.unitId,
    required this.fromDate,
    required this.toDate,
    required this.amount,
    required this.discount,
  });

  factory TenantUnitModel.fromJson(Map<String, dynamic> json) =>
      TenantUnitModel(
        id: json["id"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        tenantId: json["tenant_id"],
        unitId: json["unit_id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        amount: json["amount"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "created_by": createdBy,
        "tenant_id": tenantId,
        "unit_id": unitId,
        "from_date": fromDate,
        "to_date": toDate,
        "amount": amount,
        "discount": discount,
      };

  @override
  int getAmount() {
    return amount;
  }

  @override
  int getDiscount() {
    return discount;
  }

  @override
  int getId() {
    return id;
  }

  @override
  int getTenantId() {
    return tenantId;
  }

  @override
  int getUnitId() {
    return unitId;
  }
}

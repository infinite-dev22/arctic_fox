// To parse this JSON data, do
//
//     final tenantPaymentModel = tenantPaymentModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/tenant/tenant_model.dart';
import 'package:smart_rent/models/unit/unit_model.dart';

TenantPaymentModel tenantPaymentModelFromJson(String str) => TenantPaymentModel.fromJson(json.decode(str));

String tenantPaymentModelToJson(TenantPaymentModel data) => json.encode(data.toJson());

class TenantPaymentModel {
  int? amount;
  int? paid;
  int? balance;
  int? unitId;
  dynamic fromDate;
  dynamic toDate;
  int? tenantId;
  TenantModel? tenantModel;
  UnitModel? unitModel;

  TenantPaymentModel({
    this.amount,
    this.paid,
    this.balance,
    this.unitId,
    this.fromDate,
    this.toDate,
    this.tenantId,
    this.tenantModel,
    this.unitModel,
  });

  factory TenantPaymentModel.fromJson(Map<String, dynamic> json) => TenantPaymentModel(
    amount: json["amount"],
    paid: json["paid"],
    balance: json["balance"],
    unitId: json["unit_id"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    tenantId: json["tenant_id"],
    tenantModel: json["tenants"] == null ? null : TenantModel.fromJson(json["tenants"]),
    unitModel: json["units"] == null ? null : UnitModel.fromJson(json["units"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "paid": paid,
    "balance": balance,
    "unit_id": unitId,
    "from_date": fromDate,
    "to_date": toDate,
    "tenant_id": tenantId,
    "tenants": tenantModel,
    "units": unitModel,

  };
}

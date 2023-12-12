// To parse this JSON data, do
//
//     final tenantPaymentModel = tenantPaymentModelFromJson(jsonString);

import 'dart:convert';

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

  TenantPaymentModel({
    this.amount,
    this.paid,
    this.balance,
    this.unitId,
    this.fromDate,
    this.toDate,
    this.tenantId,
  });

  factory TenantPaymentModel.fromJson(Map<String, dynamic> json) => TenantPaymentModel(
    amount: json["amount"],
    paid: json["paid"],
    balance: json["balance"],
    unitId: json["unit_id"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    tenantId: json["tenant_id"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "paid": paid,
    "balance": balance,
    "unit_id": unitId,
    "from_date": fromDate,
    "to_date": toDate,
    "tenant_id": tenantId,
  };
}

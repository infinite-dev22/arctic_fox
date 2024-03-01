// To parse this JSON data, do
//
//     final unitPropertyScheduleModel = unitPropertyScheduleModelFromJson(jsonString);

import 'dart:convert';

UnitPropertyScheduleModel unitPropertyScheduleModelFromJson(String str) =>
    UnitPropertyScheduleModel.fromJson(json.decode(str));

String unitPropertyScheduleModelToJson(UnitPropertyScheduleModel data) =>
    json.encode(data.toJson());

class UnitPropertyScheduleModel {
  int? id;
  String? fromDate;
  String? toDate;
  int? amount;
  int? balance;
  int? paid;
  int? tenantId;
  int? unitId;

  UnitPropertyScheduleModel({
    this.id,
    this.fromDate,
    this.toDate,
    this.amount,
    this.balance,
    this.paid,
    this.tenantId,
    this.unitId,
  });

  factory UnitPropertyScheduleModel.fromJson(Map<String, dynamic> json) =>
      UnitPropertyScheduleModel(
        id: json["id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        amount: json["amount"],
        balance: json["balance"],
        paid: json["paid"],
        tenantId: json["tenant_id"],
        unitId: json["unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_date": fromDate,
        "to_date": toDate,
        "amount": amount,
        "balance": balance,
        "paid": paid,
        "tenant_id": tenantId,
        "unit_id": unitId,
      };
}

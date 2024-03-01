// To parse this JSON data, do
//
//     final tenantUnitScheduleModel = tenantUnitScheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

List<TenantUnitScheduleModel> tenantUnitScheduleModelFromJson(String str) =>
    List<TenantUnitScheduleModel>.from(
        json.decode(str).map((x) => TenantUnitScheduleModel.fromJson(x)));

String tenantUnitScheduleModelToJson(List<TenantUnitScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TenantUnitScheduleModel extends SmartTenantUnitScheduleModel {
  int? id;
  int? amount;
  int? balance;
  int? paid;
  DateTime? fromDate;
  DateTime? toDate;
  Tenants? tenants;
  Units? units;
  int? unitId;
  int? tenantId;

  TenantUnitScheduleModel({
    this.id,
    this.amount,
    this.balance,
    this.paid,
    this.fromDate,
    this.toDate,
    this.tenants,
    this.units,
    this.unitId,
    this.tenantId,
  });

  factory TenantUnitScheduleModel.fromJson(Map<String, dynamic> json) =>
      TenantUnitScheduleModel(
        id: json["id"],
        amount: json["amount"],
        balance: json["balance"],
        paid: json["paid"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        tenants:
            json["tenants"] == null ? null : Tenants.fromJson(json["tenants"]),
        units: json["units"] == null ? null : Units.fromJson(json["units"]),
        unitId: json["unit_id"],
        tenantId: json["tenant_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "balance": balance,
        "paid": paid,
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "tenants": tenants?.toJson(),
        "units": units?.toJson(),
        "unit_id": unitId,
        "tenant_id": tenantId,
      };

  @override
  int getAmount() {
    return amount!;
  }

  @override
  int getBalance() {
    return balance!;
  }

  @override
  DateTime getFromDate() {
    return fromDate!;
  }

  @override
  int getId() {
    return id!;
  }

  @override
  int getPaid() {
    return paid!;
  }

  @override
  int getTenantId() {
    return tenantId!;
  }

  @override
  String getTenantName() {
    return tenants!.name.toString();
  }

  @override
  DateTime getToDate() {
    return toDate!;
  }

  @override
  int getUnitId() {
    return unitId!;
  }

  @override
  String getUnitNumber() {
    return units!.unitNumber.toString();
  }
}

class Tenants {
  String? name;

  Tenants({
    this.name,
  });

  factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Units {
  String? unitNumber;

  Units({
    this.unitNumber,
  });

  factory Units.fromJson(Map<String, dynamic> json) => Units(
        unitNumber: json["unit_number"],
      );

  Map<String, dynamic> toJson() => {
        "unit_number": unitNumber,
      };
}

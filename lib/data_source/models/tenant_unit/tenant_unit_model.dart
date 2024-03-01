// To parse this JSON data, do
//
//     final tenantUnitListModel = tenantUnitListModelFromJson(jsonString);

import 'dart:convert';

TenantUnitListModel tenantUnitListModelFromJson(String str) =>
    TenantUnitListModel.fromJson(json.decode(str));

String tenantUnitListModelToJson(TenantUnitListModel data) =>
    json.encode(data.toJson());

class TenantUnitListModel {
  List<TenantUnitModel>? tenantunitsonproperty;

  TenantUnitListModel({
    this.tenantunitsonproperty,
  });

  factory TenantUnitListModel.fromJson(Map<String, dynamic> json) =>
      TenantUnitListModel(
        tenantunitsonproperty: json["tenantunitsonproperty"] == null
            ? []
            : List<TenantUnitModel>.from(json["tenantunitsonproperty"]!
                .map((x) => TenantUnitModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tenantunitsonproperty": tenantunitsonproperty == null
            ? []
            : List<dynamic>.from(tenantunitsonproperty!.map((x) => x.toJson())),
      };
}

class TenantUnitModel {
  int? id;
  String? number;
  DateTime? fromDate;
  DateTime? toDate;
  int? amount;
  int? discountAmount;
  String? description;
  int? unitId;
  int? tenantId;
  int? scheduleId;
  int? propertyId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  TenantUnitModel({
    this.id,
    this.number,
    this.fromDate,
    this.toDate,
    this.amount,
    this.discountAmount,
    this.description,
    this.unitId,
    this.tenantId,
    this.scheduleId,
    this.propertyId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory TenantUnitModel.fromJson(Map<String, dynamic> json) =>
      TenantUnitModel(
        id: json["id"],
        number: json["number"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        amount: json["amount"],
        discountAmount: json["discount_amount"],
        description: json["description"],
        unitId: json["unit_id"],
        tenantId: json["tenant_id"],
        scheduleId: json["schedule_id"],
        propertyId: json["property_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "discount_amount": discountAmount,
        "description": description,
        "unit_id": unitId,
        "tenant_id": tenantId,
        "schedule_id": scheduleId,
        "property_id": propertyId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

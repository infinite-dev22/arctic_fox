// To parse this JSON data, do
//
//     final tenantProfileModel = tenantProfileModelFromJson(jsonString);

import 'dart:convert';

TenantProfileModel tenantProfileModelFromJson(String str) =>
    TenantProfileModel.fromJson(json.decode(str));

String tenantProfileModelToJson(TenantProfileModel data) =>
    json.encode(data.toJson());

class TenantProfileModel {
  int? id;
  DateTime? createdAt;
  String? createdBy;
  String? email;
  String? dateOfBirth;
  String? nin;
  String? gender;
  int? tenantId;
  String? description;
  String? contact;

  TenantProfileModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.email,
    this.dateOfBirth,
    this.nin,
    this.gender,
    this.tenantId,
    this.description,
    this.contact,
  });

  factory TenantProfileModel.fromJson(Map<String, dynamic> json) =>
      TenantProfileModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        nin: json["nin"],
        gender: json["gender"],
        tenantId: json["tenant_id"],
        description: json["description"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "email": email,
        "date_of_birth": dateOfBirth,
        "nin": nin,
        "gender": gender,
        "tenant_id": tenantId,
        "description": description,
        "contact": contact,
      };
}

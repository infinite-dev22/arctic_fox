// To parse this JSON data, do
//
//     final tenantProfileContactModel = tenantProfileContactModelFromJson(jsonString);

import 'dart:convert';

TenantProfileContactModel tenantProfileContactModelFromJson(String str) =>
    TenantProfileContactModel.fromJson(json.decode(str));

String tenantProfileContactModelToJson(TenantProfileContactModel data) =>
    json.encode(data.toJson());

class TenantProfileContactModel {
  int? id;
  int? tenantId;
  String? firstName;
  String? lastName;
  String? nin;
  String? designation;
  String? contact;
  String? email;

  TenantProfileContactModel({
    this.id,
    this.tenantId,
    this.firstName,
    this.lastName,
    this.nin,
    this.designation,
    this.contact,
    this.email,
  });

  factory TenantProfileContactModel.fromJson(Map<String, dynamic> json) =>
      TenantProfileContactModel(
        id: json["id"],
        tenantId: json["tenant_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nin: json["nin"],
        designation: json["designation"],
        contact: json["contact"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tenant_id": tenantId,
        "first_name": firstName,
        "last_name": lastName,
        "nin": nin,
        "designation": designation,
        "contact": contact,
        "email": email,
      };
}

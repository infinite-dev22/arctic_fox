// To parse this JSON data, do
//
//     final tenantDetailsModel = tenantDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_source/models/tenant/tenant_model.dart';

TenantDetailsModel tenantDetailsModelFromJson(String str) => TenantDetailsModel.fromJson(json.decode(str));

String tenantDetailsModelToJson(TenantDetailsModel data) => json.encode(data.toJson());

class TenantDetailsModel {
  int? id;
  String? number;
  int? clientTypeId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TenantType? tenantType;
  List<ClientProfile>? clientProfiles;

  TenantDetailsModel({
    this.id,
    this.number,
    this.clientTypeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.tenantType,
    this.clientProfiles,
  });

  factory TenantDetailsModel.fromJson(Map<String, dynamic> json) => TenantDetailsModel(
    id: json["id"],
    number: json["number"],
    clientTypeId: json["client_type_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    tenantType: json["client_type"] == null ? null : TenantType.fromJson(json["client_type"]),
    clientProfiles: json["client_profiles"] == null ? [] : List<ClientProfile>.from(json["client_profiles"]!.map((x) => ClientProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "client_type_id": clientTypeId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "client_type": tenantType?.toJson(),
    "client_profiles": clientProfiles == null ? [] : List<dynamic>.from(clientProfiles!.map((x) => x.toJson())),
  };
}

class ClientProfile {
  int? id;
  String? firstName;
  dynamic middleName;
  String? lastName;
  dynamic companyName;
  DateTime? dateOfBirth;
  int? gender;
  String? address;
  String? tin;
  String? number;
  dynamic email;
  String? nin;
  dynamic designation;
  dynamic description;
  int? clientId;
  int? nationId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ClientProfileContact>? clientProfileContacts;

  ClientProfile({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.companyName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.tin,
    this.number,
    this.email,
    this.nin,
    this.designation,
    this.description,
    this.clientId,
    this.nationId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.clientProfileContacts,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    companyName: json["company_name"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    address: json["address"],
    tin: json["tin"],
    number: json["number"],
    email: json["email"],
    nin: json["nin"],
    designation: json["designation"],
    description: json["description"],
    clientId: json["client_id"],
    nationId: json["nation_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    clientProfileContacts: json["client_profile_contacts"] == null ? [] : List<ClientProfileContact>.from(json["client_profile_contacts"]!.map((x) => ClientProfileContact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "company_name": companyName,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "address": address,
    "tin": tin,
    "number": number,
    "email": email,
    "nin": nin,
    "designation": designation,
    "description": description,
    "client_id": clientId,
    "nation_id": nationId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "client_profile_contacts": clientProfileContacts == null ? [] : List<dynamic>.from(clientProfileContacts!.map((x) => x.toJson())),
  };
}

class ClientProfileContact {
  int? id;
  String? value;
  dynamic description;
  int? contactTypeId;
  int? clientProfileId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  ClientProfileContact({
    this.id,
    this.value,
    this.description,
    this.contactTypeId,
    this.clientProfileId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory ClientProfileContact.fromJson(Map<String, dynamic> json) => ClientProfileContact(
    id: json["id"],
    value: json["value"],
    description: json["description"],
    contactTypeId: json["contact_type_id"],
    clientProfileId: json["client_profile_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "description": description,
    "contact_type_id": contactTypeId,
    "client_profile_id": clientProfileId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// class ClientType {
//   int? id;
//   String? name;
//   String? code;
//   String? description;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   ClientType({
//     this.id,
//     this.name,
//     this.code,
//     this.description,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ClientType.fromJson(Map<String, dynamic> json) => ClientType(
//     id: json["id"],
//     name: json["name"],
//     code: json["code"],
//     description: json["description"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "code": code,
//     "description": description,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }

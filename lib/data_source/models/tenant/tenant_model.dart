// To parse this JSON data, do
//
//     final tenantListModel = tenantListModelFromJson(jsonString);

import 'dart:convert';

TenantListModel tenantListModelFromJson(String str) => TenantListModel.fromJson(json.decode(str));

String tenantListModelToJson(TenantListModel data) => json.encode(data.toJson());

class TenantListModel {
  List<TenantModel>? clients;

  TenantListModel({
    this.clients,
  });

  factory TenantListModel.fromJson(Map<String, dynamic> json) => TenantListModel(
    clients: json["clients"] == null ? [] : List<TenantModel>.from(json["clients"]!.map((x) => TenantModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clients": clients == null ? [] : List<dynamic>.from(clients!.map((x) => x.toJson())),
  };
}

class TenantModel {
  int? id;
  String? number;
  int? clientTypeId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TenantType? clientType;

  TenantModel({
    this.id,
    this.number,
    this.clientTypeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.clientType,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) => TenantModel(
    id: json["id"],
    number: json["number"],
    clientTypeId: json["client_type_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    clientType: json["client_type"] == null ? null : TenantType.fromJson(json["client_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "client_type_id": clientTypeId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "client_type": clientType?.toJson(),
  };
}

class TenantType {
  int? id;
  String? name;
  String? code;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  TenantType({
    this.id,
    this.name,
    this.code,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory TenantType.fromJson(Map<String, dynamic> json) => TenantType(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    description: json["description"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "description": description,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

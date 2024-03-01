// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

List<RoleModel> roleModelFromJson(String str) =>
    List<RoleModel>.from(json.decode(str).map((x) => RoleModel.fromJson(x)));

String roleModelToJson(List<RoleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoleModel extends SmartModel {
  int? id;
  String? name;
  String? guardName;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  RoleModel({
    this.id,
    this.name,
    this.guardName,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  int getId() {
    return id!;
  }

  @override
  String getName() {
    return name!;
  }
}

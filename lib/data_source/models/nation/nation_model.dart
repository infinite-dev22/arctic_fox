// To parse this JSON data, do
//
//     final nationModel = nationModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

List<NationModel> nationModelFromJson(String str) => List<NationModel>.from(
    json.decode(str).map((x) => NationModel.fromJson(x)));

String nationModelToJson(List<NationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NationModel extends SmartModel {
  int? id;
  String? code;
  String? name;
  dynamic description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  NationModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory NationModel.fromJson(Map<String, dynamic> json) => NationModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        description: json["description"],
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
        "code": code,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
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

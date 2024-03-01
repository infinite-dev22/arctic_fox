// To parse this JSON data, do
//
//     final userRoleModel = userRoleModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

List<UserRoleModel> userRoleModelFromJson(String str) =>
    List<UserRoleModel>.from(
        json.decode(str).map((x) => UserRoleModel.fromJson(x)));

String userRoleModelToJson(List<UserRoleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRoleModel extends SmartUserRoleModel {
  int? id;
  String? name;
  String? description;

  UserRoleModel({
    this.id,
    this.name,
    this.description,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };

  @override
  String getDescription() {
    return description.toString();
  }

  @override
  int getId() {
    return id!;
  }

  @override
  String getName() {
    return name.toString();
  }
}

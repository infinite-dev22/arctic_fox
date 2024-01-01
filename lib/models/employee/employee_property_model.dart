// To parse this JSON data, do
//
//     final employeePropertyModel = employeePropertyModelFromJson(jsonString);

import 'dart:convert';

EmployeePropertyModel employeePropertyModelFromJson(String str) => EmployeePropertyModel.fromJson(json.decode(str));

String employeePropertyModelToJson(EmployeePropertyModel data) => json.encode(data.toJson());

class EmployeePropertyModel {
  int? id;
  String? userId;
  int? roleId;
  int? organizationId;
  int? propertyId;

  EmployeePropertyModel({
    this.id,
    this.userId,
    this.roleId,
    this.organizationId,
    this.propertyId,
  });

  factory EmployeePropertyModel.fromJson(Map<String, dynamic> json) => EmployeePropertyModel(
    id: json["id"],
    userId: json["user_id"],
    roleId: json["role_id"],
    organizationId: json["organization_id"],
    propertyId: json["property_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "role_id": roleId,
    "organization_id": organizationId,
    "property_id": propertyId,
  };
}

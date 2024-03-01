// To parse this JSON data, do
//
//     final employeePropertyModel = employeePropertyModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';
import 'package:smart_rent/models/property/property_model.dart';

EmployeePropertyModel employeePropertyModelFromJson(String str) =>
    EmployeePropertyModel.fromJson(json.decode(str));

String employeePropertyModelToJson(EmployeePropertyModel data) =>
    json.encode(data.toJson());

class EmployeePropertyModel extends SmartEmployeePropertyModel {
  int? id;
  String? userId;
  int? roleId;
  int? organizationId;
  int? propertyId;
  PropertyModel? properties;

  EmployeePropertyModel({
    this.id,
    this.userId,
    this.roleId,
    this.organizationId,
    this.propertyId,
    this.properties,
  });

  factory EmployeePropertyModel.fromJson(Map<String, dynamic> json) =>
      EmployeePropertyModel(
        id: json["id"],
        userId: json["user_id"],
        roleId: json["role_id"],
        organizationId: json["organization_id"],
        propertyId: json["property_id"],
        properties: json["properties"] == null
            ? null
            : PropertyModel.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role_id": roleId,
        "organization_id": organizationId,
        "property_id": propertyId,
        "properties": properties?.toJson(),
      };

  @override
  int getId() {
    return id!;
  }

  @override
  int getOrganizationId() {
    return organizationId!;
  }

  @override
  int getPropertyId() {
    return propertyId!;
  }

  @override
  String getPropertyLocation() {
    return properties!.location.toString();
  }

  @override
  String getPropertyName() {
    return properties!.name.toString();
  }

  @override
  int getRoleId() {
    return roleId!;
  }

  @override
  String getUserId() {
    return userId!;
  }
}

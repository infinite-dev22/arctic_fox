// To parse this JSON data, do
//
//     final propertyTypeModel = propertyTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/models/general/smart_model.dart';

PropertyTypeModel propertyTypeModelFromJson(String str) =>
    PropertyTypeModel.fromJson(json.decode(str));

String propertyTypeModelToJson(PropertyTypeModel data) =>
    json.encode(data.toJson());

class PropertyTypeModel extends SmartModel {
  int id;
  String name;

  PropertyTypeModel({
    required this.id,
    required this.name,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) =>
      PropertyTypeModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }
}

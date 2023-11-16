// To parse this JSON data, do
//
//     final propertyCategoryModel = propertyCategoryModelFromJson(jsonString);

import 'dart:convert';

import '../general/smart_model.dart';

PropertyCategoryModel propertyCategoryModelFromJson(String str) =>
    PropertyCategoryModel.fromJson(json.decode(str));

String propertyCategoryModelToJson(PropertyCategoryModel data) =>
    json.encode(data.toJson());

class PropertyCategoryModel extends SmartModel {
  int id;
  String name;

  PropertyCategoryModel({
    required this.id,
    required this.name,
  });

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) =>
      PropertyCategoryModel(
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
